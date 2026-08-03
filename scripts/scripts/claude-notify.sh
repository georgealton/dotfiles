#!/usr/bin/env bash

set -uo pipefail

input=$(cat)

field() {
    jq -r "$1" <<<"$input"
}

event=$(field '.hook_event_name // "unknown"')
session=$(field '.session_id // "default"' | tr -cd '[:alnum:]_-')
cwd=$(field '.cwd // ""')

project="${cwd##*/}"
project="${project:-claude}"

dir="${XDG_RUNTIME_DIR:-/tmp}/claude-code-notify"
state="$dir/$session.json"
notification_id="$dir/$session.id"
lock="$dir/$session.lock"

mkdir -p "$dir"

init_state() {
    [[ -f "$state" ]] && return

    jq -n '{
        prompt: "",
        tasks: {},
        agents: {}
    }' >"$state"
}

reset_state() {
    local prompt="$1"

    jq -n \
        --arg prompt "$prompt" \
        '{
            prompt: $prompt,
            tasks: {},
            agents: {}
        }' >"$state"
}

update_state() {
    local filter="$1"
    shift

    jq "$@" "$filter" "$state" >"$state.tmp" &&
        mv "$state.tmp" "$state"
}

set_task() {
    local id="$1"
    local subject="$2"
    local status="$3"

    update_state \
        --arg id "$id" \
        --arg subject "$subject" \
        --arg status "$status" \
        '.tasks[$id] = {
            subject: $subject,
            status: $status
        }'
}

complete_task() {
    local id="$1"

    update_state \
        --arg id "$id" \
        'if .tasks[$id]
         then .tasks[$id].status = "completed"
         else .
         end'
}

set_agent() {
    local id="$1"
    local name="$2"
    local status="$3"

    update_state \
        --arg id "$id" \
        --arg name "$name" \
        --arg status "$status" \
        '.agents[$id] = {
            name: $name,
            status: $status
        }'
}

complete_agent() {
    local id="$1"

    update_state \
        --arg id "$id" \
        'if .agents[$id]
         then .agents[$id].status = "completed"
         else .
         end'
}

render() {
    jq -r '
        def lines($items; $field):
            $items
            | to_entries
            | map(
                (if .value.status == "completed"
                 then "✓ "
                 else "• "
                 end)
                + .value[$field]
              )
            | join("\n");

        [
            (if .prompt != ""
             then "🟡 " + .prompt
             else empty
             end),

            (if (.tasks | length) > 0
             then "\nTasks\n" + lines(.tasks; "subject")
             else empty
             end),

            (if (.agents | length) > 0
             then "\nAgents\n" + lines(.agents; "name")
             else empty
             end)
        ]
        | join("\n")
    ' "$state"
}

notify() {
    local urgency="$1"
    local timeout="$2"
    local body="$3"
    local icon="${4:-system-run}"

    local old_id
    old_id=$(cat "$notification_id" 2>/dev/null || echo 0)

    local new_id
    new_id=$(
        notify-send \
            --app-name="Claude Code" \
            --urgency="$urgency" \
            --expire-time="$timeout" \
            --icon="$icon" \
            --replace-id="$old_id" \
            --print-id \
            "Claude Code · $project" \
            "$body" \
            2>/dev/null
    )

    if [[ "$new_id" =~ ^[0-9]+$ ]]; then
        printf '%s\n' "$new_id" >"$notification_id"
    fi
}

on_prompt() {
    reset_state "$(field '.prompt // ""')"
    notify normal 0 "$(render)"
}

on_task_created() {
    local id subject

    id=$(field '.task_id // empty')
    subject=$(field '.task_subject // "New task"')

    [[ -z "$id" ]] && return

    set_task "$id" "$subject" running
    notify normal 0 "$(render)"
}

on_task_completed() {
    local id

    id=$(field '.task_id // empty')
    [[ -z "$id" ]] && return

    complete_task "$id"
    notify normal 0 "$(render)"
}

on_agent_started() {
    local id name

    id=$(field '.agent_id // empty')
    name=$(field '.agent_type // "subagent"')

    [[ -z "$id" ]] && return

    set_agent "$id" "$name" running
    notify normal 0 "$(render)"
}

on_agent_stopped() {
    local id

    id=$(field '.agent_id // empty')
    [[ -z "$id" ]] && return

    complete_agent "$id"
    notify normal 0 "$(render)"
}

on_permission_request() {
    local tool detail

    tool=$(field '.tool_name // "Tool"')

    case "$tool" in
    Bash)
        detail=$(field '.tool_input.command // "Command"')
        ;;
    *)
        detail=$(field '.tool_input | tostring')
        ;;
    esac

    notify \
        critical \
        0 \
        "⚠ Permission required

$tool

$detail" \
        dialog-warning
}

on_notification() {
    local title message type

    title=$(field '.title // "Claude Code"')
    message=$(field '.message // ""')
    type=$(field '.notification_type // ""')

    [[ "$type" == "permission_prompt" ]] && return

    notify \
        normal \
        10000 \
        "$title

$message" \
        dialog-information
}

on_stop() {
    local message

    message=$(field '.last_assistant_message // ""')

    if [[ -n "$message" ]]; then
        message="✅ Completed

$message"
    else
        message="✅ Claude finished"
    fi

    notify normal 8000 "$message" emblem-default
}

on_stop_failure() {
    local error details

    error=$(field '.error // "unknown"')
    details=$(field \
        '.error_details // .last_assistant_message // "Claude stopped because of an API error"')

    notify \
        critical \
        0 \
        "❌ Claude failed

$error

$details" \
        dialog-error
}

on_session_end() {
    rm -f "$state" "$notification_id"
}

case "$event" in
SessionEnd)
    (
        flock -x 9
        on_session_end
    ) 9>"$lock"
    ;;

*)
    (
        flock -x 9
        init_state

        case "$event" in
        UserPromptSubmit) on_prompt ;;
        TaskCreated) on_task_created ;;
        TaskCompleted) on_task_completed ;;
        SubagentStart) on_agent_started ;;
        SubagentStop) on_agent_stopped ;;
        PermissionRequest) on_permission_request ;;
        Notification) on_notification ;;
        Stop) on_stop ;;
        StopFailure) on_stop_failure ;;
        *) ;;
        esac
    ) 9>"$lock"
    ;;
esac

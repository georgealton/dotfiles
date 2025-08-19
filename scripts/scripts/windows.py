#!/bin/python3
from argparse import ArgumentParser
import subprocess
import json


def get_windows():
    command = "swaymsg -t get_tree"
    process = subprocess.Popen(
        command,
        shell=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
    )
    data = json.loads(process.communicate()[0])

    windows = []
    for output in data["nodes"]:
        # The scratchpad (under __i3) is not supported
        if output.get("name") != "__i3" and output.get("type") == "output":
            workspaces = output.get("nodes")
            for ws in workspaces:
                if ws.get("type") == "workspace":
                    windows += extract_nodes_iterative(ws)
    return windows


def extract_nodes_iterative(workspace):
    all_nodes = []
    floating_nodes = workspace.get("floating_nodes")
    for floating_node in floating_nodes:
        all_nodes.append(floating_node)

    nodes = workspace.get("nodes")
    for node in nodes:
        if len(node.get("nodes")) == 0:
            all_nodes.append(node)
        else:
            for inner_node in node.get("nodes"):
                nodes.append(inner_node)

    return all_nodes


def parse_windows(windows):
    parsed_windows = []
    for window in windows:
        name = window.get("name", "")
        app_id = window.get("app_id", "") or ""
        app_id = app_id.split(".")[-1]
        parsed_windows.append(f"{app_id:<13} | {name}")
    return parsed_windows


def build_wofi_string(windows):
    enter = "\n"
    return enter.join(windows).encode("UTF-8")


def show_wofi(windows):
    command = 'wofi -p "Windows: " -d -i --hide-scroll'
    process = subprocess.Popen(
        command,
        shell=True,
        stdin=subprocess.PIPE,
        stdout=subprocess.PIPE,
    )
    return process.communicate(input=windows)[0]


def parse_id(windows, parsed_windows, selected):
    selected = (selected.decode("UTF-8"))[:-1]  # Remove new line character
    window_index = int(parsed_windows.index(selected))
    return str(windows[window_index].get("id"))


def switch_window(id):
    command = "swaymsg [con_id={}] focus".format(id)
    process = subprocess.Popen(command, shell=True, stdout=subprocess.PIPE)
    process.communicate()[0]


if __name__ == "__main__":
    parser = ArgumentParser(description="Wofi based window switcher")
    windows = get_windows()
    parsed_windows = parse_windows(windows)
    wofi_string = build_wofi_string(parsed_windows)
    selected = show_wofi(wofi_string)
    selected_id = parse_id(windows, parsed_windows, selected)
    switch_window(selected_id)

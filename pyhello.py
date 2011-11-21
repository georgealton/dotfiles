#!/usr/bin/env python

# Pharos command line control panel
#
# The Pharos command line control program is designed to aid Pharos engineers 
# when working on systems. The aim is to make the configuration and
# troubleshooting of systems friendlier, faster and more effective.

# MODULES
# Standard Library
try:
    import os
    import time
    import wave
    import filecmp
    import xml.etree.ElementTree as xml
    import tarfile
    import curses
except ImportError:
    print("\n\tFATAL ERROR: A Module Failed To Load")
    print("\tExiting...\n")
    time.sleep(3)
    quit()

# CONSTANTS
TITLE = " [ Codename: Grendel ] "
CLOSEBUTTON = "[X]"
BORDERWIDTH = 2
MENUSPACE = 0
FILEMENUY = 2
HOSTNAME = os.uname()

# MENUS 
FILE_MENU = "[ Config ]", "[ Database ]", "[ Software ]", "[ Options ]"
CONFIG_MENU = "Machine Config", "Sentinel", "Action 3", "Action 4", "Action 5", "Action 6"
DATABASE_MENU = "Action 1", "Action 2", "Action 3"
SOFTWARE_MENU = "Action 1", "Action 2", "Action 3"
OPTIONS_MENU = "Time Format", "Background Colours", "Machine Info"

# testing!
DOCPATH = "xmltest.xml"

def main():

    dropDownVisible = 0

    def CreateWindow(winName):
        winName = curses.initscr()
        curses.start_color()
        if curses.has_colors():
            curses.init_pair(1, curses.COLOR_YELLOW, curses.COLOR_RED)
            curses.init_pair(2, curses.COLOR_GREEN, curses.COLOR_BLACK)
            curses.init_pair(3, curses.COLOR_RED, curses.COLOR_BLACK)
            curses.init_pair(4, curses.COLOR_YELLOW, curses.COLOR_RED)
            curses.init_pair(5, curses.COLOR_YELLOW, curses.COLOR_RED)
        curses.noecho()
        curses.mousemask(curses.ALL_MOUSE_EVENTS)
        return winName

    def endProgram():
        mainWindow.keypad(0)
        mainWindow.clear()
        curses.endwin()
        quit()

    def listStringLength(aList):
      totalLength = 0
      for string in aList:
            currentLength = len(string)
            totalLength += currentLength
      return totalLength

    def drawDefaults():
        """
        
        Draws the borders, title string, file menu and status bar and returns the location of the file menu as a list of tuples 

        """
        mainWindowSize = mainWindow.getmaxyx()
        mainWindow.border(0)
        if mainWindowSize[0] > 4:
            # top bar, this is where the FILE_MENU goes 
            mainWindow.hline(BORDERWIDTH, 1, curses.ACS_HLINE, int(mainWindowSize[1] - BORDERWIDTH))
            #status bar
            mainWindow.hline(int(mainWindowSize[0] - (BORDERWIDTH + 1)), 1, curses.ACS_HLINE, int(mainWindowSize[1] - BORDERWIDTH))
            # get the name of the current server
            ServerName = "Server: " + HOSTNAME[1] 
            mainWindow.addstr(mainWindowSize[0] - BORDERWIDTH, 1, ServerName)
            # add time to the bottom right
            mainWindow.addstr(mainWindowSize[0] - BORDERWIDTH, mainWindowSize[1] - (len(getCurrentTime()) + 2 ), getCurrentTime())
            
        if len(TITLE) + len(CLOSEBUTTON) < mainWindowSize[1]:
            mainWindow.addstr(0, int((mainWindowSize[1] / 2) - (len(TITLE) / 2)), TITLE, curses.A_REVERSE)
            mainWindow.addstr(0, int((mainWindowSize[1] - (len(CLOSEBUTTON)) ) - (len(CLOSEBUTTON) / 2) ), CLOSEBUTTON, curses.A_REVERSE)
        
        if len(str(FILE_MENU)) < mainWindowSize[1] and mainWindowSize[0] > 20:
            counter = 0
            for fileMenuItem in FILE_MENU:
                if counter < 1:
                    fileMenuLocs = [(2, BORDERWIDTH)]
                    mainWindow.addstr(2, fileMenuLocs[0][1], fileMenuItem, curses.A_REVERSE)
                else:
                    currentListSlice = FILE_MENU[0:counter]
                    fileMenuLocs.append((2, BORDERWIDTH + listStringLength(currentListSlice) + counter * MENUSPACE))
                    mainWindow.addstr(2, fileMenuLocs[counter][1], fileMenuItem, curses.A_REVERSE)
                counter += 1
        else:
            fileMenuLocs = 0
        mainWindow.refresh()
        return fileMenuLocs

    def createDropDown(dropDownMenuName, x):
        dropDownHeight = len(dropDownMenuName) + 2
        dropDownWidth = len(max(dropDownMenuName,key=len)) + BORDERWIDTH + 2
        dropDown = mainWindow.subwin(dropDownHeight, dropDownWidth, FILEMENUY + 1, x)
        dropDown.border(0)
        
        actionListStartY = 1
        for menuAction in dropDownMenuName:
            dropDown.addstr(actionListStartY, 1, menuAction)
            actionListStartY += 1
        return dropDown

    def removeDropDown(dropDownName):
        del dropDownName
        mainWindow.touchwin()
        mainWindow.clear()
        mainWindow.refresh()
        return 0
        
    def createAlertBox():
        alertBox = mainWindow.subwin()

    def getCurrentTime(timeFormat = "%H:%M:%S"):
        currentTime = time.strftime(timeFormat)
        return currentTime

    def tarTheConfig():
        # easily add the current config to a tar file for backup purposes
        pass

    def XML(document):
        """The XML function parses configuration files to extract information
        
        Takes a path to a Pharos XML as an argument and perfoms xml actions on that file
        
        """
        try:
            machineConfigXML = xml.parse(document)
        except:
            mainWindow.addstr(10, 10, "Unable to read machine-config.xml")
            return 1
            
        machineConfig = machineConfigXML.getroot()
        netFS = machineConfig.find("networkFilesystems")
        importSection = netFS.findall("import")
        
        mountList = []
        
        for mountSettings in importSection:
            mounts = {}
            for settings in mountSettings:
                uid = 1
                if mounts.has_key(settings.tag):
                    settings.tag += str(uid) 
                    uid += 1
                mounts[settings.tag] = settings.text
            mountList.append(mounts)

        #if document == MachineConfig:             
        yPosOffset = 0
        mountErrorAll = [] 
        if mountList:
            mainWindow.addstr(4, 2, "[ Mount Status Listing ]", curses.A_REVERSE)
            for mountDicts in mountList:
                mountPath = mountDicts.get('mountPoint')
                mountStatus = os.path.ismount(mountPath) 
                if mountStatus == False:
                    mainWindow.addstr(5 + yPosOffset, 2, "ERROR: ", curses.A_BOLD)
                    mainWindow.addstr(5 + yPosOffset, 2 + len("ACTIVE: "), mountPath, curses.color_pair(3))
                elif mountStatus:
                    mainWindow.addstr(5 + yPosOffset, 2,"ACTIVE: ", curses.A_BOLD)
                    mainWindow.addstr(5 + yPosOffset, 2 + len("ACTIVE: "), mountPath, curses.color_pair(2))
                    mountErrorAll.append(mountPath)       
                yPosOffset += 1
        else:
            mainWindow.addstr(4, 2, "No Mounts In Machine Config ", curses.A_REVERSE)

    # INITIALISE THE MAIN WINDOW
    mainWindow = CreateWindow(main)
    mainWindow.clear()
    mainWindow.refresh()
    mainWindow.keypad(1)
    mainWindow.nodelay(1)
    drawDefaults()

    while 1:
        time.sleep(0.05)
        mainWindowSize = mainWindow.getmaxyx()
        fileMenuLocs = drawDefaults()

        # KEYPRESS INPUT HANDLING        
        commandKey = mainWindow.getch()    
    
        if commandKey == ord("m"):
            XML(DOCPATH)
            mainWindow.refresh
        elif commandKey == ord("h"):
            mainWindow.addstr(3, 1, "press 'q' to quit")
        elif commandKey == ord("x"):
            mainWindow.bkgd(ord(" "), curses.color_pair(2))
        elif commandKey == ord("q"):
            endProgram() 
        elif commandKey == curses.KEY_RESIZE:
            mainWindow.erase()
            fileMenuLocs = drawDefaults()
        elif commandKey == curses.KEY_MOUSE:
            mouseEvent = curses.getmouse()
            if mouseEvent[4] == curses.BUTTON1_CLICKED:
               # only do this if the file menu is visible
                if len(str(FILE_MENU)) < mainWindowSize[1]: 
                    # handle mouseevents outside of the file menu first
                    if mouseEvent[1] not in range(fileMenuLocs[0][1], len(FILE_MENU[1]) + MENUSPACE) and mouseEvent and dropDownVisible == 1:
                        dropDownVisible = removeDropDown(dropDown)
                    # handle mouse events on the file menu
                    if mouseEvent[1] in range(fileMenuLocs[0][1], len(FILE_MENU[1]) + MENUSPACE) and mouseEvent[2] == 2:
                        if not dropDownVisible:
                            dropDown = createDropDown(CONFIG_MENU, fileMenuLocs[0][1])
                            dropDownVisible = True 
                        else:
                            dropDownVisible = removeDropDown(dropDown)
                            dropDown = createDropDown(CONFIG_MENU, fileMenuLocs[0][1])
                            dropDownVisible = True
                    elif mouseEvent[1] in range(fileMenuLocs[1][1], fileMenuLocs[1][1] + len(FILE_MENU[1]) + MENUSPACE) and mouseEvent[2] == 2:
                        if not dropDownVisible:
                            dropDown = createDropDown(DATABASE_MENU, fileMenuLocs[1][1])
                            dropDownVisible = True
                        else:
                            dropDownVisible = removeDropDown(dropDown)
                            dropDown = createDropDown(DATABASE_MENU, fileMenuLocs[1][1])
                            dropDownVisible = True
                    elif mouseEvent[1] in range(fileMenuLocs[2][1], fileMenuLocs[2][1] + len(FILE_MENU[1]) + MENUSPACE) and mouseEvent[2] == 2:
                        if not dropDownVisible:
                            dropDown = createDropDown(SOFTWARE_MENU, fileMenuLocs[2][1])
                            dropDownVisible = True
                        else:
                            dropDownVisible = removeDropDown(dropDown)
                            dropDown = createDropDown(SOFTWARE_MENU, fileMenuLocs[2][1])
                            dropDownVisible = True
                    elif mouseEvent[1] in range(fileMenuLocs[3][1], fileMenuLocs[3][1] + len(FILE_MENU[1]) + MENUSPACE) and mouseEvent[2] == 2:
                        if not dropDownVisible:
                            dropDown = createDropDown(OPTIONS_MENU, fileMenuLocs[3][1])
                            dropDownVisible = True
                        else:
                            dropDownVisible = removeDropDown(dropDown)
                            dropDown = createDropDown(OPTIONS_MENU, fileMenuLocs[3][1])
                            dropDownVisible = True
curses.wrapper(main())

# Windows Installers

My plan is to make the DK utilities ask the user about which 3rd party utilities the user desires for file editing.
For map editing this will (for now) always be Kthura (when there's only one candidate, there's only one choice).
                             
The other software will be:
- Audacity (for audio edit)
- GIMP (for graphics edit)
- ZeroBrane Studios (for script editing)
- Geanny (for general text editing)

The plan is to use chocolatey to install all programs. On Mac I'm using Python as manager, which will for Windows not be an option as Python is not installed there by default. Windows will therefore need a seperate pre-compiled exe file (as batch will not fill the bill) and this file may be written in either Pascal or BlitzMax, although a few other means are also an option.
Please note this is all optional, the user can back out if he/she wants and the system will never ask it again.
(Well unless the configuration file is deleted, that is).

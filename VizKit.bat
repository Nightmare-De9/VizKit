@echo off
setlocal EnableExtensions EnableDelayedExpansion
title USB Toolbox - Viz Edition
set "ROOT=%~dp0"
if "%ROOT:~-1%"=="\" set "ROOT=%ROOT:~0,-1%"
set "LOGDIR=%ROOT%\Logs"
if not exist "%LOGDIR%" md "%LOGDIR%" >nul 2>&1

set "BANNER1=           $$\           $$\   $$\ $$\   $$\     $$$$$$$\   $$$$$$\  "
set "BANNER2=           \__|          $$ | $$  |\__|  $$ |    $$  ____| $$$ __$$\ "
set "BANNER3=$$\    $$\ $$\ $$$$$$$$\ $$ |$$  / $$\ $$$$$$\   $$ |      $$$$\ $$ |"
set "BANNER4=\$$\  $$  |$$ |\____$$  |$$$$$  /  $$ |\_$$  _|  $$$$$$$\  $$\$$\$$ |"
set "BANNER5= \$$\$$  / $$ |  $$$$ _/ $$  $$<   $$ |  $$ |    \_____$$\ $$ \$$$$ |"
set "BANNER6=  \$$$  /  $$ | $$  _/   $$ |\$$\  $$ |  $$ |$$\ $$\   $$ |$$ |\$$$ |"
set "BANNER7=   \$  /   $$ |$$$$$$$$\ $$ | \$$\ $$ |  \$$$$  |\$$$$$$  |\$$$$$$  /"
set "BANNER8=    \_/    \__|\________|\__|  \__|\__|   \____/  \______/  \______/"

:menu
cls
echo %BANNER1%
echo %BANNER2%
echo %BANNER3%
echo %BANNER4%
echo %BANNER5%
echo %BANNER6%
echo %BANNER7%
echo %BANNER8%
echo.
echo                         Made by Viz
echo.
echo Root: %ROOT%
echo.
echo   1. Show USB root
echo   2. Show Logs folder
echo   3. Open Command Prompt
echo   4. Open PowerShell
echo   5. Open Windows Terminal
echo   6. Notepad
echo   7. Calculator
echo   8. Paint
echo   9. Task Manager
echo  10. Registry Editor
echo  11. Control Panel
echo  12. Settings
echo  13. File Explorer
echo  14. System Information
echo  15. Device Manager
echo  16. Disk Management
echo  17. Services
echo  18. Event Viewer
echo  19. Task Scheduler
echo  20. Computer Management
echo  21. Resource Monitor
echo  22. Performance Monitor
echo  23. Disk Cleanup
echo  24. Optimize Drives
echo  25. Character Map
echo  26. On-Screen Keyboard
echo  27. Magnifier
echo  28. Snipping Tool
echo  29. Sticky Notes
echo  30. Remote Desktop
echo  31. Quick Assist
echo  32. DiskPart
echo  33. CHKDSK Info
echo  34. System File Checker
echo  35. DISM Help
echo  36. Driver Query
echo  37. Who Am I
echo  38. System Info
echo  39. Hostname
echo  40. Windows Version
echo  41. Environment Variables
echo  42. Running Processes
echo  43. Services List
echo  44. Startup Folder
echo  45. Temp Folder
echo  46. Users Folder
echo  47. Desktop Folder
echo  48. Documents Folder
echo  49. Downloads Folder
echo  50. Pictures Folder
echo  51. Videos Folder
echo  52. Music Folder
echo  53. Network Connections
echo  54. Internet Properties
echo  55. Mouse Settings
echo  56. Keyboard Settings
echo  57. Sound Settings
echo  58. Date and Time
echo  59. Power Options
echo  60. Firewall
echo  61. Windows Security
echo  62. Defender Scan
echo  63. Windows Update
echo  64. Network Status
echo  65. Bluetooth Settings
echo  66. Storage Settings
echo  67. Apps & Features
echo  68. Privacy Settings
echo  69. Accounts Settings
echo  70. Accessibility Settings
echo  71. About This PC
echo  72. Common Control Panel
echo  73. System Properties
echo  74. Advanced System Properties
echo  75. Credentials Manager
echo  76. Backup and Restore
echo  77. Programs and Features
echo  78. Folder Options
echo  79. User Accounts
echo  80. Local Users and Groups
echo  81. Group Policy Editor
echo  82. Windows Features
echo  83. Defragment/Optimize
echo  84. Print Management
echo  85. Color Management
echo  86. Device Installation Settings
echo  87. Windows Memory Diagnostic
echo  88. Network Diagnostics
echo  89. Help and Support
echo.
echo  L. Open Logs   R. Refresh   X. Exit
echo.
set /p "CHOICE=Select an option: "
if /i "%CHOICE%"=="X" exit /b
if /i "%CHOICE%"=="R" goto menu
if /i "%CHOICE%"=="L" start "" explorer "%LOGDIR%" & goto menu
if "%CHOICE%"=="1" goto tool01
if "%CHOICE%"=="2" goto tool02
if "%CHOICE%"=="3" goto tool03
if "%CHOICE%"=="4" goto tool04
if "%CHOICE%"=="5" goto tool05
if "%CHOICE%"=="6" goto tool06
if "%CHOICE%"=="7" goto tool07
if "%CHOICE%"=="8" goto tool08
if "%CHOICE%"=="9" goto tool09
if "%CHOICE%"=="10" goto tool10
if "%CHOICE%"=="11" goto tool11
if "%CHOICE%"=="12" goto tool12
if "%CHOICE%"=="13" goto tool13
if "%CHOICE%"=="14" goto tool14
if "%CHOICE%"=="15" goto tool15
if "%CHOICE%"=="16" goto tool16
if "%CHOICE%"=="17" goto tool17
if "%CHOICE%"=="18" goto tool18
if "%CHOICE%"=="19" goto tool19
if "%CHOICE%"=="20" goto tool20
if "%CHOICE%"=="21" goto tool21
if "%CHOICE%"=="22" goto tool22
if "%CHOICE%"=="23" goto tool23
if "%CHOICE%"=="24" goto tool24
if "%CHOICE%"=="25" goto tool25
if "%CHOICE%"=="26" goto tool26
if "%CHOICE%"=="27" goto tool27
if "%CHOICE%"=="28" goto tool28
if "%CHOICE%"=="29" goto tool29
if "%CHOICE%"=="30" goto tool30
if "%CHOICE%"=="31" goto tool31
if "%CHOICE%"=="32" goto tool32
if "%CHOICE%"=="33" goto tool33
if "%CHOICE%"=="34" goto tool34
if "%CHOICE%"=="35" goto tool35
if "%CHOICE%"=="36" goto tool36
if "%CHOICE%"=="37" goto tool37
if "%CHOICE%"=="38" goto tool38
if "%CHOICE%"=="39" goto tool39
if "%CHOICE%"=="40" goto tool40
if "%CHOICE%"=="41" goto tool41
if "%CHOICE%"=="42" goto tool42
if "%CHOICE%"=="43" goto tool43
if "%CHOICE%"=="44" goto tool44
if "%CHOICE%"=="45" goto tool45
if "%CHOICE%"=="46" goto tool46
if "%CHOICE%"=="47" goto tool47
if "%CHOICE%"=="48" goto tool48
if "%CHOICE%"=="49" goto tool49
if "%CHOICE%"=="50" goto tool50
if "%CHOICE%"=="51" goto tool51
if "%CHOICE%"=="52" goto tool52
if "%CHOICE%"=="53" goto tool53
if "%CHOICE%"=="54" goto tool54
if "%CHOICE%"=="55" goto tool55
if "%CHOICE%"=="56" goto tool56
if "%CHOICE%"=="57" goto tool57
if "%CHOICE%"=="58" goto tool58
if "%CHOICE%"=="59" goto tool59
if "%CHOICE%"=="60" goto tool60
if "%CHOICE%"=="61" goto tool61
if "%CHOICE%"=="62" goto tool62
if "%CHOICE%"=="63" goto tool63
if "%CHOICE%"=="64" goto tool64
if "%CHOICE%"=="65" goto tool65
if "%CHOICE%"=="66" goto tool66
if "%CHOICE%"=="67" goto tool67
if "%CHOICE%"=="68" goto tool68
if "%CHOICE%"=="69" goto tool69
if "%CHOICE%"=="70" goto tool70
if "%CHOICE%"=="71" goto tool71
if "%CHOICE%"=="72" goto tool72
if "%CHOICE%"=="73" goto tool73
if "%CHOICE%"=="74" goto tool74
if "%CHOICE%"=="75" goto tool75
if "%CHOICE%"=="76" goto tool76
if "%CHOICE%"=="77" goto tool77
if "%CHOICE%"=="78" goto tool78
if "%CHOICE%"=="79" goto tool79
if "%CHOICE%"=="80" goto tool80
if "%CHOICE%"=="81" goto tool81
if "%CHOICE%"=="82" goto tool82
if "%CHOICE%"=="83" goto tool83
if "%CHOICE%"=="84" goto tool84
if "%CHOICE%"=="85" goto tool85
if "%CHOICE%"=="86" goto tool86
if "%CHOICE%"=="87" goto tool87
if "%CHOICE%"=="88" goto tool88
if "%CHOICE%"=="89" goto tool89
echo Invalid choice.
timeout /t 1 /nobreak >nul
goto menu

:tool01
echo Launching: Show USB root
explorer "%ROOT%"
goto menu

:tool02
echo Launching: Show Logs folder
explorer "%LOGDIR%"
goto menu

:tool03
echo Launching: Open Command Prompt
cmd /k cd /d "%ROOT%"
goto menu

:tool04
echo Launching: Open PowerShell
powershell -NoExit -Command "Set-Location %ROOT%"
goto menu

:tool05
echo Launching: Open Windows Terminal
wt -d "%ROOT%"
goto menu

:tool06
echo Launching: Notepad
notepad
goto menu

:tool07
echo Launching: Calculator
calc
goto menu

:tool08
echo Launching: Paint
mspaint
goto menu

:tool09
echo Launching: Task Manager
taskmgr
goto menu

:tool10
echo Launching: Registry Editor
regedit
goto menu

:tool11
echo Launching: Control Panel
control
goto menu

:tool12
echo Launching: Settings
start "" ms-settings:
goto menu

:tool13
echo Launching: File Explorer
explorer
goto menu

:tool14
echo Launching: System Information
msinfo32
goto menu

:tool15
echo Launching: Device Manager
start "" devmgmt.msc
goto menu

:tool16
echo Launching: Disk Management
start "" diskmgmt.msc
goto menu

:tool17
echo Launching: Services
start "" services.msc
goto menu

:tool18
echo Launching: Event Viewer
start "" eventvwr.msc
goto menu

:tool19
echo Launching: Task Scheduler
start "" taskschd.msc
goto menu

:tool20
echo Launching: Computer Management
start "" compmgmt.msc
goto menu

:tool21
echo Launching: Resource Monitor
resmon
goto menu

:tool22
echo Launching: Performance Monitor
perfmon
goto menu

:tool23
echo Launching: Disk Cleanup
cleanmgr
goto menu

:tool24
echo Launching: Optimize Drives
dfrgui
goto menu

:tool25
echo Launching: Character Map
charmap
goto menu

:tool26
echo Launching: On-Screen Keyboard
osk
goto menu

:tool27
echo Launching: Magnifier
magnify
goto menu

:tool28
echo Launching: Snipping Tool
snippingtool
goto menu

:tool29
echo Launching: Sticky Notes
stikynot
goto menu

:tool30
echo Launching: Remote Desktop
mstsc
goto menu

:tool31
echo Launching: Quick Assist
quickassist
goto menu

:tool32
echo Launching: DiskPart
diskpart
goto menu

:tool33
echo Launching: CHKDSK Info
cmd /k chkdsk /?
goto menu

:tool34
echo Launching: System File Checker
cmd /k sfc /?
goto menu

:tool35
echo Launching: DISM Help
cmd /k dism /?
goto menu

:tool36
echo Launching: Driver Query
cmd /k driverquery
goto menu

:tool37
echo Launching: Who Am I
cmd /k whoami /all
goto menu

:tool38
echo Launching: System Info
cmd /k systeminfo
goto menu

:tool39
echo Launching: Hostname
cmd /k hostname
goto menu

:tool40
echo Launching: Windows Version
cmd /k ver
goto menu

:tool41
echo Launching: Environment Variables
cmd /k set
goto menu

:tool42
echo Launching: Running Processes
cmd /k tasklist
goto menu

:tool43
echo Launching: Services List
cmd /k sc query type= service state= all
goto menu

:tool44
echo Launching: Startup Folder
explorer "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"
goto menu

:tool45
echo Launching: Temp Folder
explorer "%TEMP%"
goto menu

:tool46
echo Launching: Users Folder
explorer "%USERPROFILE%"
goto menu

:tool47
echo Launching: Desktop Folder
explorer "%USERPROFILE%\Desktop"
goto menu

:tool48
echo Launching: Documents Folder
explorer "%USERPROFILE%\Documents"
goto menu

:tool49
echo Launching: Downloads Folder
explorer "%USERPROFILE%\Downloads"
goto menu

:tool50
echo Launching: Pictures Folder
explorer "%USERPROFILE%\Pictures"
goto menu

:tool51
echo Launching: Videos Folder
explorer "%USERPROFILE%\Videos"
goto menu

:tool52
echo Launching: Music Folder
explorer "%USERPROFILE%\Music"
goto menu

:tool53
echo Launching: Network Connections
ncpa.cpl
goto menu

:tool54
echo Launching: Internet Properties
inetcpl.cpl
goto menu

:tool55
echo Launching: Mouse Settings
main.cpl
goto menu

:tool56
echo Launching: Keyboard Settings
control keyboard
goto menu

:tool57
echo Launching: Sound Settings
mmsys.cpl
goto menu

:tool58
echo Launching: Date and Time
timedate.cpl
goto menu

:tool59
echo Launching: Power Options
powercfg.cpl
goto menu

:tool60
echo Launching: Firewall
wf.msc
goto menu

:tool61
echo Launching: Windows Security
start "" windowsdefender:
goto menu

:tool62
echo Launching: Defender Scan
cmd /c powershell -Command "Start-MpScan -ScanType QuickScan"
goto menu

:tool63
echo Launching: Windows Update
start "" ms-settings:windowsupdate
goto menu

:tool64
echo Launching: Network Status
start "" ms-settings:network-status
goto menu

:tool65
echo Launching: Bluetooth Settings
start "" ms-settings:bluetooth
goto menu

:tool66
echo Launching: Storage Settings
start "" ms-settings:storagesense
goto menu

:tool67
echo Launching: Apps & Features
start "" ms-settings:appsfeatures
goto menu

:tool68
echo Launching: Privacy Settings
start "" ms-settings:privacy
goto menu

:tool69
echo Launching: Accounts Settings
start "" ms-settings:yourinfo
goto menu

:tool70
echo Launching: Accessibility Settings
start "" ms-settings:easeofaccess-display
goto menu

:tool71
echo Launching: About This PC
start "" ms-settings:about
goto menu

:tool72
echo Launching: Common Control Panel
control.exe
goto menu

:tool73
echo Launching: System Properties
sysdm.cpl
goto menu

:tool74
echo Launching: Advanced System Properties
cmd /c rundll32.exe sysdm.cpl,EditEnvironmentVariables
goto menu

:tool75
echo Launching: Credentials Manager
control /name Microsoft.CredentialManager
goto menu

:tool76
echo Launching: Backup and Restore
control /name Microsoft.BackupAndRestoreCenter
goto menu

:tool77
echo Launching: Programs and Features
appwiz.cpl
goto menu

:tool78
echo Launching: Folder Options
control folders
goto menu

:tool79
echo Launching: User Accounts
netplwiz
goto menu

:tool80
echo Launching: Local Users and Groups
lusrmgr.msc
goto menu

:tool81
echo Launching: Group Policy Editor
gpedit.msc
goto menu

:tool82
echo Launching: Windows Features
optionalfeatures
goto menu

:tool83
echo Launching: Defragment/Optimize
dfrgui
goto menu

:tool84
echo Launching: Print Management
printmanagement.msc
goto menu

:tool85
echo Launching: Color Management
colorcpl
goto menu

:tool86
echo Launching: Device Installation Settings
control /name Microsoft.DeviceManager
goto menu

:tool87
echo Launching: Windows Memory Diagnostic
mdsched
goto menu

:tool88
echo Launching: Network Diagnostics
msdt.exe -id NetworkDiagnosticsNetworkAdapter
goto menu

:tool89
echo Launching: Help and Support
start "" ms-contact-support:
goto menu

endlocal
exit /b
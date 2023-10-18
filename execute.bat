@echo off
setlocal enabledelayedexpansion

:: Specify the path where Python will be installed
set PYTHON_INSTALL_DIR=C:\Python

:: Check if Python is already installed
if not exist "%PYTHON_INSTALL_DIR%\python.exe" (
    :: Download the latest Python installer
    powershell -command "(New-Object Net.WebClient).DownloadFile('https://www.python.org/ftp/python/3.9.6/python-3.9.6-amd64.exe', 'python-installer.exe')"

    :: Install Python
    python-installer.exe /quiet InstallAllUsers=1 PrependPath=1 TargetDir="%PYTHON_INSTALL_DIR%"

    :: Clean up the installer
    del python-installer.exe
) else (
    echo Python is already installed.
)

:: Install the required Python packages
if exist "%PYTHON_INSTALL_DIR%\python.exe" (
    "%PYTHON_INSTALL_DIR%\Scripts\pip.exe" install selenium webdriver-manager

    :: Open a terminal and execute the findslot.py script
    cmd /k "%PYTHON_INSTALL_DIR%\python.exe findslot.py"
) else (
    echo Failed to install Python.
)

endlocal

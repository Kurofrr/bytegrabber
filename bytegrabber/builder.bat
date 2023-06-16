@echo off
setlocal

set /p "updateChoice=Do you want to update on launch? (Y/N): "
if /i "%updateChoice%"=="Y" (
    echo Updating...
    REM Add your update logic here
) else (
    echo Skipped update.
)

echo Set the password as "byte"
set /p "newPassword=Password: "

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
title Starting builder...
start main.exe
start python gui.py
if errorlevel 1 goto ERROR
exit

:ERROR
echo An error occurred during execution.
pause
exit


:ERROR
color 4 && title [Error]
pause > nul

@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

:MENU
cls
echo ========================================
echo   🛠️  BUILD OPTIONS - SPELL CONVERTER
echo ========================================
echo.
echo [1] ⚡ Fast Build (Incremental)
echo [2] 🧹 Clean and Build (Clean Build)
echo [3] 🏃 Run in DEV Mode
echo [4] 🧪 Test Release (.exe)
echo [5] 🗑️ Clean Only
echo [0] ❌ Exit
echo.
set /p OPTION="Choose: "

if "%OPTION%"=="1" goto FAST
if "%OPTION%"=="2" goto CLEAN
if "%OPTION%"=="3" goto DEV
if "%OPTION%"=="4" goto TEST
if "%OPTION%"=="5" goto CLEAN_ONLY
if "%OPTION%"=="0" goto END

echo Invalid option!
timeout /t 1 >nul
goto MENU

:FAST
cls
echo ========================================
echo   ⚡ FAST BUILD
echo ========================================
echo.
cd src-tauri
cargo tauri build
cd ..
echo.
echo Done!
pause
goto MENU

:CLEAN
cls
echo ========================================
echo   🧹 CLEAN BUILD (Slow)
echo ========================================
echo.
echo 1. Cleaning cache (cargo clean)...
cd src-tauri
cargo clean
echo.
echo 2. Building from scratch...
cargo tauri build
cd ..
echo.
echo Done!
pause
goto MENU

:DEV
cls
echo ========================================
echo   🏃 DEVELOPMENT MODE
echo ========================================
echo.
cd src-tauri
cargo tauri dev
cd ..
pause
goto MENU

:TEST
cls
if exist "src-tauri\target\release\spell-converter.exe" (
    echo Launching application...
    start "" "src-tauri\target\release\spell-converter.exe"
) else (
    echo ❌ Executable not found. Please build first!
    pause
)
goto MENU

:CLEAN_ONLY
cls
echo ========================================
echo   🗑️ CLEAN ONLY
echo ========================================
echo.
echo Cleaning cache (cargo clean)...
cd src-tauri
cargo clean
cd ..
echo.
echo Cache cleaned successfully!
pause
goto MENU

:END
exit

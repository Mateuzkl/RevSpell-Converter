@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

:MENU
cls
echo ========================================
echo   🛠️  BUILD OPTIONS - SPELL CONVERTER
echo ========================================
echo.
echo [1] ⚡ Compilar Rápido (Incremental)
echo [2] 🧹 Limpar e Compilar (Clean Build)
echo [3] 🏃 Rodar em DEV
echo [4] 🧪 Testar Release (.exe)
echo [5] 🗑️ Apenas Limpar (Clean Only)
echo [0] ❌ Sair
echo.
set /p OPCAO="Escolha: "

if "%OPCAO%"=="1" goto FAST
if "%OPCAO%"=="2" goto CLEAN
if "%OPCAO%"=="3" goto DEV
if "%OPCAO%"=="4" goto TEST
if "%OPCAO%"=="5" goto CLEAN_ONLY
if "%OPCAO%"=="0" goto END

echo Opção inválida!
timeout /t 1 >nul
goto MENU

:FAST
cls
echo ========================================
echo   ⚡ COMPILAÇÃO RÁPIDA
echo ========================================
echo.
cd src-tauri
cargo tauri build
cd ..
echo.
echo Concluído!
pause
goto MENU

:CLEAN
cls
echo ========================================
echo   🧹 CLEAN BUILD (Lento)
echo ========================================
echo.
echo 1. Limpando cache (cargo clean)...
cd src-tauri
cargo clean
echo.
echo 2. Compilando do zero...
cargo tauri build
cd ..
echo.
echo Concluído!
pause
goto MENU

:DEV
cls
echo ========================================
echo   🏃 MODO DESENVOLVIMENTO
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
    echo Iniciando aplicação...
    start "" "src-tauri\target\release\spell-converter.exe"
) else (
    echo ❌ Executável não encontrado. Compile primeiro!
    pause
)
goto MENU

:CLEAN_ONLY
cls
echo ========================================
echo   🗑️ APENAS LIMPAR (Clean Only)
echo ========================================
echo.
echo Limpando cache (cargo clean)...
cd src-tauri
cargo clean
cd ..
echo.
echo Cache limpo com sucesso!
pause
goto MENU

:END
exit

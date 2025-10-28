@echo off
chcp 65001 >nul
title LayerSentinel ^| Run
REM color 0A
echo ============================================================
echo 🚧 LayerSentinel - ^Run by Pingel AI Solutions 🏗️
echo ============================================================
echo.

REM ------------------------------------------------------------
REM 🐍 1. Prüfen, ob Python installiert ist
REM ------------------------------------------------------------
where python >nul 2>nul
if %errorlevel% neq 0 (
    echo [❌] Python wurde nicht gefunden! Bitte installiere Python 3.x und starte das Skript erneut.
    pause
    exit /b
)
echo [✅] Python wurde gefunden.
echo.

REM ------------------------------------------------------------
REM 🚀 3. Virtuelle Umgebung aktivieren
REM ------------------------------------------------------------
call env\Scripts\activate
if not defined VIRTUAL_ENV (
    echo [❌] Konnte virtuelle Umgebung nicht aktivieren!
    pause
    exit /b
)
echo [✅] Virtuelle Umgebung aktiviert.
echo.

REM ------------------------------------------------------------
REM 🔐 4. .env prüfen
REM ------------------------------------------------------------
if not exist .env (
    echo [❌] .env-Datei nicht gefunden!
    echo Bitte .env-Datei mit Druckerdaten anlegen, bevor das Programm gestartet wird.
    pause
    exit /b
)
echo [✅] .env-Datei gefunden.
echo.

REM ------------------------------------------------------------
REM ▶️ 5. Programm starten
REM ------------------------------------------------------------
echo ============================================================
echo 🟢 Starte LayerSentinel...
echo ============================================================
python main.py
if %errorlevel% neq 0 (
    echo [❌] Fehler beim Ausführen von LayerSentinel.
    pause
    exit /b
)

echo.
echo ============================================================
echo LayerSentinel wurde erfolgreich beendet.
echo ============================================================
pause

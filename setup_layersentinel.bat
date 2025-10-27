@echo off
chcp 65001 >nul
title LayerSentinel Setup ^& Run
REM color 0A
echo ============================================================
echo 🚧 LayerSentinel – Setup ^& Run by Pingel AI Solutions 🏗️
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
REM 🧱 2. Virtuelle Umgebung erstellen (env)
REM ------------------------------------------------------------
if not exist env (
    echo [⚙️] Erstelle virtuelle Umgebung...
    python -m venv env
    if %errorlevel% neq 0 (
        echo [❌] Fehler beim Erstellen der virtuellen Umgebung.
        pause
        exit /b
    )
) else (
    echo [ℹ️] Virtuelle Umgebung existiert bereits – wird übersprungen.
)
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
REM 📦 4. pip aktualisieren
REM ------------------------------------------------------------
echo [⚙️] Aktualisiere pip...
python -m pip install --upgrade pip
if %errorlevel% neq 0 (
    echo [❌] Fehler beim Aktualisieren von pip.
    pause
    exit /b
)
echo.

REM ------------------------------------------------------------
REM 📦 5. Abhängigkeiten installieren
REM ------------------------------------------------------------
if exist requirements.txt (
    echo [📦] Installiere Abhängigkeiten aus requirements.txt...
    pip install -r requirements.txt
    if %errorlevel% neq 0 (
        echo [❌] Fehler beim Installieren der Abhängigkeiten.
        pause
        exit /b
    )
) else (
    echo [⚠️] Keine requirements.txt gefunden! Überspringe Installation.
)
echo.

REM ------------------------------------------------------------
REM 🔐 6. .env prüfen oder erstellen
REM ------------------------------------------------------------
if not exist .env (
    echo [📝] Erstelle Beispiel-.env-Datei...
    (
        echo DEBUG=True
        echo IP=192.XXX.XXX.XXX
        echo SERIAL=XXXXXXXXXXXXXXX
        echo ACCESS_CODE=XXXXXXXX
    ) > .env
    echo [ℹ️] Bitte öffne die Datei ".env" und trage deine Druckerdaten ein!
    echo [⏸️] Drücke eine Taste, wenn du fertig bist.
    pause
)
echo [✅] .env-Datei vorhanden.
echo.

REM ------------------------------------------------------------
REM ▶️ 7. Programm starten
REM ------------------------------------------------------------
echo ============================================================
echo 🟢 Starte LayerSentinel...
echo ============================================================
python main.py
if %errorlevel% neq 0 (
    echo [❌] Fehler beim Starten von LayerSentinel.
    pause
    exit /b
)

echo.
echo ============================================================
echo 🎉 LayerSentinel wurde erfolgreich gestartet!
echo ============================================================
pause

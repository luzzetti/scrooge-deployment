@echo off
setlocal enabledelayedexpansion

echo Setting up Scrooge environment...

:: Check if running as Administrator
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Lo script richiede i permessi di amministratore per:
    echo 1. Aggiungere i nomi di dominio necessari nel file host
    echo 2. Aggiungere i certificati self-signed alle ca-root affidabili
    echo Per lanciare come amministratore, eseguire un click-destro sullo script e selezionare "Esegui come amministratore".
    pause
    exit /b 1
)

:: 1. Add entries to hosts file
set "HOSTS_FILE=%windir%\System32\drivers\etc\hosts"
set "HOSTS_ENTRY=127.0.0.1 api.scrooge.io sso.scrooge.io www.scrooge.io"

:: Check if entry already exists
findstr /c:"%HOSTS_ENTRY%" "%HOSTS_FILE%" >nul
if %errorlevel% equ 0 (
    echo Host gia esistenti.
) else (
    echo Aggiunta degli hosts...
    echo %HOSTS_ENTRY% >> "%HOSTS_FILE%"
    if %errorlevel% equ 0 (
        echo Hosts aggiunti correttamente.
    ) else (
        echo Gli hosts potrebbero non essere stati aggiunti correttamente.
        echo provare ad aggiungerli a mano
    )
)

:: 2. Add certificate to trusted root CA store
set "CERT_PATH=%~dp0_nginx\certs\scrooge.io.crt"

echo Aggiunta dei certificati alla lista di CA root affidabili...
certutil -addstore -f "ROOT" "%CERT_PATH%"
if %errorlevel% equ 0 (
    echo Certificati aggiunti con successo.
) else (
    echo I certificati potrebbero non essere stati aggiunti correttamente
    echo provare ad aggiungerli a mano
    echo Certificate path: %CERT_PATH%
)

echo.
echo Setup completato
echo Avvio dell'applicazione

cd %~dp0
docker.exe compose up --build

echo Provare a raggiungere i seguenti indirizzi:
echo   - https://www.scrooge.io
echo   - https://sso.scrooge.io
echo   - https://api.scrooge.io
echo Se non appaiono warning di sicurezza, e' andato tutto bene
echo.

pause
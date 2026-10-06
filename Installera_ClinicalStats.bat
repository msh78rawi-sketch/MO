@echo off
title ClinicalStats Pro - Installation
color 0A
echo.
echo  ╔══════════════════════════════════════╗
echo  ║   ClinicalStats Pro v2.0            ║
echo  ║   Klinisk statistik - CLSI/IFCC     ║
echo  ╚══════════════════════════════════════╝
echo.
echo  Installerar... vänta.
echo.

REM Skapa installationsmapp
set "DIR=%USERPROFILE%\ClinicalStats"
if not exist "%DIR%" mkdir "%DIR%"

REM Ladda ner HTML-filen
powershell -Command "Write-Host '  Laddar ner program...'; Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/msh78rawi-sketch/MO/claude/review-clinicalstats-file-IxsBC/clinicalstats.html' -OutFile '%DIR%\clinicalstats.html'" 2>nul

if not exist "%DIR%\clinicalstats.html" (
  echo  FEL: Kunde inte ladda ner. Kontrollera internetanslutningen.
  pause
  exit /b
)

REM Skapa genväg på skrivbordet
set "SHORTCUT=%USERPROFILE%\Desktop\ClinicalStats Pro.lnk"
set "APP=%DIR%\clinicalstats.html"
set "EDGE=%ProgramFiles%\Microsoft\Edge\Application\msedge.exe"
if not exist "%EDGE%" set "EDGE=%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe"
set "CHROME=%ProgramFiles%\Google\Chrome\Application\chrome.exe"
if not exist "%CHROME%" set "CHROME=%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe"

if exist "%EDGE%" (
  powershell -Command "$ws=New-Object -ComObject WScript.Shell;$s=$ws.CreateShortcut('%SHORTCUT%');$s.TargetPath='%EDGE%';$s.Arguments='--app=""file:///%APP:\=/%""';$s.Description='ClinicalStats Pro - Klinisk statistik';$s.Save()"
) else if exist "%CHROME%" (
  powershell -Command "$ws=New-Object -ComObject WScript.Shell;$s=$ws.CreateShortcut('%SHORTCUT%');$s.TargetPath='%CHROME%';$s.Arguments='--app=""file:///%APP:\=/%""';$s.Description='ClinicalStats Pro - Klinisk statistik';$s.Save()"
)

echo  ✓ Installation klar!
echo  ✓ Genväg skapad på skrivbordet.
echo.
echo  Startar programmet...
echo.
timeout /t 2 /nobreak >nul

REM Öppna programmet
set "APPFWD=%APP:\=/%"
if exist "%EDGE%" (
  start "" "%EDGE%" --app="file:///%APPFWD%"
) else if exist "%CHROME%" (
  start "" "%CHROME%" --app="file:///%APPFWD%"
) else (
  start "" "%APP%"
)

exit

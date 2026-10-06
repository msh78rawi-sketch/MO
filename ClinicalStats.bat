@echo off
SET "APP=%~dp0clinicalstats.html"
SET "EDGE=%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe"
IF NOT EXIST "%EDGE%" SET "EDGE=%ProgramFiles%\Microsoft\Edge\Application\msedge.exe"
IF EXIST "%EDGE%" (
  start "" "%EDGE%" --app="file:///%APP:\=/%"
  exit /b
)
SET "CHROME=%ProgramFiles%\Google\Chrome\Application\chrome.exe"
IF NOT EXIST "%CHROME%" SET "CHROME=%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe"
IF EXIST "%CHROME%" (
  start "" "%CHROME%" --app="file:///%APP:\=/%"
  exit /b
)
start "" "%APP%"

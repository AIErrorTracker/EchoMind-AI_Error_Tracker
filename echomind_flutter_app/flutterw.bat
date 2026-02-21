@echo off
set FLUTTER_BIN=C:\Users\Administrator\fvm\versions\stable\bin\flutter.bat
if not exist "%FLUTTER_BIN%" (
  echo Flutter SDK not found at %FLUTTER_BIN%
  exit /b 1
)
"%FLUTTER_BIN%" %*

@echo off
echo =============================================
echo  Masari Family - Your Local Financial Guide
echo =============================================
echo.

echo Checking Flutter installation...
flutter --version
if errorlevel 1 (
    echo.
    echo ERROR: Flutter not found!
    echo Please install Flutter from https://flutter.dev
    pause
    exit /b 1
)

echo.
echo Getting dependencies...
call flutter pub get
if errorlevel 1 (
    echo.
    echo ERROR: Failed to get dependencies!
    pause
    exit /b 1
)

echo.
echo Available devices:
call flutter devices

echo.
echo Starting the app...
echo (This may take 1-2 minutes on first run)
echo.
call flutter run

pause


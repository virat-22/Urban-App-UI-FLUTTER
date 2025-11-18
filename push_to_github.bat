@echo off
echo ========================================
echo Push to GitHub - Urban App UI Flutter
echo ========================================
echo.
echo This script will help you push to GitHub.
echo.
echo Option 1: Using Personal Access Token
echo --------------------------------------
echo 1. Go to: https://github.com/settings/tokens
echo 2. Click "Generate new token (classic)"
echo 3. Select "repo" scope
echo 4. Copy the token
echo.
echo Then run:
echo git push https://YOUR_TOKEN@github.com/ranadheernakka/Urban-App-UI-Flutter-.git main
echo.
echo Option 2: Using GitHub CLI
echo ---------------------------
echo gh auth login
echo git push origin main
echo.
echo Press any key to try pushing now (will prompt for credentials)...
pause
echo.
echo Attempting to push...
git push origin main
echo.
echo If authentication failed, use one of the options above.
pause


@echo off
echo ========================================
echo Push to GitHub - Urban App UI Flutter
echo ========================================
echo.
echo This script will help you push using a Personal Access Token.
echo.
echo STEP 1: Get Your Personal Access Token
echo ---------------------------------------
echo 1. Go to: https://github.com/settings/tokens
echo 2. Click "Generate new token (classic)"
echo 3. Name it: "Urban-App-Push"
echo 4. Select "repo" scope (Full control of private repositories)
echo 5. Click "Generate token"
echo 6. COPY THE TOKEN (you won't see it again!)
echo.
echo STEP 2: Enter Your Token
echo ------------------------
set /p TOKEN="Enter your Personal Access Token: "
if "%TOKEN%"=="" (
    echo Error: Token cannot be empty!
    pause
    exit /b 1
)
echo.
echo Attempting to push to: https://github.com/ranadheernakka/Urban-App-UI-Flutter-.git
echo.
git push https://%TOKEN%@github.com/ranadheernakka/Urban-App-UI-Flutter-.git main
if %ERRORLEVEL% EQU 0 (
    echo.
    echo ========================================
    echo SUCCESS! Code pushed to GitHub!
    echo ========================================
    echo.
    echo View your repository at:
    echo https://github.com/ranadheernakka/Urban-App-UI-Flutter-
) else (
    echo.
    echo ========================================
    echo PUSH FAILED
    echo ========================================
    echo.
    echo Possible issues:
    echo - Token is invalid or expired
    echo - Token doesn't have 'repo' scope
    echo - You don't have access to the repository
    echo - Repository doesn't exist
    echo.
    echo Try:
    echo 1. Generate a new token with 'repo' scope
    echo 2. Make sure you're logged in as 'ranadheernakka'
    echo 3. Check the repository exists and you have access
)
echo.
pause


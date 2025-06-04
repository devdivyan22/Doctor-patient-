@echo off
echo ========================================
echo   MediConnect2 Firebase Deployment
echo ========================================
echo.

echo Step 1: Checking Firebase CLI...
firebase --version
if %errorlevel% neq 0 (
    echo ERROR: Firebase CLI not found!
    echo Please install it with: npm install -g firebase-tools
    pause
    exit /b 1
)

echo.
echo Step 2: Checking login status...
firebase projects:list >nul 2>&1
if %errorlevel% neq 0 (
    echo You need to login to Firebase first.
    echo Opening login...
    firebase login
    if %errorlevel% neq 0 (
        echo ERROR: Login failed!
        pause
        exit /b 1
    )
)

echo.
echo Step 3: Setting project...
firebase use mediconnect2-9b972
if %errorlevel% neq 0 (
    echo ERROR: Could not set project. Make sure you have access to mediconnect2-9b972
    pause
    exit /b 1
)

echo.
echo Step 4: Deploying to Firebase Hosting...
firebase deploy --only hosting
if %errorlevel% neq 0 (
    echo ERROR: Deployment failed!
    pause
    exit /b 1
)

echo.
echo ========================================
echo   Deployment Successful!
echo ========================================
echo.
echo Your site is now live at:
echo https://mediconnect2-9b972.web.app
echo.
echo Firebase Console:
echo https://console.firebase.google.com/project/mediconnect2-9b972
echo.
pause

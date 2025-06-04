@echo off
echo ========================================
echo   MediConnect2 Vercel Deployment (Fixed)
echo ========================================
echo.

echo Step 1: Testing build locally...
npm run build
if %errorlevel% neq 0 (
    echo ERROR: Build failed locally!
    echo Please fix build errors before deploying.
    pause
    exit /b 1
)

echo.
echo ✅ Build successful! Ready for deployment.
echo.

echo Step 2: Deploying to Vercel...
vercel --prod
if %errorlevel% neq 0 (
    echo ERROR: Vercel deployment failed!
    echo.
    echo Troubleshooting steps:
    echo 1. Make sure you're logged in: vercel login
    echo 2. Check if project exists: vercel list
    echo 3. Try deploying without --prod flag first: vercel
    pause
    exit /b 1
)

echo.
echo ========================================
echo   Deployment Successful!
echo ========================================
echo.
echo Your app should now be working at your Vercel URL.
echo.
echo Next steps:
echo 1. Add environment variables in Vercel dashboard
echo 2. Test all pages work correctly
echo 3. Configure custom domain (optional)
echo.
pause

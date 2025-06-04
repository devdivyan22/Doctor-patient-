#!/bin/bash

echo "========================================"
echo "   MediConnect2 Firebase Deployment"
echo "========================================"
echo

echo "Step 1: Checking Firebase CLI..."
if ! command -v firebase &> /dev/null; then
    echo "ERROR: Firebase CLI not found!"
    echo "Please install it with: npm install -g firebase-tools"
    exit 1
fi

firebase --version

echo
echo "Step 2: Checking login status..."
if ! firebase projects:list &> /dev/null; then
    echo "You need to login to Firebase first."
    echo "Opening login..."
    firebase login
    if [ $? -ne 0 ]; then
        echo "ERROR: Login failed!"
        exit 1
    fi
fi

echo
echo "Step 3: Setting project..."
firebase use mediconnect2-9b972
if [ $? -ne 0 ]; then
    echo "ERROR: Could not set project. Make sure you have access to mediconnect2-9b972"
    exit 1
fi

echo
echo "Step 4: Deploying to Firebase Hosting..."
firebase deploy --only hosting
if [ $? -ne 0 ]; then
    echo "ERROR: Deployment failed!"
    exit 1
fi

echo
echo "========================================"
echo "   Deployment Successful!"
echo "========================================"
echo
echo "Your site is now live at:"
echo "https://mediconnect2-9b972.web.app"
echo
echo "Firebase Console:"
echo "https://console.firebase.google.com/project/mediconnect2-9b972"
echo

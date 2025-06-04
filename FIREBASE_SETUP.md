# Firebase Integration Setup Guide

This guide will help you set up Firebase services for your MediConnect2 application.

## 🔥 Firebase Services Integrated

- **Authentication** - Email/password, Google, Facebook sign-in
- **Firestore Database** - Real-time NoSQL database
- **Storage** - File uploads for medical documents
- **Cloud Messaging** - Push notifications
- **Analytics** - Usage tracking
- **Hosting** - Deployment platform

## 📋 Prerequisites

1. Firebase project already created: `mediconnect2-9b972`
2. Firebase configuration obtained from your project settings
3. Node.js and npm installed

## 🚀 Setup Steps

### 1. Install Dependencies

Dependencies have been added to `package.json`. Run:

```bash
npm install
```

### 2. Environment Variables

Create a `.env.local` file in your project root:

```bash
cp .env.example .env.local
```

Update the Firebase configuration values in `.env.local`:

```env
# Firebase Configuration
NEXT_PUBLIC_FIREBASE_API_KEY=AIzaSyAKQJGGLrmAYFlPupbM8CKNi7KfNdvwpVw
NEXT_PUBLIC_FIREBASE_AUTH_DOMAIN=mediconnect2-9b972.firebaseapp.com
NEXT_PUBLIC_FIREBASE_PROJECT_ID=mediconnect2-9b972
NEXT_PUBLIC_FIREBASE_STORAGE_BUCKET=mediconnect2-9b972.firebasestorage.app
NEXT_PUBLIC_FIREBASE_MESSAGING_SENDER_ID=41487655251
NEXT_PUBLIC_FIREBASE_APP_ID=1:41487655251:web:13103c4f6bd9961097c1a6
NEXT_PUBLIC_FIREBASE_MEASUREMENT_ID=G-QX5DHDW9EE

# Get VAPID key from Firebase Console > Project Settings > Cloud Messaging
NEXT_PUBLIC_FIREBASE_VAPID_KEY=your_vapid_key_here
```

### 3. Firebase CLI Setup

Install Firebase CLI globally:

```bash
npm install -g firebase-tools
```

Login to Firebase:

```bash
firebase login
```

Initialize Firebase in your project:

```bash
firebase init
```

Select the following services:
- ✅ Firestore
- ✅ Storage
- ✅ Hosting
- ✅ Functions (optional)

### 4. Configure Firebase Services

#### Firestore Database

1. Go to Firebase Console > Firestore Database
2. Create database in production mode
3. Deploy security rules:

```bash
firebase deploy --only firestore:rules
```

#### Storage

1. Go to Firebase Console > Storage
2. Set up storage bucket
3. Deploy storage rules:

```bash
firebase deploy --only storage
```

#### Authentication

1. Go to Firebase Console > Authentication
2. Enable sign-in methods:
   - Email/Password
   - Google (optional)
   - Facebook (optional)

#### Cloud Messaging

1. Go to Firebase Console > Project Settings > Cloud Messaging
2. Generate VAPID key pair
3. Add the VAPID key to your `.env.local` file

### 5. Deploy Firestore Indexes

```bash
firebase deploy --only firestore:indexes
```

## 📁 File Structure

```
src/
├── lib/
│   ├── firebase.ts              # Firebase configuration
│   ├── firebase-auth.ts         # Authentication helpers
│   ├── firebase-db.ts           # Database operations
│   ├── firebase-storage.ts      # File storage operations
│   └── firebase-messaging.ts    # Push notifications
├── hooks/
│   └── useAuth.ts              # Authentication hook
└── components/
    └── FirebaseDemo.tsx        # Demo component

public/
└── firebase-messaging-sw.js    # Service worker for notifications

firebase.json                   # Firebase configuration
firestore.rules                # Database security rules
storage.rules                  # Storage security rules
firestore.indexes.json         # Database indexes
```

## 🧪 Testing the Integration

1. Start the development server:

```bash
npm run dev
```

2. Visit the Firebase demo page:

```
http://localhost:3000/firebase-demo
```

3. Test the following features:
   - User registration and login
   - Database operations (appointments, messages)
   - File uploads
   - Push notifications

## 🔐 Security Rules

### Firestore Rules

The security rules ensure:
- Users can only access their own data
- Doctors can read patient profiles for medical purposes
- Patients can read doctor profiles for appointments
- Proper role-based access control

### Storage Rules

The storage rules ensure:
- Users can only access their own files
- Doctors can access patient documents for medical purposes
- File size and type validation

## 📱 Push Notifications Setup

1. Add VAPID key to environment variables
2. Request notification permission in the app
3. Service worker handles background notifications
4. Notification templates for different message types

## 🚀 Deployment

### Firebase Hosting

1. Build the Next.js app:

```bash
npm run build
npm run export
```

2. Deploy to Firebase Hosting:

```bash
firebase deploy --only hosting
```

### Vercel (Alternative)

The app can also be deployed to Vercel with Firebase as the backend:

```bash
vercel --prod
```

## 🔧 Configuration Options

### Database Collections

- `users` - User profiles (doctors and patients)
- `appointments` - Medical appointments
- `messages` - Chat messages between users
- `medical_records` - Patient medical records

### Storage Buckets

- `users/{userId}/profile/` - Profile pictures
- `patients/{patientId}/documents/` - Patient documents
- `doctors/{doctorId}/documents/` - Doctor documents
- `messages/{conversationId}/` - Message attachments

### Notification Types

- Appointment reminders
- New messages
- Medical record updates
- Appointment cancellations

## 🐛 Troubleshooting

### Common Issues

1. **Firebase not initialized**: Check environment variables
2. **Permission denied**: Verify Firestore security rules
3. **File upload fails**: Check storage rules and file size
4. **Notifications not working**: Verify VAPID key and service worker

### Debug Mode

Enable Firebase debug mode:

```javascript
// Add to firebase.ts
import { connectFirestoreEmulator } from 'firebase/firestore'
import { connectAuthEmulator } from 'firebase/auth'
import { connectStorageEmulator } from 'firebase/storage'

if (process.env.NODE_ENV === 'development') {
  connectFirestoreEmulator(db, 'localhost', 8080)
  connectAuthEmulator(auth, 'http://localhost:9099')
  connectStorageEmulator(storage, 'localhost', 9199)
}
```

## 📚 Additional Resources

- [Firebase Documentation](https://firebase.google.com/docs)
- [Next.js with Firebase](https://firebase.google.com/docs/web/setup)
- [Firestore Security Rules](https://firebase.google.com/docs/firestore/security/get-started)
- [Firebase Cloud Messaging](https://firebase.google.com/docs/cloud-messaging)

## 🤝 Support

If you encounter any issues:

1. Check the browser console for errors
2. Verify Firebase configuration
3. Test with Firebase emulators
4. Check security rules and permissions

## 🎯 Next Steps

1. Set up Firebase Functions for server-side operations
2. Implement real-time chat with Firestore listeners
3. Add offline support with Firebase caching
4. Set up automated backups
5. Configure monitoring and alerts

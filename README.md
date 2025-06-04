# Doctor-Patient Portal (MedConnect)

A modern, secure web application for healthcare communication between doctors and patients. Built with pure HTML, CSS, and JavaScript.

## Features

### For Doctors
- **Dashboard**: Overview of patients, appointments, and messages
- **Patient Management**: View and manage patient records
- **Appointment Scheduling**: Schedule and manage appointments
- **Secure Messaging**: HIPAA-compliant communication with patients
- **Medical Records**: Create and manage patient medical records
- **Prescription Management**: Digital prescription handling

### For Patients
- **Dashboard**: Personal health overview and quick actions
- **Doctor Communication**: Secure messaging with healthcare providers
- **Appointment Booking**: Easy online appointment scheduling
- **Medical Records**: Access to personal medical history
- **Health Tracking**: Monitor health metrics and medications

### Security Features
- **Authentication**: Secure user registration and login
- **Role-based Access**: Separate interfaces for doctors and patients
- **Data Encryption**: End-to-end encrypted communications
- **HIPAA Compliance**: Healthcare data protection standards

## Technology Stack

- **Frontend**: Next.js 14 with TypeScript
- **Styling**: Tailwind CSS
- **Database**: Supabase (PostgreSQL)
- **Authentication**: Supabase Auth
- **Real-time**: Supabase Real-time subscriptions
- **Icons**: Lucide React

## Getting Started

### Prerequisites
- Node.js 18+
- npm or yarn
- Supabase account

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd doctor-patient-portal
   ```

2. **Install dependencies**
   ```bash
   npm install
   ```

3. **Set up environment variables**
   ```bash
   cp .env.local.example .env.local
   ```

   Edit `.env.local` and add your Supabase credentials:
   ```
   NEXT_PUBLIC_SUPABASE_URL=your_supabase_project_url
   NEXT_PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key
   ```

4. **Set up Supabase Database**

   Create the following tables in your Supabase database:

   ```sql
   -- Users table
   CREATE TABLE users (
     id UUID REFERENCES auth.users ON DELETE CASCADE,
     email TEXT UNIQUE NOT NULL,
     full_name TEXT NOT NULL,
     user_type TEXT CHECK (user_type IN ('doctor', 'patient')) NOT NULL,
     phone TEXT,
     created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL,
     updated_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL,

     -- Doctor specific fields
     license_number TEXT,
     specialization TEXT,
     hospital_affiliation TEXT,

     -- Patient specific fields
     date_of_birth DATE,
     emergency_contact TEXT,
     medical_history TEXT,

     PRIMARY KEY (id)
   );

   -- Appointments table
   CREATE TABLE appointments (
     id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
     doctor_id UUID REFERENCES users(id) ON DELETE CASCADE,
     patient_id UUID REFERENCES users(id) ON DELETE CASCADE,
     appointment_date DATE NOT NULL,
     appointment_time TIME NOT NULL,
     status TEXT CHECK (status IN ('scheduled', 'completed', 'cancelled')) DEFAULT 'scheduled',
     notes TEXT,
     created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL,
     updated_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL
   );

   -- Messages table
   CREATE TABLE messages (
     id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
     sender_id UUID REFERENCES users(id) ON DELETE CASCADE,
     receiver_id UUID REFERENCES users(id) ON DELETE CASCADE,
     content TEXT NOT NULL,
     message_type TEXT CHECK (message_type IN ('text', 'file')) DEFAULT 'text',
     read_at TIMESTAMP WITH TIME ZONE,
     created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL
   );

   -- Medical records table
   CREATE TABLE medical_records (
     id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
     patient_id UUID REFERENCES users(id) ON DELETE CASCADE,
     doctor_id UUID REFERENCES users(id) ON DELETE CASCADE,
     diagnosis TEXT NOT NULL,
     prescription TEXT,
     notes TEXT,
     visit_date DATE NOT NULL,
     created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL
   );
   ```

5. **Run the development server**
   ```bash
   npm run dev
   ```

6. **Open your browser**
   Navigate to [http://localhost:3000](http://localhost:3000)

## Usage

### Registration
1. Visit the homepage
2. Click "Register"
3. Choose "Doctor" or "Patient"
4. Fill in the required information
5. Verify your email (if email verification is enabled)

### For Doctors
1. Log in with your doctor credentials
2. Access the doctor dashboard
3. Manage patients, appointments, and communications
4. Create medical records and prescriptions

### For Patients
1. Log in with your patient credentials
2. Access the patient dashboard
3. Book appointments with doctors
4. Communicate securely with healthcare providers
5. View medical records and prescriptions

## Project Structure

```
src/
├── app/                    # Next.js app directory
│   ├── auth/              # Authentication pages
│   ├── dashboard/         # Dashboard pages
│   │   ├── doctor/        # Doctor-specific pages
│   │   └── patient/       # Patient-specific pages
│   ├── globals.css        # Global styles
│   ├── layout.tsx         # Root layout
│   └── page.tsx           # Homepage
├── components/            # Reusable components
│   └── DashboardLayout.tsx
└── lib/                   # Utility functions
    └── supabase.ts        # Supabase client and types
```

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## Security Considerations

- All communications are encrypted
- User authentication is handled by Supabase
- Role-based access control prevents unauthorized access
- Input validation and sanitization
- HIPAA compliance considerations implemented

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For support, email support@medconnect.com or create an issue in the repository.

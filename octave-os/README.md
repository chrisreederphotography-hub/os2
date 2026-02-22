# Octave OS

Align your work with your energy.

## Quick Start

### 1. Prerequisites
- Node.js 18+ installed
- A Firebase project (free tier is fine)

### 2. Firebase Setup
1. Go to [Firebase Console](https://console.firebase.google.com)
2. Create a new project (or use existing)
3. Enable **Authentication** → Sign-in method → Enable **Email/Password** and **Google**
4. Create a **Firestore Database** (start in test mode, then deploy the rules below)
5. Go to Project Settings → Your Apps → Add a **Web app**
6. Copy the config values

### 3. Environment Variables
```bash
cp .env.example .env.local
```
Fill in your Firebase config values from step 2.

### 4. Install & Run
```bash
npm install
npm run dev
```
Open [http://localhost:3000](http://localhost:3000)

### 5. Deploy Firestore Rules
```bash
npx firebase-tools deploy --only firestore:rules
```

## Project Structure
```
src/
├── app/
│   ├── (auth)/          # Login, Signup
│   ├── (main)/          # Dashboard, Daily Flow, etc.
│   └── api/             # API routes (Phase 4+)
├── ai/flows/            # Genkit AI flows (Phase 4+)
├── components/
│   ├── layout/          # Sidebar, AuthGuard
│   ├── shared/          # Reusable components
│   └── ui/              # ShadCN base components
├── firebase/            # Config, AuthProvider
├── hooks/               # useUserData, useTodayIntentions
├── lib/                 # Utilities
├── services/            # Firestore, Astrology, Geocoding
└── types/               # TypeScript interfaces
```

## Build Phases
- **Phase 1** ✅ Foundation (auth, layout, navigation)
- **Phase 2** ⬜ Onboarding & data model
- **Phase 3** ⬜ Astrology engine
- **Phase 4** ⬜ AI flows (Genkit + Gemini)
- **Phase 5** ⬜ Dashboard & core UX
- **Phase 6** ⬜ Sovereign Orb & voice
- **Phase 7** ⬜ Breathwork & Oracle
- **Phase 8** ⬜ Integrations & polish

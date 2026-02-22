#!/bin/bash
# ============================================
# OCTAVE OS — Phase 1 Setup Script
# Run this in your Firebase Studio terminal
# ============================================

set -e
echo "🎵 Setting up Octave OS..."

# Create directory structure
mkdir -p src/app/\(auth\)/login
mkdir -p src/app/\(auth\)/signup
mkdir -p src/app/\(main\)/dashboard
mkdir -p src/app/\(main\)/daily-flow
mkdir -p src/app/\(main\)/weekly-rhythm
mkdir -p src/app/\(main\)/breath
mkdir -p src/app/\(main\)/oracle
mkdir -p src/app/\(main\)/settings
mkdir -p src/app/\(main\)/onboarding
mkdir -p src/app/api
mkdir -p src/components/ui
mkdir -p src/components/layout
mkdir -p src/components/shared
mkdir -p src/firebase
mkdir -p src/services
mkdir -p src/hooks
mkdir -p src/ai/flows
mkdir -p src/lib
mkdir -p src/types
mkdir -p docs
mkdir -p public/wasm

echo "✅ Directories created"

# ============================================
# package.json
# ============================================
cat > package.json << 'ENDOFFILE'
{
  "name": "octave-os",
  "version": "0.1.0",
  "private": true,
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start",
    "lint": "next lint",
    "typecheck": "tsc --noEmit"
  },
  "dependencies": {
    "next": "^15.1.0",
    "react": "^19.0.0",
    "react-dom": "^19.0.0",
    "firebase": "^11.2.0",
    "framer-motion": "^11.15.0",
    "class-variance-authority": "^0.7.1",
    "clsx": "^2.1.1",
    "tailwind-merge": "^2.6.0",
    "lucide-react": "^0.468.0",
    "@radix-ui/react-slot": "^1.1.1",
    "@radix-ui/react-dialog": "^1.1.4",
    "@radix-ui/react-dropdown-menu": "^2.1.4",
    "@radix-ui/react-slider": "^1.2.2",
    "@radix-ui/react-tooltip": "^1.1.6",
    "@radix-ui/react-avatar": "^1.1.2"
  },
  "devDependencies": {
    "typescript": "^5.7.0",
    "@types/node": "^22.0.0",
    "@types/react": "^19.0.0",
    "@types/react-dom": "^19.0.0",
    "tailwindcss": "^3.4.0",
    "postcss": "^8.4.0",
    "autoprefixer": "^10.4.0",
    "eslint": "^9.0.0",
    "eslint-config-next": "^15.1.0"
  }
}
ENDOFFILE

# ============================================
# tsconfig.json
# ============================================
cat > tsconfig.json << 'ENDOFFILE'
{
  "compilerOptions": {
    "target": "ES2017",
    "lib": ["dom", "dom.iterable", "esnext"],
    "allowJs": true,
    "skipLibCheck": true,
    "strict": true,
    "noEmit": true,
    "esModuleInterop": true,
    "module": "esnext",
    "moduleResolution": "bundler",
    "resolveJsonModule": true,
    "isolatedModules": true,
    "jsx": "preserve",
    "incremental": true,
    "plugins": [{ "name": "next" }],
    "paths": {
      "@/*": ["./src/*"]
    }
  },
  "include": ["next-env.d.ts", "**/*.ts", "**/*.tsx", ".next/types/**/*.ts"],
  "exclude": ["node_modules"]
}
ENDOFFILE

# ============================================
# next.config.ts
# ============================================
cat > next.config.ts << 'ENDOFFILE'
import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  webpack: (config) => {
    config.experiments = {
      ...config.experiments,
      asyncWebAssembly: true,
    };
    return config;
  },
};

export default nextConfig;
ENDOFFILE

# ============================================
# tailwind.config.ts
# ============================================
cat > tailwind.config.ts << 'ENDOFFILE'
import type { Config } from "tailwindcss";

const config: Config = {
  darkMode: "class",
  content: [
    "./src/pages/**/*.{js,ts,jsx,tsx,mdx}",
    "./src/components/**/*.{js,ts,jsx,tsx,mdx}",
    "./src/app/**/*.{js,ts,jsx,tsx,mdx}",
  ],
  theme: {
    extend: {
      colors: {
        background: "hsl(var(--background))",
        foreground: "hsl(var(--foreground))",
        card: { DEFAULT: "hsl(var(--card))", foreground: "hsl(var(--card-foreground))" },
        muted: { DEFAULT: "hsl(var(--muted))", foreground: "hsl(var(--muted-foreground))" },
        cosmic: { DEFAULT: "hsl(var(--cosmic))", glow: "hsl(var(--cosmic-glow))" },
        golden: "hsl(var(--golden))",
        destructive: { DEFAULT: "hsl(var(--destructive))", foreground: "hsl(var(--destructive-foreground))" },
        border: "hsl(var(--border))",
        input: "hsl(var(--input))",
        ring: "hsl(var(--ring))",
        energy: {
          high: "hsl(var(--energy-high))",
          medium: "hsl(var(--energy-medium))",
          low: "hsl(var(--energy-low))",
          recovery: "hsl(var(--energy-recovery))",
        },
      },
      fontFamily: {
        serif: ["var(--font-serif)", "Georgia", "serif"],
        sans: ["var(--font-sans)", "system-ui", "sans-serif"],
      },
      borderRadius: {
        lg: "var(--radius)",
        md: "calc(var(--radius) - 2px)",
        sm: "calc(var(--radius) - 4px)",
      },
    },
  },
  plugins: [],
};

export default config;
ENDOFFILE

# ============================================
# postcss.config.mjs
# ============================================
cat > postcss.config.mjs << 'ENDOFFILE'
const config = {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
  },
};

export default config;
ENDOFFILE

# ============================================
# .gitignore
# ============================================
cat > .gitignore << 'ENDOFFILE'
/node_modules
/.next/
/out/
/build
.DS_Store
*.pem
npm-debug.log*
.env*.local
.vercel
*.tsbuildinfo
next-env.d.ts
.firebase/
ENDOFFILE

# ============================================
# .env.example
# ============================================
cat > .env.example << 'ENDOFFILE'
NEXT_PUBLIC_FIREBASE_API_KEY=
NEXT_PUBLIC_FIREBASE_AUTH_DOMAIN=
NEXT_PUBLIC_FIREBASE_PROJECT_ID=
NEXT_PUBLIC_FIREBASE_STORAGE_BUCKET=
NEXT_PUBLIC_FIREBASE_MESSAGING_SENDER_ID=
NEXT_PUBLIC_FIREBASE_APP_ID=
GOOGLE_GENAI_API_KEY=
ENDOFFILE

# ============================================
# firestore.rules
# ============================================
cat > firestore.rules << 'ENDOFFILE'
rules_version = '2';

service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
      match /{subcollection}/{docId} {
        allow read, write: if request.auth != null && request.auth.uid == userId;
      }
      match /{subcollection}/{docId}/{subSub}/{subSubId} {
        allow read, write: if request.auth != null && request.auth.uid == userId;
      }
    }
    match /{document=**} {
      allow read, write: if false;
    }
  }
}
ENDOFFILE

# ============================================
# src/lib/utils.ts
# ============================================
cat > src/lib/utils.ts << 'ENDOFFILE'
import { type ClassValue, clsx } from "clsx";
import { twMerge } from "tailwind-merge";

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs));
}
ENDOFFILE

# ============================================
# src/types/index.ts
# ============================================
cat > src/types/index.ts << 'ENDOFFILE'
import type { Timestamp } from "firebase/firestore";

export interface UserProfile {
  uid: string;
  email: string;
  displayName: string;
  photoURL: string | null;
  onboardingComplete: boolean;
  createdAt: Timestamp;
  updatedAt: Timestamp;
}

export interface BirthData {
  date: string;
  time: string;
  location: string;
  latitude: number;
  longitude: number;
  timezone: string;
}

export interface UserRole {
  id: string;
  label: string;
  isPrimary: boolean;
}

export interface FocusWindow {
  id: string;
  label: string;
  startHour: number;
  endHour: number;
  energyLevel: EnergyOctave;
  daysOfWeek: number[];
}

export type EnergyOctave = "high" | "medium" | "low" | "recovery";

export interface EnergyLog {
  id: string;
  date: string;
  level: number;
  octave: EnergyOctave;
  timestamp: Timestamp;
}

export interface PlanetPosition {
  planet: string;
  sign: string;
  degree: number;
  minute: number;
  house: number;
  retrograde: boolean;
}

export interface NatalChart {
  birthData: BirthData;
  planets: PlanetPosition[];
  houses: HousePosition[];
  ascendant: { sign: string; degree: number };
  midheaven: { sign: string; degree: number };
  calculatedAt: Timestamp;
}

export interface HousePosition {
  house: number;
  sign: string;
  degree: number;
}

export interface Transit {
  planet: string;
  sign: string;
  degree: number;
  minute: number;
  retrograde: boolean;
  aspects: TransitAspect[];
}

export interface TransitAspect {
  transitPlanet: string;
  natalPlanet: string;
  aspectType: "conjunction" | "opposition" | "trine" | "square" | "sextile";
  orb: number;
  applying: boolean;
}

export interface DailyTransitCache {
  date: string;
  transits: Transit[];
  significantAspect: TransitAspect | null;
  solarPeak: number;
  calculatedAt: Timestamp;
}

export interface Intention {
  id: string;
  userId: string;
  title: string;
  description?: string;
  energyOctave: EnergyOctave;
  scheduledDate?: string;
  scheduledTime?: string;
  durationMinutes?: number;
  completed: boolean;
  completedAt?: Timestamp;
  source: "manual" | "voice" | "brain-dump" | "ai-suggested";
  createdAt: Timestamp;
  updatedAt: Timestamp;
}

export interface CalendarEvent {
  id: string;
  title: string;
  startTime: string;
  endTime: string;
  energyOctave?: EnergyOctave;
  source: "manual" | "google" | "apple";
  aiSuggestion?: {
    suggestedTime: string;
    reason: string;
    dismissed: boolean;
  };
}

export interface DailyDirective {
  command: string;
  context: string;
  transit: string;
  confidence: number;
  generatedAt: Timestamp;
}

export interface BreathworkRecommendation {
  technique: string;
  reason: string;
  durationSeconds: number;
  phases: { name: string; durationSeconds: number }[];
}

export interface SovereignWindow {
  id: string;
  label: string;
  description?: string;
  startHour: number;
  endHour: number;
  energyOctave: EnergyOctave;
  daysOfWeek: number[];
}
ENDOFFILE

# ============================================
# src/firebase/config.ts
# ============================================
cat > src/firebase/config.ts << 'ENDOFFILE'
import { initializeApp, getApps, type FirebaseApp } from "firebase/app";
import { getAuth, type Auth } from "firebase/auth";
import { getFirestore, type Firestore } from "firebase/firestore";

const firebaseConfig = {
  apiKey: process.env.NEXT_PUBLIC_FIREBASE_API_KEY,
  authDomain: process.env.NEXT_PUBLIC_FIREBASE_AUTH_DOMAIN,
  projectId: process.env.NEXT_PUBLIC_FIREBASE_PROJECT_ID,
  storageBucket: process.env.NEXT_PUBLIC_FIREBASE_STORAGE_BUCKET,
  messagingSenderId: process.env.NEXT_PUBLIC_FIREBASE_MESSAGING_SENDER_ID,
  appId: process.env.NEXT_PUBLIC_FIREBASE_APP_ID,
};

let app: FirebaseApp;
let auth: Auth;
let db: Firestore;

if (!getApps().length) {
  app = initializeApp(firebaseConfig);
} else {
  app = getApps()[0];
}

auth = getAuth(app);
db = getFirestore(app);

export { app, auth, db };
ENDOFFILE

# ============================================
# src/firebase/auth-provider.tsx
# ============================================
cat > src/firebase/auth-provider.tsx << 'ENDOFFILE'
"use client";

import {
  createContext,
  useContext,
  useEffect,
  useState,
  type ReactNode,
} from "react";
import {
  onAuthStateChanged,
  signInWithEmailAndPassword,
  createUserWithEmailAndPassword,
  signOut as firebaseSignOut,
  GoogleAuthProvider,
  signInWithPopup,
  type User,
} from "firebase/auth";
import { doc, setDoc, getDoc, serverTimestamp } from "firebase/firestore";
import { auth, db } from "./config";

interface AuthContextType {
  user: User | null;
  loading: boolean;
  signIn: (email: string, password: string) => Promise<void>;
  signUp: (email: string, password: string, displayName: string) => Promise<void>;
  signInWithGoogle: () => Promise<void>;
  signOut: () => Promise<void>;
}

const AuthContext = createContext<AuthContextType | undefined>(undefined);

export function AuthProvider({ children }: { children: ReactNode }) {
  const [user, setUser] = useState<User | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const unsubscribe = onAuthStateChanged(auth, (firebaseUser) => {
      setUser(firebaseUser);
      setLoading(false);
    });
    return () => unsubscribe();
  }, []);

  async function ensureUserDocument(firebaseUser: User) {
    const userRef = doc(db, "users", firebaseUser.uid);
    const userSnap = await getDoc(userRef);
    if (!userSnap.exists()) {
      await setDoc(userRef, {
        uid: firebaseUser.uid,
        email: firebaseUser.email,
        displayName: firebaseUser.displayName || "",
        photoURL: firebaseUser.photoURL || null,
        onboardingComplete: false,
        createdAt: serverTimestamp(),
        updatedAt: serverTimestamp(),
      });
    }
  }

  async function signIn(email: string, password: string) {
    const result = await signInWithEmailAndPassword(auth, email, password);
    await ensureUserDocument(result.user);
  }

  async function signUp(email: string, password: string, displayName: string) {
    const result = await createUserWithEmailAndPassword(auth, email, password);
    await ensureUserDocument({ ...result.user, displayName } as User);
  }

  async function signInWithGoogle() {
    const provider = new GoogleAuthProvider();
    const result = await signInWithPopup(auth, provider);
    await ensureUserDocument(result.user);
  }

  async function signOut() {
    await firebaseSignOut(auth);
  }

  return (
    <AuthContext.Provider value={{ user, loading, signIn, signUp, signInWithGoogle, signOut }}>
      {children}
    </AuthContext.Provider>
  );
}

export function useAuth() {
  const context = useContext(AuthContext);
  if (context === undefined) {
    throw new Error("useAuth must be used within an AuthProvider");
  }
  return context;
}
ENDOFFILE

# ============================================
# src/firebase/index.ts
# ============================================
cat > src/firebase/index.ts << 'ENDOFFILE'
export { app, auth, db } from "./config";
export { AuthProvider, useAuth } from "./auth-provider";
ENDOFFILE

# ============================================
# src/services/firestore.ts
# ============================================
cat > src/services/firestore.ts << 'ENDOFFILE'
import {
  doc, getDoc, setDoc, updateDoc, collection, query, where, orderBy,
  getDocs, deleteDoc, serverTimestamp, onSnapshot, type Unsubscribe,
} from "firebase/firestore";
import { db } from "@/firebase/config";
import type {
  UserProfile, NatalChart, Intention, EnergyLog, DailyTransitCache,
  SovereignWindow, BirthData, UserRole,
} from "@/types";

function userDoc(userId: string) {
  return doc(db, "users", userId);
}

function userSubcollection(userId: string, subcollection: string) {
  return collection(db, "users", userId, subcollection);
}

export async function getUserProfile(userId: string): Promise<UserProfile | null> {
  const snap = await getDoc(userDoc(userId));
  return snap.exists() ? (snap.data() as UserProfile) : null;
}

export async function updateUserProfile(userId: string, data: Partial<UserProfile>) {
  await updateDoc(userDoc(userId), { ...data, updatedAt: serverTimestamp() });
}

export function onUserProfile(userId: string, callback: (profile: UserProfile | null) => void): Unsubscribe {
  return onSnapshot(userDoc(userId), (snap) => {
    callback(snap.exists() ? (snap.data() as UserProfile) : null);
  });
}

export async function saveOnboardingData(userId: string, data: {
  birthData?: BirthData;
  roles?: UserRole[];
  focusWindows?: SovereignWindow[];
}) {
  if (data.birthData) {
    await setDoc(doc(db, "users", userId, "celestial", "birthData"), { ...data.birthData, updatedAt: serverTimestamp() });
  }
  if (data.roles) {
    await setDoc(doc(db, "users", userId, "celestial", "roles"), { roles: data.roles, updatedAt: serverTimestamp() });
  }
  if (data.focusWindows) {
    await setDoc(doc(db, "users", userId, "celestial", "focusWindows"), { windows: data.focusWindows, updatedAt: serverTimestamp() });
  }
  await updateUserProfile(userId, { onboardingComplete: true });
}

export async function getBirthData(userId: string): Promise<BirthData | null> {
  const snap = await getDoc(doc(db, "users", userId, "celestial", "birthData"));
  return snap.exists() ? (snap.data() as BirthData) : null;
}

export async function getUserRoles(userId: string): Promise<UserRole[]> {
  const snap = await getDoc(doc(db, "users", userId, "celestial", "roles"));
  return snap.exists() ? (snap.data().roles as UserRole[]) : [];
}

export async function getFocusWindows(userId: string): Promise<SovereignWindow[]> {
  const snap = await getDoc(doc(db, "users", userId, "celestial", "focusWindows"));
  return snap.exists() ? (snap.data().windows as SovereignWindow[]) : [];
}

export async function saveNatalChart(userId: string, chart: NatalChart) {
  await setDoc(doc(db, "users", userId, "celestial", "natalChart"), { ...chart, calculatedAt: serverTimestamp() });
}

export async function getNatalChart(userId: string): Promise<NatalChart | null> {
  const snap = await getDoc(doc(db, "users", userId, "celestial", "natalChart"));
  return snap.exists() ? (snap.data() as NatalChart) : null;
}

export async function cacheDailyTransits(userId: string, data: Omit<DailyTransitCache, "calculatedAt">) {
  await setDoc(doc(db, "users", userId, "cache", "dailyTransits"), { ...data, calculatedAt: serverTimestamp() });
}

export async function getCachedTransits(userId: string): Promise<DailyTransitCache | null> {
  const snap = await getDoc(doc(db, "users", userId, "cache", "dailyTransits"));
  if (!snap.exists()) return null;
  const data = snap.data() as DailyTransitCache;
  const today = new Date().toISOString().split("T")[0];
  if (data.date !== today) return null;
  return data;
}

export async function createIntention(userId: string, intention: Omit<Intention, "id" | "userId" | "createdAt" | "updatedAt">): Promise<string> {
  const ref = doc(userSubcollection(userId, "intentions"));
  await setDoc(ref, { ...intention, id: ref.id, userId, createdAt: serverTimestamp(), updatedAt: serverTimestamp() });
  return ref.id;
}

export async function updateIntention(userId: string, intentionId: string, data: Partial<Intention>) {
  await updateDoc(doc(db, "users", userId, "intentions", intentionId), { ...data, updatedAt: serverTimestamp() });
}

export async function deleteIntention(userId: string, intentionId: string) {
  await deleteDoc(doc(db, "users", userId, "intentions", intentionId));
}

export async function getIntentionsForDate(userId: string, date: string): Promise<Intention[]> {
  const q = query(userSubcollection(userId, "intentions"), where("scheduledDate", "==", date), orderBy("scheduledTime", "asc"));
  const snap = await getDocs(q);
  return snap.docs.map((d) => d.data() as Intention);
}

export async function getIncompleteIntentions(userId: string): Promise<Intention[]> {
  const q = query(userSubcollection(userId, "intentions"), where("completed", "==", false), orderBy("createdAt", "desc"));
  const snap = await getDocs(q);
  return snap.docs.map((d) => d.data() as Intention);
}

export function onTodayIntentions(userId: string, callback: (intentions: Intention[]) => void): Unsubscribe {
  const today = new Date().toISOString().split("T")[0];
  const q = query(userSubcollection(userId, "intentions"), where("scheduledDate", "==", today), orderBy("scheduledTime", "asc"));
  return onSnapshot(q, (snap) => { callback(snap.docs.map((d) => d.data() as Intention)); });
}

export async function logEnergy(userId: string, data: Omit<EnergyLog, "id" | "timestamp">) {
  const ref = doc(userSubcollection(userId, "energyLogs"));
  await setDoc(ref, { ...data, id: ref.id, timestamp: serverTimestamp() });
}

export async function getTodayEnergy(userId: string): Promise<EnergyLog | null> {
  const today = new Date().toISOString().split("T")[0];
  const q = query(userSubcollection(userId, "energyLogs"), where("date", "==", today), orderBy("timestamp", "desc"));
  const snap = await getDocs(q);
  return snap.docs.length > 0 ? (snap.docs[0].data() as EnergyLog) : null;
}
ENDOFFILE

# ============================================
# src/hooks/use-user-data.ts
# ============================================
cat > src/hooks/use-user-data.ts << 'ENDOFFILE'
"use client";

import { useEffect, useState } from "react";
import { useAuth } from "@/firebase/auth-provider";
import { onUserProfile, getBirthData, getUserRoles, getFocusWindows, getNatalChart } from "@/services/firestore";
import type { UserProfile, BirthData, UserRole, SovereignWindow, NatalChart } from "@/types";

interface UserData {
  profile: UserProfile | null;
  birthData: BirthData | null;
  roles: UserRole[];
  focusWindows: SovereignWindow[];
  natalChart: NatalChart | null;
  loading: boolean;
  error: Error | null;
}

export function useUserData(): UserData {
  const { user } = useAuth();
  const [profile, setProfile] = useState<UserProfile | null>(null);
  const [birthData, setBirthData] = useState<BirthData | null>(null);
  const [roles, setRoles] = useState<UserRole[]>([]);
  const [focusWindows, setFocusWindows] = useState<SovereignWindow[]>([]);
  const [natalChart, setNatalChart] = useState<NatalChart | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<Error | null>(null);

  useEffect(() => {
    if (!user) {
      setProfile(null); setBirthData(null); setRoles([]); setFocusWindows([]); setNatalChart(null); setLoading(false);
      return;
    }
    const unsubProfile = onUserProfile(user.uid, (p) => setProfile(p));
    async function fetchData() {
      try {
        const [bd, r, fw, nc] = await Promise.all([
          getBirthData(user!.uid), getUserRoles(user!.uid), getFocusWindows(user!.uid), getNatalChart(user!.uid),
        ]);
        setBirthData(bd); setRoles(r); setFocusWindows(fw); setNatalChart(nc);
      } catch (err) {
        setError(err instanceof Error ? err : new Error("Failed to fetch user data"));
      } finally { setLoading(false); }
    }
    fetchData();
    return () => unsubProfile();
  }, [user]);

  return { profile, birthData, roles, focusWindows, natalChart, loading, error };
}
ENDOFFILE

# ============================================
# src/hooks/use-today-intentions.ts
# ============================================
cat > src/hooks/use-today-intentions.ts << 'ENDOFFILE'
"use client";

import { useEffect, useState } from "react";
import { useAuth } from "@/firebase/auth-provider";
import { onTodayIntentions } from "@/services/firestore";
import type { Intention } from "@/types";

export function useTodayIntentions() {
  const { user } = useAuth();
  const [intentions, setIntentions] = useState<Intention[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    if (!user) { setIntentions([]); setLoading(false); return; }
    const unsubscribe = onTodayIntentions(user.uid, (data) => { setIntentions(data); setLoading(false); });
    return () => unsubscribe();
  }, [user]);

  return { intentions, loading };
}
ENDOFFILE

# ============================================
# src/app/globals.css
# ============================================
cat > src/app/globals.css << 'ENDOFFILE'
@tailwind base;
@tailwind components;
@tailwind utilities;

@layer base {
  :root { --radius: 0.75rem; }

  .dark, :root {
    --background: 230 20% 7%;
    --foreground: 40 10% 92%;
    --card: 230 18% 11%;
    --card-foreground: 40 10% 92%;
    --muted: 230 15% 18%;
    --muted-foreground: 230 10% 55%;
    --border: 230 15% 15%;
    --input: 230 15% 15%;
    --ring: 251 39% 50%;
    --cosmic: 251 39% 42%;
    --cosmic-glow: 251 60% 65%;
    --golden: 38 90% 55%;
    --destructive: 0 72% 51%;
    --destructive-foreground: 0 0% 98%;
    --energy-high: 38 90% 55%;
    --energy-medium: 251 39% 55%;
    --energy-low: 200 60% 50%;
    --energy-recovery: 160 50% 45%;
  }

  .light {
    --background: 40 20% 97%;
    --foreground: 230 15% 12%;
    --card: 40 15% 94%;
    --card-foreground: 230 15% 12%;
    --muted: 40 10% 88%;
    --muted-foreground: 230 10% 45%;
    --border: 40 10% 88%;
    --input: 40 10% 88%;
    --ring: 251 39% 50%;
    --cosmic: 251 39% 42%;
    --cosmic-glow: 251 50% 55%;
    --golden: 38 85% 48%;
    --destructive: 0 72% 51%;
    --destructive-foreground: 0 0% 98%;
    --energy-high: 38 85% 48%;
    --energy-medium: 251 35% 48%;
    --energy-low: 200 55% 42%;
    --energy-recovery: 160 45% 38%;
  }
}

@layer base {
  * { @apply border-border; }
  body { @apply bg-background text-foreground antialiased; font-feature-settings: "cv11", "ss01"; }
  html { scroll-behavior: smooth; }
  ::selection { background: hsl(251 39% 42% / 0.3); }
  ::-webkit-scrollbar { width: 6px; height: 6px; }
  ::-webkit-scrollbar-track { background: transparent; }
  ::-webkit-scrollbar-thumb { background: hsl(230 15% 25%); border-radius: 3px; }
  ::-webkit-scrollbar-thumb:hover { background: hsl(230 15% 35%); }
}

@layer utilities {
  .glass { background: hsl(var(--card) / 0.6); backdrop-filter: blur(16px); border: 1px solid hsl(var(--border) / 0.5); }
  .cosmic-gradient { background: linear-gradient(135deg, hsl(251 30% 15% / 0.9), hsl(251 25% 12% / 0.95)); border: 1px solid hsl(var(--cosmic) / 0.15); }
  .cosmic-glow { box-shadow: 0 0 20px hsl(var(--cosmic-glow) / 0.1), 0 0 40px hsl(var(--cosmic-glow) / 0.05); }
  .golden-glow { box-shadow: 0 0 15px hsl(var(--golden) / 0.2), 0 0 30px hsl(var(--golden) / 0.1); }
  .text-cosmic-gradient { background: linear-gradient(135deg, hsl(var(--cosmic-glow)), hsl(var(--golden))); -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text; }
  .energy-high { color: hsl(var(--energy-high)); background: hsl(var(--energy-high) / 0.1); border-color: hsl(var(--energy-high) / 0.3); }
  .energy-medium { color: hsl(var(--energy-medium)); background: hsl(var(--energy-medium) / 0.1); border-color: hsl(var(--energy-medium) / 0.3); }
  .energy-low { color: hsl(var(--energy-low)); background: hsl(var(--energy-low) / 0.1); border-color: hsl(var(--energy-low) / 0.3); }
  .energy-recovery { color: hsl(var(--energy-recovery)); background: hsl(var(--energy-recovery) / 0.1); border-color: hsl(var(--energy-recovery) / 0.3); }
  .label-upper { @apply text-[11px] font-semibold tracking-[0.08em] uppercase text-muted-foreground; }
}
ENDOFFILE

# ============================================
# src/app/layout.tsx
# ============================================
cat > src/app/layout.tsx << 'ENDOFFILE'
import type { Metadata } from "next";
import { Instrument_Serif, DM_Sans } from "next/font/google";
import { AuthProvider } from "@/firebase/auth-provider";
import "./globals.css";

const serif = Instrument_Serif({ subsets: ["latin"], weight: "400", variable: "--font-serif", display: "swap" });
const sans = DM_Sans({ subsets: ["latin"], weight: ["300", "400", "500", "600", "700"], variable: "--font-sans", display: "swap" });

export const metadata: Metadata = { title: "Octave OS", description: "Align your work with your energy." };

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="en" className="dark">
      <body className={`${serif.variable} ${sans.variable} font-sans`}>
        <AuthProvider>{children}</AuthProvider>
      </body>
    </html>
  );
}
ENDOFFILE

# ============================================
# src/app/page.tsx
# ============================================
cat > src/app/page.tsx << 'ENDOFFILE'
import { redirect } from "next/navigation";
export default function Home() { redirect("/dashboard"); }
ENDOFFILE

# ============================================
# src/app/(auth)/layout.tsx
# ============================================
cat > 'src/app/(auth)/layout.tsx' << 'ENDOFFILE'
export default function AuthLayout({ children }: { children: React.ReactNode }) {
  return (
    <div className="min-h-screen flex items-center justify-center bg-background">
      <div className="fixed inset-0 pointer-events-none">
        <div className="absolute top-[-20%] right-[-10%] w-[500px] h-[500px] rounded-full bg-[radial-gradient(circle,hsl(251_39%_42%/0.06),transparent_70%)]" />
        <div className="absolute bottom-[-20%] left-[-10%] w-[400px] h-[400px] rounded-full bg-[radial-gradient(circle,hsl(38_90%_55%/0.03),transparent_70%)]" />
      </div>
      <div className="relative z-10 w-full max-w-md px-6">{children}</div>
    </div>
  );
}
ENDOFFILE

# ============================================
# src/app/(auth)/login/page.tsx
# ============================================
cat > 'src/app/(auth)/login/page.tsx' << 'ENDOFFILE'
"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import Link from "next/link";
import { useAuth } from "@/firebase/auth-provider";

export default function LoginPage() {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [error, setError] = useState("");
  const [loading, setLoading] = useState(false);
  const { signIn, signInWithGoogle } = useAuth();
  const router = useRouter();

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault(); setError(""); setLoading(true);
    try { await signIn(email, password); router.push("/dashboard"); }
    catch (err: any) { setError(err.code === "auth/invalid-credential" ? "Invalid email or password." : "Something went wrong. Please try again."); }
    finally { setLoading(false); }
  }

  async function handleGoogle() {
    setError("");
    try { await signInWithGoogle(); router.push("/dashboard"); }
    catch { setError("Google sign-in failed. Please try again."); }
  }

  return (
    <div className="space-y-8">
      <div className="text-center space-y-2">
        <div className="w-12 h-12 rounded-full mx-auto mb-4 flex items-center justify-center text-lg font-bold bg-gradient-to-br from-[hsl(251,39%,42%)] to-[hsl(38,90%,55%)] text-white/90">O</div>
        <h1 className="font-serif text-3xl text-foreground">Welcome back</h1>
        <p className="text-muted-foreground text-sm">Sign in to continue your practice.</p>
      </div>
      {error && <div className="p-3 rounded-lg bg-destructive/10 border border-destructive/20 text-destructive text-sm text-center">{error}</div>}
      <form onSubmit={handleSubmit} className="space-y-4">
        <div className="space-y-2">
          <label htmlFor="email" className="label-upper block">Email</label>
          <input id="email" type="email" value={email} onChange={(e) => setEmail(e.target.value)} required className="w-full px-4 py-3 rounded-xl bg-card border border-border text-foreground placeholder:text-muted-foreground focus:outline-none focus:ring-2 focus:ring-cosmic/30 focus:border-cosmic/50 transition-all text-sm" placeholder="you@example.com" />
        </div>
        <div className="space-y-2">
          <label htmlFor="password" className="label-upper block">Password</label>
          <input id="password" type="password" value={password} onChange={(e) => setPassword(e.target.value)} required className="w-full px-4 py-3 rounded-xl bg-card border border-border text-foreground placeholder:text-muted-foreground focus:outline-none focus:ring-2 focus:ring-cosmic/30 focus:border-cosmic/50 transition-all text-sm" placeholder="••••••••" />
        </div>
        <button type="submit" disabled={loading} className="w-full py-3 rounded-xl bg-[hsl(251,39%,42%)] hover:bg-[hsl(251,39%,48%)] text-white font-medium text-sm transition-all disabled:opacity-50 disabled:cursor-not-allowed">{loading ? "Signing in..." : "Sign in"}</button>
      </form>
      <div className="relative"><div className="absolute inset-0 flex items-center"><div className="w-full border-t border-border" /></div><div className="relative flex justify-center text-xs"><span className="px-3 bg-background text-muted-foreground">or</span></div></div>
      <button onClick={handleGoogle} className="w-full py-3 rounded-xl bg-card hover:bg-muted border border-border text-foreground font-medium text-sm transition-all flex items-center justify-center gap-3">
        <svg className="w-4 h-4" viewBox="0 0 24 24"><path d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92a5.06 5.06 0 01-2.2 3.32v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.1z" fill="#4285F4"/><path d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z" fill="#34A853"/><path d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z" fill="#FBBC05"/><path d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z" fill="#EA4335"/></svg>
        Continue with Google
      </button>
      <p className="text-center text-sm text-muted-foreground">New to Octave?{" "}<Link href="/signup" className="text-[hsl(251,60%,65%)] hover:text-[hsl(251,60%,75%)] transition-colors">Create an account</Link></p>
    </div>
  );
}
ENDOFFILE

# ============================================
# src/app/(auth)/signup/page.tsx
# ============================================
cat > 'src/app/(auth)/signup/page.tsx' << 'ENDOFFILE'
"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import Link from "next/link";
import { useAuth } from "@/firebase/auth-provider";

export default function SignupPage() {
  const [name, setName] = useState("");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [error, setError] = useState("");
  const [loading, setLoading] = useState(false);
  const { signUp, signInWithGoogle } = useAuth();
  const router = useRouter();

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault(); setError("");
    if (password.length < 6) { setError("Password must be at least 6 characters."); return; }
    setLoading(true);
    try { await signUp(email, password, name); router.push("/onboarding"); }
    catch (err: any) { setError(err.code === "auth/email-already-in-use" ? "An account with this email already exists." : "Something went wrong. Please try again."); }
    finally { setLoading(false); }
  }

  async function handleGoogle() {
    setError("");
    try { await signInWithGoogle(); router.push("/dashboard"); }
    catch { setError("Google sign-in failed. Please try again."); }
  }

  return (
    <div className="space-y-8">
      <div className="text-center space-y-2">
        <div className="w-12 h-12 rounded-full mx-auto mb-4 flex items-center justify-center text-lg font-bold bg-gradient-to-br from-[hsl(251,39%,42%)] to-[hsl(38,90%,55%)] text-white/90">O</div>
        <h1 className="font-serif text-3xl text-foreground">Begin your practice</h1>
        <p className="text-muted-foreground text-sm">Create your account to start aligning.</p>
      </div>
      {error && <div className="p-3 rounded-lg bg-destructive/10 border border-destructive/20 text-destructive text-sm text-center">{error}</div>}
      <form onSubmit={handleSubmit} className="space-y-4">
        <div className="space-y-2">
          <label htmlFor="name" className="label-upper block">Name</label>
          <input id="name" type="text" value={name} onChange={(e) => setName(e.target.value)} required className="w-full px-4 py-3 rounded-xl bg-card border border-border text-foreground placeholder:text-muted-foreground focus:outline-none focus:ring-2 focus:ring-cosmic/30 focus:border-cosmic/50 transition-all text-sm" placeholder="Your name" />
        </div>
        <div className="space-y-2">
          <label htmlFor="email" className="label-upper block">Email</label>
          <input id="email" type="email" value={email} onChange={(e) => setEmail(e.target.value)} required className="w-full px-4 py-3 rounded-xl bg-card border border-border text-foreground placeholder:text-muted-foreground focus:outline-none focus:ring-2 focus:ring-cosmic/30 focus:border-cosmic/50 transition-all text-sm" placeholder="you@example.com" />
        </div>
        <div className="space-y-2">
          <label htmlFor="password" className="label-upper block">Password</label>
          <input id="password" type="password" value={password} onChange={(e) => setPassword(e.target.value)} required minLength={6} className="w-full px-4 py-3 rounded-xl bg-card border border-border text-foreground placeholder:text-muted-foreground focus:outline-none focus:ring-2 focus:ring-cosmic/30 focus:border-cosmic/50 transition-all text-sm" placeholder="At least 6 characters" />
        </div>
        <button type="submit" disabled={loading} className="w-full py-3 rounded-xl bg-[hsl(251,39%,42%)] hover:bg-[hsl(251,39%,48%)] text-white font-medium text-sm transition-all disabled:opacity-50 disabled:cursor-not-allowed">{loading ? "Creating account..." : "Create account"}</button>
      </form>
      <div className="relative"><div className="absolute inset-0 flex items-center"><div className="w-full border-t border-border" /></div><div className="relative flex justify-center text-xs"><span className="px-3 bg-background text-muted-foreground">or</span></div></div>
      <button onClick={handleGoogle} className="w-full py-3 rounded-xl bg-card hover:bg-muted border border-border text-foreground font-medium text-sm transition-all flex items-center justify-center gap-3">
        <svg className="w-4 h-4" viewBox="0 0 24 24"><path d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92a5.06 5.06 0 01-2.2 3.32v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.1z" fill="#4285F4"/><path d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z" fill="#34A853"/><path d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z" fill="#FBBC05"/><path d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z" fill="#EA4335"/></svg>
        Continue with Google
      </button>
      <p className="text-center text-sm text-muted-foreground">Already have an account?{" "}<Link href="/login" className="text-[hsl(251,60%,65%)] hover:text-[hsl(251,60%,75%)] transition-colors">Sign in</Link></p>
    </div>
  );
}
ENDOFFILE

# ============================================
# src/components/layout/sidebar.tsx
# ============================================
cat > src/components/layout/sidebar.tsx << 'ENDOFFILE'
"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import { cn } from "@/lib/utils";

const NAV_ITEMS = [
  { href: "/dashboard", label: "Dashboard", icon: "◉" },
  { href: "/daily-flow", label: "Daily Flow", icon: "☰" },
  { href: "/weekly-rhythm", label: "Weekly", icon: "▦" },
  { href: "/breath", label: "Breathwork", icon: "◎" },
  { href: "/oracle", label: "Oracle", icon: "✦" },
  { href: "/settings", label: "Settings", icon: "⚙" },
];

export function Sidebar() {
  const pathname = usePathname();
  return (
    <>
      <nav className="hidden md:flex fixed left-0 top-0 bottom-0 w-16 bg-background/60 backdrop-blur-xl border-r border-border/50 flex-col items-center pt-6 gap-1.5 z-50">
        <Link href="/dashboard" className="w-9 h-9 rounded-full bg-gradient-to-br from-cosmic to-golden flex items-center justify-center text-sm font-bold text-white/90 mb-5 hover:scale-105 transition-transform">O</Link>
        {NAV_ITEMS.map((item) => {
          const isActive = pathname === item.href;
          return (
            <Link key={item.href} href={item.href} title={item.label}
              className={cn("w-10 h-10 rounded-xl flex items-center justify-center text-base transition-all duration-200",
                isActive ? "bg-cosmic/15 text-cosmic-glow" : "text-muted-foreground hover:text-foreground hover:bg-muted/30"
              )}>{item.icon}</Link>
          );
        })}
      </nav>
      <nav className="md:hidden fixed bottom-0 left-0 right-0 h-16 bg-background/80 backdrop-blur-xl border-t border-border/50 flex items-center justify-around px-2 z-50">
        {NAV_ITEMS.slice(0, 5).map((item) => {
          const isActive = pathname === item.href;
          return (
            <Link key={item.href} href={item.href} className={cn("flex flex-col items-center gap-1 py-1 px-3 rounded-lg transition-all", isActive ? "text-cosmic-glow" : "text-muted-foreground")}>
              <span className="text-lg">{item.icon}</span>
              <span className="text-[10px] font-medium">{item.label}</span>
            </Link>
          );
        })}
      </nav>
    </>
  );
}
ENDOFFILE

# ============================================
# src/components/layout/auth-guard.tsx
# ============================================
cat > src/components/layout/auth-guard.tsx << 'ENDOFFILE'
"use client";

import { useEffect } from "react";
import { useRouter, usePathname } from "next/navigation";
import { useAuth } from "@/firebase/auth-provider";

export function AuthGuard({ children }: { children: React.ReactNode }) {
  const { user, loading } = useAuth();
  const router = useRouter();
  const pathname = usePathname();

  useEffect(() => {
    if (loading) return;
    if (!user) { router.replace("/login"); return; }
  }, [user, loading, router, pathname]);

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-background">
        <div className="w-10 h-10 rounded-full border-2 border-cosmic/30 border-t-cosmic animate-spin" />
      </div>
    );
  }
  if (!user) return null;
  return <>{children}</>;
}
ENDOFFILE

# ============================================
# src/app/(main)/layout.tsx
# ============================================
cat > 'src/app/(main)/layout.tsx' << 'ENDOFFILE'
import { Sidebar } from "@/components/layout/sidebar";
import { AuthGuard } from "@/components/layout/auth-guard";

export default function MainLayout({ children }: { children: React.ReactNode }) {
  return (
    <AuthGuard>
      <div className="min-h-screen bg-background">
        <div className="fixed inset-0 pointer-events-none overflow-hidden">
          <div className="absolute top-[-200px] right-[-200px] w-[600px] h-[600px] rounded-full bg-[radial-gradient(circle,hsl(251_39%_42%/0.06),transparent_70%)]" />
          <div className="absolute bottom-[-300px] left-[-100px] w-[500px] h-[500px] rounded-full bg-[radial-gradient(circle,hsl(38_90%_55%/0.03),transparent_70%)]" />
        </div>
        <Sidebar />
        <main className="relative md:ml-16 min-h-screen pb-20 md:pb-0">
          <div className="max-w-4xl mx-auto px-5 md:px-10 py-8">{children}</div>
        </main>
      </div>
    </AuthGuard>
  );
}
ENDOFFILE

# ============================================
# src/app/(main)/dashboard/page.tsx
# ============================================
cat > 'src/app/(main)/dashboard/page.tsx' << 'ENDOFFILE'
"use client";

import { useState, useEffect } from "react";
import { useRouter } from "next/navigation";
import { useAuth } from "@/firebase/auth-provider";
import { useUserData } from "@/hooks/use-user-data";
import { useTodayIntentions } from "@/hooks/use-today-intentions";
import type { EnergyOctave } from "@/types";

const ENERGY_CONFIG: Record<EnergyOctave, { label: string; className: string }> = {
  high: { label: "High Focus", className: "energy-high" },
  medium: { label: "Steady", className: "energy-medium" },
  low: { label: "Light", className: "energy-low" },
  recovery: { label: "Recovery", className: "energy-recovery" },
};

const ENERGY_LABELS = ["Depleted", "Low", "Steady", "Energized", "Peak"];

function ScheduleRow({ title, time, duration, energy }: { title: string; time: string; duration: number; energy: EnergyOctave }) {
  const config = ENERGY_CONFIG[energy];
  return (
    <div className="flex items-center gap-3 px-3 py-2.5 rounded-xl hover:bg-muted/5 transition-colors cursor-pointer group">
      <div className="w-0.5 h-9 rounded-full flex-shrink-0" style={{ backgroundColor: `hsl(var(--energy-${energy}) / 0.4)` }} />
      <div className="flex-1 min-w-0">
        <div className="text-sm font-medium text-foreground/88 truncate group-hover:text-foreground transition-colors">{title}</div>
        <div className="text-xs text-muted-foreground">{time} · {duration}m</div>
      </div>
      <span className={`text-[10px] font-medium px-2 py-0.5 rounded-full border flex-shrink-0 ${config.className}`}>{config.label}</span>
    </div>
  );
}

export default function DashboardPage() {
  const router = useRouter();
  const { user } = useAuth();
  const { profile, loading: profileLoading } = useUserData();
  const { intentions } = useTodayIntentions();
  const [energy, setEnergy] = useState(65);
  const [directiveVisible, setDirectiveVisible] = useState(false);

  useEffect(() => {
    if (!profileLoading && profile && !profile.onboardingComplete) router.replace("/onboarding");
  }, [profile, profileLoading, router]);

  useEffect(() => { const t = setTimeout(() => setDirectiveVisible(true), 300); return () => clearTimeout(t); }, []);

  const now = new Date();
  const greeting = now.getHours() < 12 ? "Good morning" : now.getHours() < 17 ? "Good afternoon" : "Good evening";
  const dateStr = now.toLocaleDateString("en-US", { weekday: "long", month: "long", day: "numeric" });
  const displayName = profile?.displayName || user?.displayName || "Architect";
  const energyLabel = ENERGY_LABELS[Math.min(Math.floor(energy / 25), 4)];

  if (profileLoading) return <div className="flex items-center justify-center min-h-[60vh]"><div className="w-8 h-8 rounded-full border-2 border-cosmic/30 border-t-cosmic animate-spin" /></div>;

  const schedule = intentions.length > 0
    ? intentions.map(i => ({ title: i.title, time: i.scheduledTime || "", duration: i.durationMinutes || 30, energy: i.energyOctave }))
    : [
        { title: "Morning Focus Block", time: "8:00 AM", duration: 90, energy: "high" as EnergyOctave },
        { title: "Team Standup", time: "9:30 AM", duration: 30, energy: "medium" as EnergyOctave },
        { title: "Contract Review", time: "10:30 AM", duration: 60, energy: "high" as EnergyOctave },
        { title: "Lunch & Reset", time: "12:00 PM", duration: 60, energy: "recovery" as EnergyOctave },
        { title: "Creative Exploration", time: "1:00 PM", duration: 120, energy: "medium" as EnergyOctave },
        { title: "Email & Admin", time: "3:00 PM", duration: 45, energy: "low" as EnergyOctave },
      ];

  return (
    <div className="space-y-6">
      <header className="space-y-1">
        <p className="label-upper">{dateStr}</p>
        <h1 className="font-serif text-3xl md:text-4xl text-foreground/92 leading-tight">{greeting}, {displayName}.</h1>
      </header>

      <div className="grid grid-cols-1 lg:grid-cols-[1fr_320px] gap-5 items-start">
        <div className="space-y-5">
          <div className="cosmic-gradient rounded-2xl p-7 relative overflow-hidden transition-all duration-700 ease-out" style={{ opacity: directiveVisible ? 1 : 0, transform: directiveVisible ? "translateY(0)" : "translateY(12px)" }}>
            <div className="absolute inset-0 bg-[radial-gradient(ellipse_at_20%_20%,hsl(251_39%_42%/0.08),transparent_60%)] pointer-events-none" />
            <div className="relative space-y-4">
              <div className="flex items-center gap-2">
                <span className="label-upper text-cosmic-glow/60">Daily Directive</span>
                <span className="text-[10px] text-golden/60 bg-golden/8 border border-golden/15 px-2 py-0.5 rounded-full">Mercury ☌ Saturn</span>
              </div>
              <h2 className="font-serif text-2xl md:text-[28px] text-foreground/95 leading-snug">Lead with precision today.</h2>
              <p className="text-sm text-muted-foreground leading-relaxed max-w-xl">Mercury trines your natal Saturn — your communication is unusually sharp. Use the morning for decisions you&apos;ve been postponing. After 2pm, shift to creative work as Venus enters your 5th house.</p>
            </div>
          </div>

          <div className="bg-card/60 border border-border/50 rounded-xl p-5">
            <div className="flex justify-between items-center mb-3">
              <span className="label-upper">Energy</span>
              <span className={`text-xs font-semibold ${energy >= 75 ? "text-energy-high" : energy >= 50 ? "text-energy-medium" : energy >= 25 ? "text-energy-low" : "text-muted-foreground"}`}>{energyLabel}</span>
            </div>
            <input type="range" min={0} max={100} value={energy} onChange={(e) => setEnergy(Number(e.target.value))}
              className="w-full h-1 rounded-full appearance-none cursor-pointer [&::-webkit-slider-thumb]:appearance-none [&::-webkit-slider-thumb]:w-4 [&::-webkit-slider-thumb]:h-4 [&::-webkit-slider-thumb]:rounded-full [&::-webkit-slider-thumb]:bg-white [&::-webkit-slider-thumb]:shadow-md [&::-webkit-slider-thumb]:cursor-pointer"
              style={{ background: "linear-gradient(to right, hsl(200 60% 50% / 0.6), hsl(251 39% 55% / 0.6), hsl(38 90% 55% / 0.8))" }} />
          </div>

          <div className="bg-card/60 border border-border/50 rounded-xl p-5">
            <span className="label-upper block mb-3">Current Transits</span>
            <div className="flex gap-2 overflow-x-auto pb-1">
              {[{ symbol: "☉", planet: "Sun", sign: "Pisces", degree: "3°42'" }, { symbol: "☽", planet: "Moon", sign: "Leo", degree: "17°15'" }, { symbol: "☿", planet: "Mercury", sign: "Aquarius", degree: "22°08'" }, { symbol: "♀", planet: "Venus", sign: "Aries", degree: "1°30'" }, { symbol: "♂", planet: "Mars", sign: "Cancer", degree: "14°52'" }].map((t) => (
                <div key={t.planet} className="flex flex-col items-center gap-1 p-2.5 rounded-xl bg-muted/20 border border-border/30 min-w-[68px]">
                  <span className="text-lg text-cosmic-glow/70">{t.symbol}</span>
                  <span className="text-[11px] font-semibold text-foreground/70">{t.sign}</span>
                  <span className="text-[10px] text-muted-foreground">{t.degree}</span>
                </div>
              ))}
            </div>
          </div>
        </div>

        <div className="bg-card/60 border border-border/50 rounded-xl p-5">
          <div className="flex justify-between items-center mb-3">
            <span className="label-upper">Today&apos;s Flow</span>
            <button className="text-[11px] text-cosmic-glow/50 hover:text-cosmic-glow/80 transition-colors">View all →</button>
          </div>
          <div className="space-y-0.5">
            {schedule.map((item, i) => <ScheduleRow key={i} {...item} />)}
          </div>
          <button className="w-full mt-3 py-2.5 px-4 rounded-xl border border-dashed border-border/40 text-muted-foreground text-sm hover:bg-muted/10 hover:border-border/60 transition-all flex items-center gap-2">
            <span className="text-base font-light">+</span> Add to today
          </button>
        </div>
      </div>

      <div className="bg-card/60 border border-border/50 rounded-xl p-4 flex items-center gap-4">
        <span className="label-upper whitespace-nowrap">Solar Peak</span>
        <div className="flex-1 h-1 bg-muted/20 rounded-full relative overflow-visible">
          <div className="absolute left-0 top-0 h-full rounded-full" style={{ width: "62%", background: "linear-gradient(90deg, hsl(38 90% 55% / 0.3), hsl(38 90% 55% / 0.7))" }} />
          <div className="absolute top-1/2 -translate-y-1/2 w-3 h-3 rounded-full bg-golden shadow-[0_0_10px_hsl(38_90%_55%/0.4)]" style={{ left: "62%", transform: "translate(-50%, -50%)" }} />
        </div>
        <span className="text-sm font-semibold text-golden/80 tabular-nums">62%</span>
      </div>
    </div>
  );
}
ENDOFFILE

# ============================================
# Placeholder pages
# ============================================
cat > 'src/app/(main)/daily-flow/page.tsx' << 'ENDOFFILE'
export default function DailyFlowPage() {
  return (
    <div className="space-y-6">
      <header><p className="label-upper">Timeline</p><h1 className="font-serif text-3xl text-foreground/92">Daily Flow</h1></header>
      <div className="bg-card/60 border border-border/50 rounded-xl p-10 text-center text-muted-foreground">
        <p className="text-sm">Your daily timeline will appear here.</p>
        <p className="text-xs mt-2 text-muted-foreground/50">Phase 5 — Coming soon</p>
      </div>
    </div>
  );
}
ENDOFFILE

cat > 'src/app/(main)/weekly-rhythm/page.tsx' << 'ENDOFFILE'
export default function WeeklyRhythmPage() {
  return (
    <div className="space-y-6">
      <header><p className="label-upper">Planning</p><h1 className="font-serif text-3xl text-foreground/92">Weekly Architecture</h1></header>
      <div className="bg-card/60 border border-border/50 rounded-xl p-10 text-center text-muted-foreground">
        <p className="text-sm">Your weekly board will appear here.</p>
        <p className="text-xs mt-2 text-muted-foreground/50">Phase 5 — Coming soon</p>
      </div>
    </div>
  );
}
ENDOFFILE

cat > 'src/app/(main)/breath/page.tsx' << 'ENDOFFILE'
export default function BreathPage() {
  return (
    <div className="space-y-6">
      <header><p className="label-upper">Somatic</p><h1 className="font-serif text-3xl text-foreground/92">Breathwork Center</h1></header>
      <div className="bg-card/60 border border-border/50 rounded-xl p-10 text-center text-muted-foreground">
        <p className="text-sm">Guided breathing exercises will appear here.</p>
        <p className="text-xs mt-2 text-muted-foreground/50">Phase 7 — Coming soon</p>
      </div>
    </div>
  );
}
ENDOFFILE

cat > 'src/app/(main)/oracle/page.tsx' << 'ENDOFFILE'
export default function OraclePage() {
  return (
    <div className="space-y-6">
      <header><p className="label-upper">Guidance</p><h1 className="font-serif text-3xl text-foreground/92">Oracle</h1></header>
      <div className="bg-card/60 border border-border/50 rounded-xl p-10 text-center text-muted-foreground">
        <p className="text-sm">Your astrological advisor will appear here.</p>
        <p className="text-xs mt-2 text-muted-foreground/50">Phase 7 — Coming soon</p>
      </div>
    </div>
  );
}
ENDOFFILE

cat > 'src/app/(main)/settings/page.tsx' << 'ENDOFFILE'
"use client";
import { useAuth } from "@/firebase/auth-provider";
import { useUserData } from "@/hooks/use-user-data";

export default function SettingsPage() {
  const { signOut } = useAuth();
  const { profile, birthData } = useUserData();
  return (
    <div className="space-y-6">
      <header><p className="label-upper">Configuration</p><h1 className="font-serif text-3xl text-foreground/92">Celestial Source</h1></header>
      <div className="bg-card/60 border border-border/50 rounded-xl p-6 space-y-4">
        <h2 className="text-sm font-semibold text-foreground/80">Profile</h2>
        <div className="space-y-2 text-sm">
          <div className="flex justify-between"><span className="text-muted-foreground">Name</span><span className="text-foreground/80">{profile?.displayName || "—"}</span></div>
          <div className="flex justify-between"><span className="text-muted-foreground">Email</span><span className="text-foreground/80">{profile?.email || "—"}</span></div>
        </div>
      </div>
      <div className="bg-card/60 border border-border/50 rounded-xl p-6 space-y-4">
        <h2 className="text-sm font-semibold text-foreground/80">Birth Data</h2>
        {birthData ? (
          <div className="space-y-2 text-sm">
            <div className="flex justify-between"><span className="text-muted-foreground">Date</span><span className="text-foreground/80">{birthData.date}</span></div>
            <div className="flex justify-between"><span className="text-muted-foreground">Time</span><span className="text-foreground/80">{birthData.time}</span></div>
            <div className="flex justify-between"><span className="text-muted-foreground">Location</span><span className="text-foreground/80">{birthData.location}</span></div>
          </div>
        ) : <p className="text-sm text-muted-foreground">No birth data recorded. Complete onboarding to set this up.</p>}
      </div>
      <button onClick={() => signOut()} className="w-full py-3 rounded-xl bg-destructive/10 border border-destructive/20 text-destructive text-sm font-medium hover:bg-destructive/15 transition-colors">Sign out</button>
    </div>
  );
}
ENDOFFILE

cat > 'src/app/(main)/onboarding/page.tsx' << 'ENDOFFILE'
"use client";
import { useState } from "react";
import { useRouter } from "next/navigation";
import { useAuth } from "@/firebase/auth-provider";
import { saveOnboardingData } from "@/services/firestore";

const STEPS = ["Welcome", "Birth Data", "Roles", "Rhythms", "Ready"];

export default function OnboardingPage() {
  const [step, setStep] = useState(0);
  const [birthDate, setBirthDate] = useState("");
  const [birthTime, setBirthTime] = useState("");
  const [birthLocation, setBirthLocation] = useState("");
  const [saving, setSaving] = useState(false);
  const { user } = useAuth();
  const router = useRouter();

  async function handleComplete() {
    if (!user) return;
    setSaving(true);
    try {
      await saveOnboardingData(user.uid, {
        birthData: { date: birthDate, time: birthTime, location: birthLocation, latitude: 0, longitude: 0, timezone: Intl.DateTimeFormat().resolvedOptions().timeZone },
        roles: [], focusWindows: [],
      });
      router.push("/dashboard");
    } catch (err) { console.error("Onboarding save failed:", err); }
    finally { setSaving(false); }
  }

  return (
    <div className="max-w-lg mx-auto space-y-8 py-12">
      <div className="flex gap-1.5">{STEPS.map((_, i) => <div key={i} className={`h-1 flex-1 rounded-full transition-colors ${i <= step ? "bg-cosmic" : "bg-muted/30"}`} />)}</div>

      {step === 0 && (
        <div className="text-center space-y-6">
          <div className="w-16 h-16 rounded-full mx-auto flex items-center justify-center text-2xl font-bold bg-gradient-to-br from-cosmic to-golden text-white/90">O</div>
          <h1 className="font-serif text-4xl text-foreground/92">Welcome to Octave</h1>
          <p className="text-muted-foreground max-w-sm mx-auto">We&apos;ll need a few details to calibrate your experience. This takes about 2 minutes.</p>
          <button onClick={() => setStep(1)} className="px-8 py-3 rounded-xl bg-cosmic hover:bg-cosmic/90 text-white font-medium text-sm transition-all">Let&apos;s begin</button>
        </div>
      )}

      {step === 1 && (
        <div className="space-y-6">
          <div><h2 className="font-serif text-2xl text-foreground/92">Your celestial signature</h2><p className="text-sm text-muted-foreground mt-1">This powers your natal chart and daily guidance.</p></div>
          <div className="space-y-4">
            <div className="space-y-2"><label className="label-upper block">Birth Date</label><input type="date" value={birthDate} onChange={(e) => setBirthDate(e.target.value)} className="w-full px-4 py-3 rounded-xl bg-card border border-border text-foreground focus:outline-none focus:ring-2 focus:ring-cosmic/30 text-sm" /></div>
            <div className="space-y-2"><label className="label-upper block">Birth Time</label><input type="time" value={birthTime} onChange={(e) => setBirthTime(e.target.value)} className="w-full px-4 py-3 rounded-xl bg-card border border-border text-foreground focus:outline-none focus:ring-2 focus:ring-cosmic/30 text-sm" /></div>
            <div className="space-y-2"><label className="label-upper block">Birth Location</label><input type="text" value={birthLocation} onChange={(e) => setBirthLocation(e.target.value)} placeholder="City, State or Country" className="w-full px-4 py-3 rounded-xl bg-card border border-border text-foreground placeholder:text-muted-foreground focus:outline-none focus:ring-2 focus:ring-cosmic/30 text-sm" /></div>
          </div>
          <div className="flex gap-3">
            <button onClick={() => setStep(0)} className="px-6 py-3 rounded-xl border border-border text-muted-foreground text-sm hover:bg-muted/10 transition-colors">Back</button>
            <button onClick={() => setStep(2)} disabled={!birthDate || !birthTime || !birthLocation} className="flex-1 py-3 rounded-xl bg-cosmic hover:bg-cosmic/90 text-white font-medium text-sm transition-all disabled:opacity-50 disabled:cursor-not-allowed">Continue</button>
          </div>
        </div>
      )}

      {(step === 2 || step === 3) && (
        <div className="space-y-6">
          <div><h2 className="font-serif text-2xl text-foreground/92">{step === 2 ? "Your roles" : "Your rhythms"}</h2><p className="text-sm text-muted-foreground mt-1">{step === 2 ? "We'll expand this in the next build phase." : "Focus windows and energy patterns — coming in Phase 2."}</p></div>
          <div className="bg-card/60 border border-border/50 rounded-xl p-8 text-center text-muted-foreground text-sm">This step will be fully built in Phase 2.</div>
          <div className="flex gap-3">
            <button onClick={() => setStep(step - 1)} className="px-6 py-3 rounded-xl border border-border text-muted-foreground text-sm hover:bg-muted/10 transition-colors">Back</button>
            <button onClick={() => setStep(step + 1)} className="flex-1 py-3 rounded-xl bg-cosmic hover:bg-cosmic/90 text-white font-medium text-sm transition-all">{step === 3 ? "Almost done" : "Continue"}</button>
          </div>
        </div>
      )}

      {step === 4 && (
        <div className="text-center space-y-6">
          <h1 className="font-serif text-4xl text-foreground/92">You&apos;re calibrated.</h1>
          <p className="text-muted-foreground max-w-sm mx-auto">Your celestial signature is set. Let&apos;s align your first day.</p>
          <button onClick={handleComplete} disabled={saving} className="px-8 py-3 rounded-xl bg-gradient-to-r from-cosmic to-golden text-white font-medium text-sm transition-all disabled:opacity-50 cosmic-glow">{saving ? "Setting up..." : "Enter Octave"}</button>
        </div>
      )}
    </div>
  );
}
ENDOFFILE

# ============================================
# README
# ============================================
cat > README.md << 'ENDOFFILE'
# Octave OS

Align your work with your energy.

## Quick Start

1. Copy `.env.example` to `.env.local` and fill in your Firebase config
2. `npm install`
3. `npm run dev`

See the full setup instructions in the docs.
ENDOFFILE

echo ""
echo "============================================"
echo "🎵 Octave OS Phase 1 — Setup Complete!"
echo "============================================"
echo ""
echo "Next steps:"
echo "  1. Copy .env.example to .env.local"
echo "  2. Fill in your Firebase config values"
echo "  3. npm install"
echo "  4. npm run dev"
echo ""

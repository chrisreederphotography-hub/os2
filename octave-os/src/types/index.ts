import type { Timestamp } from "firebase/firestore";

// ============================================
// User
// ============================================
export interface UserProfile {
  uid: string;
  email: string;
  displayName: string;
  photoURL: string | null;
  onboardingComplete: boolean;
  createdAt: Timestamp;
  updatedAt: Timestamp;
}

// ============================================
// Onboarding / Celestial Signature
// ============================================
export interface BirthData {
  date: string; // ISO date string: "1990-05-15"
  time: string; // 24h format: "14:30"
  location: string; // "San Francisco, CA"
  latitude: number;
  longitude: number;
  timezone: string; // IANA timezone: "America/Los_Angeles"
}

export interface UserRole {
  id: string;
  label: string; // e.g., "Designer", "Parent", "Founder"
  isPrimary: boolean;
}

export interface FocusWindow {
  id: string;
  label: string; // e.g., "Deep Work", "Creative Time"
  startHour: number; // 0-23
  endHour: number; // 0-23
  energyLevel: EnergyOctave;
  daysOfWeek: number[]; // 0=Sun, 1=Mon, ..., 6=Sat
}

// ============================================
// Energy
// ============================================
export type EnergyOctave = "high" | "medium" | "low" | "recovery";

export interface EnergyLog {
  id: string;
  date: string; // ISO date
  level: number; // 0-100
  octave: EnergyOctave;
  timestamp: Timestamp;
}

// ============================================
// Natal Chart & Astrology
// ============================================
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
  house: number; // 1-12
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
  date: string; // ISO date
  transits: Transit[];
  significantAspect: TransitAspect | null;
  solarPeak: number; // 0-100
  calculatedAt: Timestamp;
}

// ============================================
// Intentions / Tasks
// ============================================
export interface Intention {
  id: string;
  userId: string;
  title: string;
  description?: string;
  energyOctave: EnergyOctave;
  scheduledDate?: string; // ISO date
  scheduledTime?: string; // "14:00"
  durationMinutes?: number;
  completed: boolean;
  completedAt?: Timestamp;
  source: "manual" | "voice" | "brain-dump" | "ai-suggested";
  createdAt: Timestamp;
  updatedAt: Timestamp;
}

// ============================================
// Calendar Events (display-only, synced from external)
// ============================================
export interface CalendarEvent {
  id: string;
  title: string;
  startTime: string; // ISO datetime
  endTime: string; // ISO datetime
  energyOctave?: EnergyOctave;
  source: "manual" | "google" | "apple";
  aiSuggestion?: {
    suggestedTime: string;
    reason: string;
    dismissed: boolean;
  };
}

// ============================================
// AI Flow Types
// ============================================
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
  phases: {
    name: string;
    durationSeconds: number;
  }[];
}

// ============================================
// Sovereign Window (focus windows from onboarding)
// ============================================
export interface SovereignWindow {
  id: string;
  label: string;
  description?: string;
  startHour: number;
  endHour: number;
  energyOctave: EnergyOctave;
  daysOfWeek: number[];
}

import {
  doc,
  getDoc,
  setDoc,
  updateDoc,
  collection,
  query,
  where,
  orderBy,
  getDocs,
  deleteDoc,
  serverTimestamp,
  onSnapshot,
  type Unsubscribe,
} from "firebase/firestore";
import { db } from "@/firebase/config";
import type {
  UserProfile,
  NatalChart,
  Intention,
  EnergyLog,
  DailyTransitCache,
  SovereignWindow,
  BirthData,
  UserRole,
} from "@/types";

// ============================================
// Helper: Get user document reference
// ============================================
function userDoc(userId: string) {
  return doc(db, "users", userId);
}

function userSubcollection(userId: string, subcollection: string) {
  return collection(db, "users", userId, subcollection);
}

// ============================================
// User Profile
// ============================================
export async function getUserProfile(userId: string): Promise<UserProfile | null> {
  const snap = await getDoc(userDoc(userId));
  return snap.exists() ? (snap.data() as UserProfile) : null;
}

export async function updateUserProfile(
  userId: string,
  data: Partial<UserProfile>
) {
  await updateDoc(userDoc(userId), {
    ...data,
    updatedAt: serverTimestamp(),
  });
}

// Listen to user profile changes in real-time
export function onUserProfile(
  userId: string,
  callback: (profile: UserProfile | null) => void
): Unsubscribe {
  return onSnapshot(userDoc(userId), (snap) => {
    callback(snap.exists() ? (snap.data() as UserProfile) : null);
  });
}

// ============================================
// Onboarding Data
// ============================================
export async function saveOnboardingData(
  userId: string,
  data: {
    birthData?: BirthData;
    roles?: UserRole[];
    focusWindows?: SovereignWindow[];
  }
) {
  // Save birth data to user profile
  if (data.birthData) {
    await setDoc(
      doc(db, "users", userId, "celestial", "birthData"),
      { ...data.birthData, updatedAt: serverTimestamp() }
    );
  }

  // Save roles
  if (data.roles) {
    await setDoc(
      doc(db, "users", userId, "celestial", "roles"),
      { roles: data.roles, updatedAt: serverTimestamp() }
    );
  }

  // Save focus windows
  if (data.focusWindows) {
    await setDoc(
      doc(db, "users", userId, "celestial", "focusWindows"),
      { windows: data.focusWindows, updatedAt: serverTimestamp() }
    );
  }

  // Mark onboarding complete
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

// ============================================
// Natal Chart
// ============================================
export async function saveNatalChart(userId: string, chart: NatalChart) {
  await setDoc(doc(db, "users", userId, "celestial", "natalChart"), {
    ...chart,
    calculatedAt: serverTimestamp(),
  });
}

export async function getNatalChart(userId: string): Promise<NatalChart | null> {
  const snap = await getDoc(doc(db, "users", userId, "celestial", "natalChart"));
  return snap.exists() ? (snap.data() as NatalChart) : null;
}

// ============================================
// Transit Cache
// ============================================
export async function cacheDailyTransits(
  userId: string,
  data: Omit<DailyTransitCache, "calculatedAt">
) {
  await setDoc(doc(db, "users", userId, "cache", "dailyTransits"), {
    ...data,
    calculatedAt: serverTimestamp(),
  });
}

export async function getCachedTransits(
  userId: string
): Promise<DailyTransitCache | null> {
  const snap = await getDoc(doc(db, "users", userId, "cache", "dailyTransits"));
  if (!snap.exists()) return null;

  const data = snap.data() as DailyTransitCache;
  const today = new Date().toISOString().split("T")[0];

  // Return null if cache is stale (different day)
  if (data.date !== today) return null;

  return data;
}

// ============================================
// Intentions (Tasks)
// ============================================
export async function createIntention(
  userId: string,
  intention: Omit<Intention, "id" | "userId" | "createdAt" | "updatedAt">
): Promise<string> {
  const ref = doc(userSubcollection(userId, "intentions"));
  await setDoc(ref, {
    ...intention,
    id: ref.id,
    userId,
    createdAt: serverTimestamp(),
    updatedAt: serverTimestamp(),
  });
  return ref.id;
}

export async function updateIntention(
  userId: string,
  intentionId: string,
  data: Partial<Intention>
) {
  await updateDoc(doc(db, "users", userId, "intentions", intentionId), {
    ...data,
    updatedAt: serverTimestamp(),
  });
}

export async function deleteIntention(userId: string, intentionId: string) {
  await deleteDoc(doc(db, "users", userId, "intentions", intentionId));
}

export async function getIntentionsForDate(
  userId: string,
  date: string
): Promise<Intention[]> {
  const q = query(
    userSubcollection(userId, "intentions"),
    where("scheduledDate", "==", date),
    orderBy("scheduledTime", "asc")
  );
  const snap = await getDocs(q);
  return snap.docs.map((d) => d.data() as Intention);
}

export async function getIncompleteIntentions(
  userId: string
): Promise<Intention[]> {
  const q = query(
    userSubcollection(userId, "intentions"),
    where("completed", "==", false),
    orderBy("createdAt", "desc")
  );
  const snap = await getDocs(q);
  return snap.docs.map((d) => d.data() as Intention);
}

// Real-time listener for today's intentions
export function onTodayIntentions(
  userId: string,
  callback: (intentions: Intention[]) => void
): Unsubscribe {
  const today = new Date().toISOString().split("T")[0];
  const q = query(
    userSubcollection(userId, "intentions"),
    where("scheduledDate", "==", today),
    orderBy("scheduledTime", "asc")
  );
  return onSnapshot(q, (snap) => {
    callback(snap.docs.map((d) => d.data() as Intention));
  });
}

// ============================================
// Energy Logs
// ============================================
export async function logEnergy(
  userId: string,
  data: Omit<EnergyLog, "id" | "timestamp">
) {
  const ref = doc(userSubcollection(userId, "energyLogs"));
  await setDoc(ref, {
    ...data,
    id: ref.id,
    timestamp: serverTimestamp(),
  });
}

export async function getTodayEnergy(userId: string): Promise<EnergyLog | null> {
  const today = new Date().toISOString().split("T")[0];
  const q = query(
    userSubcollection(userId, "energyLogs"),
    where("date", "==", today),
    orderBy("timestamp", "desc")
  );
  const snap = await getDocs(q);
  return snap.docs.length > 0 ? (snap.docs[0].data() as EnergyLog) : null;
}

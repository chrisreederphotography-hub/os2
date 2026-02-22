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

// ============================================
// Types
// ============================================
interface AuthContextType {
  user: User | null;
  loading: boolean;
  signIn: (email: string, password: string) => Promise<void>;
  signUp: (email: string, password: string, displayName: string) => Promise<void>;
  signInWithGoogle: () => Promise<void>;
  signOut: () => Promise<void>;
}

// ============================================
// Context
// ============================================
const AuthContext = createContext<AuthContextType | undefined>(undefined);

// ============================================
// Provider
// ============================================
export function AuthProvider({ children }: { children: ReactNode }) {
  const [user, setUser] = useState<User | null>(null);
  const [loading, setLoading] = useState(true);

  // Listen to auth state changes
  useEffect(() => {
    const unsubscribe = onAuthStateChanged(auth, (firebaseUser) => {
      setUser(firebaseUser);
      setLoading(false);
    });
    return () => unsubscribe();
  }, []);

  // Create/update user document in Firestore on first sign in
  async function ensureUserDocument(firebaseUser: User) {
    const userRef = doc(db, "users", firebaseUser.uid);
    const userSnap = await getDoc(userRef);

    if (!userSnap.exists()) {
      // New user — create their document
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

  // Email/Password sign in
  async function signIn(email: string, password: string) {
    const result = await signInWithEmailAndPassword(auth, email, password);
    await ensureUserDocument(result.user);
  }

  // Email/Password sign up
  async function signUp(email: string, password: string, displayName: string) {
    const result = await createUserWithEmailAndPassword(auth, email, password);
    // Set display name on the Firebase user
    // Note: updateProfile is async but we don't need to await it for the doc
    await ensureUserDocument({
      ...result.user,
      displayName,
    } as User);
  }

  // Google sign in
  async function signInWithGoogle() {
    const provider = new GoogleAuthProvider();
    const result = await signInWithPopup(auth, provider);
    await ensureUserDocument(result.user);
  }

  // Sign out
  async function signOut() {
    await firebaseSignOut(auth);
  }

  const value: AuthContextType = {
    user,
    loading,
    signIn,
    signUp,
    signInWithGoogle,
    signOut,
  };

  return <AuthContext.Provider value={value}>{children}</AuthContext.Provider>;
}

// ============================================
// Hook
// ============================================
export function useAuth() {
  const context = useContext(AuthContext);
  if (context === undefined) {
    throw new Error("useAuth must be used within an AuthProvider");
  }
  return context;
}

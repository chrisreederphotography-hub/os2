"use client";

import { useEffect, useState } from "react";
import { useAuth } from "@/firebase/auth-provider";
import {
  onUserProfile,
  getBirthData,
  getUserRoles,
  getFocusWindows,
  getNatalChart,
} from "@/services/firestore";
import type {
  UserProfile,
  BirthData,
  UserRole,
  SovereignWindow,
  NatalChart,
} from "@/types";

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
      setProfile(null);
      setBirthData(null);
      setRoles([]);
      setFocusWindows([]);
      setNatalChart(null);
      setLoading(false);
      return;
    }

    // Real-time listener for profile
    const unsubProfile = onUserProfile(user.uid, (p) => {
      setProfile(p);
    });

    // Fetch other data (one-time reads, not real-time)
    async function fetchData() {
      try {
        const [bd, r, fw, nc] = await Promise.all([
          getBirthData(user!.uid),
          getUserRoles(user!.uid),
          getFocusWindows(user!.uid),
          getNatalChart(user!.uid),
        ]);
        setBirthData(bd);
        setRoles(r);
        setFocusWindows(fw);
        setNatalChart(nc);
      } catch (err) {
        setError(err instanceof Error ? err : new Error("Failed to fetch user data"));
      } finally {
        setLoading(false);
      }
    }

    fetchData();

    return () => unsubProfile();
  }, [user]);

  return { profile, birthData, roles, focusWindows, natalChart, loading, error };
}

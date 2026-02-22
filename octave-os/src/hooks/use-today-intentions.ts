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
    if (!user) {
      setIntentions([]);
      setLoading(false);
      return;
    }

    const unsubscribe = onTodayIntentions(user.uid, (data) => {
      setIntentions(data);
      setLoading(false);
    });

    return () => unsubscribe();
  }, [user]);

  return { intentions, loading };
}

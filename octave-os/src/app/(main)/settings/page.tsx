"use client";

import { useAuth } from "@/firebase/auth-provider";
import { useUserData } from "@/hooks/use-user-data";

export default function SettingsPage() {
  const { signOut } = useAuth();
  const { profile, birthData } = useUserData();

  return (
    <div className="space-y-6">
      <header>
        <p className="label-upper">Configuration</p>
        <h1 className="font-serif text-3xl text-foreground/92">Celestial Source</h1>
      </header>

      {/* Profile Section */}
      <div className="bg-card/60 border border-border/50 rounded-xl p-6 space-y-4">
        <h2 className="text-sm font-semibold text-foreground/80">Profile</h2>
        <div className="space-y-2 text-sm">
          <div className="flex justify-between">
            <span className="text-muted-foreground">Name</span>
            <span className="text-foreground/80">{profile?.displayName || "—"}</span>
          </div>
          <div className="flex justify-between">
            <span className="text-muted-foreground">Email</span>
            <span className="text-foreground/80">{profile?.email || "—"}</span>
          </div>
        </div>
      </div>

      {/* Birth Data Section */}
      <div className="bg-card/60 border border-border/50 rounded-xl p-6 space-y-4">
        <h2 className="text-sm font-semibold text-foreground/80">Birth Data</h2>
        {birthData ? (
          <div className="space-y-2 text-sm">
            <div className="flex justify-between">
              <span className="text-muted-foreground">Date</span>
              <span className="text-foreground/80">{birthData.date}</span>
            </div>
            <div className="flex justify-between">
              <span className="text-muted-foreground">Time</span>
              <span className="text-foreground/80">{birthData.time}</span>
            </div>
            <div className="flex justify-between">
              <span className="text-muted-foreground">Location</span>
              <span className="text-foreground/80">{birthData.location}</span>
            </div>
          </div>
        ) : (
          <p className="text-sm text-muted-foreground">No birth data recorded. Complete onboarding to set this up.</p>
        )}
      </div>

      {/* Sign Out */}
      <button
        onClick={() => signOut()}
        className="w-full py-3 rounded-xl bg-destructive/10 border border-destructive/20 text-destructive text-sm font-medium hover:bg-destructive/15 transition-colors"
      >
        Sign out
      </button>
    </div>
  );
}

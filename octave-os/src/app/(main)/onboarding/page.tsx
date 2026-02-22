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
        birthData: {
          date: birthDate,
          time: birthTime,
          location: birthLocation,
          latitude: 0, // Will be geocoded in Phase 2
          longitude: 0,
          timezone: Intl.DateTimeFormat().resolvedOptions().timeZone,
        },
        roles: [],
        focusWindows: [],
      });
      router.push("/dashboard");
    } catch (err) {
      console.error("Onboarding save failed:", err);
    } finally {
      setSaving(false);
    }
  }

  return (
    <div className="max-w-lg mx-auto space-y-8 py-12">
      {/* Progress */}
      <div className="flex gap-1.5">
        {STEPS.map((_, i) => (
          <div
            key={i}
            className={`h-1 flex-1 rounded-full transition-colors ${
              i <= step ? "bg-cosmic" : "bg-muted/30"
            }`}
          />
        ))}
      </div>

      {/* Step 0: Welcome */}
      {step === 0 && (
        <div className="text-center space-y-6">
          <div className="w-16 h-16 rounded-full mx-auto flex items-center justify-center text-2xl font-bold bg-gradient-to-br from-cosmic to-golden text-white/90">
            O
          </div>
          <h1 className="font-serif text-4xl text-foreground/92">
            Welcome to Octave
          </h1>
          <p className="text-muted-foreground max-w-sm mx-auto">
            We'll need a few details to calibrate your experience. 
            This takes about 2 minutes.
          </p>
          <button
            onClick={() => setStep(1)}
            className="px-8 py-3 rounded-xl bg-cosmic hover:bg-cosmic/90 text-white font-medium text-sm transition-all"
          >
            Let's begin
          </button>
        </div>
      )}

      {/* Step 1: Birth Data */}
      {step === 1 && (
        <div className="space-y-6">
          <div>
            <h2 className="font-serif text-2xl text-foreground/92">
              Your celestial signature
            </h2>
            <p className="text-sm text-muted-foreground mt-1">
              This powers your natal chart and daily guidance.
            </p>
          </div>

          <div className="space-y-4">
            <div className="space-y-2">
              <label className="label-upper block">Birth Date</label>
              <input
                type="date"
                value={birthDate}
                onChange={(e) => setBirthDate(e.target.value)}
                className="w-full px-4 py-3 rounded-xl bg-card border border-border text-foreground focus:outline-none focus:ring-2 focus:ring-cosmic/30 text-sm"
              />
            </div>
            <div className="space-y-2">
              <label className="label-upper block">Birth Time</label>
              <input
                type="time"
                value={birthTime}
                onChange={(e) => setBirthTime(e.target.value)}
                className="w-full px-4 py-3 rounded-xl bg-card border border-border text-foreground focus:outline-none focus:ring-2 focus:ring-cosmic/30 text-sm"
              />
            </div>
            <div className="space-y-2">
              <label className="label-upper block">Birth Location</label>
              <input
                type="text"
                value={birthLocation}
                onChange={(e) => setBirthLocation(e.target.value)}
                placeholder="City, State or Country"
                className="w-full px-4 py-3 rounded-xl bg-card border border-border text-foreground placeholder:text-muted-foreground focus:outline-none focus:ring-2 focus:ring-cosmic/30 text-sm"
              />
            </div>
          </div>

          <div className="flex gap-3">
            <button
              onClick={() => setStep(0)}
              className="px-6 py-3 rounded-xl border border-border text-muted-foreground text-sm hover:bg-muted/10 transition-colors"
            >
              Back
            </button>
            <button
              onClick={() => setStep(2)}
              disabled={!birthDate || !birthTime || !birthLocation}
              className="flex-1 py-3 rounded-xl bg-cosmic hover:bg-cosmic/90 text-white font-medium text-sm transition-all disabled:opacity-50 disabled:cursor-not-allowed"
            >
              Continue
            </button>
          </div>
        </div>
      )}

      {/* Step 2-3: Simplified for now */}
      {(step === 2 || step === 3) && (
        <div className="space-y-6">
          <div>
            <h2 className="font-serif text-2xl text-foreground/92">
              {step === 2 ? "Your roles" : "Your rhythms"}
            </h2>
            <p className="text-sm text-muted-foreground mt-1">
              {step === 2
                ? "We'll expand this in the next build phase."
                : "Focus windows and energy patterns — coming in Phase 2."}
            </p>
          </div>

          <div className="bg-card/60 border border-border/50 rounded-xl p-8 text-center text-muted-foreground text-sm">
            This step will be fully built in Phase 2.
          </div>

          <div className="flex gap-3">
            <button
              onClick={() => setStep(step - 1)}
              className="px-6 py-3 rounded-xl border border-border text-muted-foreground text-sm hover:bg-muted/10 transition-colors"
            >
              Back
            </button>
            <button
              onClick={() => setStep(step + 1)}
              className="flex-1 py-3 rounded-xl bg-cosmic hover:bg-cosmic/90 text-white font-medium text-sm transition-all"
            >
              {step === 3 ? "Almost done" : "Continue"}
            </button>
          </div>
        </div>
      )}

      {/* Step 4: Ready */}
      {step === 4 && (
        <div className="text-center space-y-6">
          <h1 className="font-serif text-4xl text-foreground/92">
            You're calibrated.
          </h1>
          <p className="text-muted-foreground max-w-sm mx-auto">
            Your celestial signature is set. Let's align your first day.
          </p>
          <button
            onClick={handleComplete}
            disabled={saving}
            className="px-8 py-3 rounded-xl bg-gradient-to-r from-cosmic to-golden text-white font-medium text-sm transition-all disabled:opacity-50 cosmic-glow"
          >
            {saving ? "Setting up..." : "Enter Octave"}
          </button>
        </div>
      )}
    </div>
  );
}

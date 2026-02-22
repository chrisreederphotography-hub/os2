"use client";

import { useState, useEffect } from "react";
import { useRouter } from "next/navigation";
import { useAuth } from "@/firebase/auth-provider";
import { useUserData } from "@/hooks/use-user-data";
import { useTodayIntentions } from "@/hooks/use-today-intentions";
import type { EnergyOctave } from "@/types";

// ============================================
// Energy helpers
// ============================================
const ENERGY_CONFIG: Record<
  EnergyOctave,
  { label: string; className: string }
> = {
  high: { label: "High Focus", className: "energy-high" },
  medium: { label: "Steady", className: "energy-medium" },
  low: { label: "Light", className: "energy-low" },
  recovery: { label: "Recovery", className: "energy-recovery" },
};

function energyFromLevel(level: number): EnergyOctave {
  if (level >= 75) return "high";
  if (level >= 50) return "medium";
  if (level >= 25) return "low";
  return "recovery";
}

const ENERGY_LABELS = ["Depleted", "Low", "Steady", "Energized", "Peak"];

// ============================================
// Dashboard Page
// ============================================
export default function DashboardPage() {
  const router = useRouter();
  const { user } = useAuth();
  const { profile, loading: profileLoading } = useUserData();
  const { intentions, loading: intentionsLoading } = useTodayIntentions();
  const [energy, setEnergy] = useState(65);
  const [directiveVisible, setDirectiveVisible] = useState(false);

  // Redirect to onboarding if not completed
  useEffect(() => {
    if (!profileLoading && profile && !profile.onboardingComplete) {
      router.replace("/onboarding");
    }
  }, [profile, profileLoading, router]);

  // Animate directive in
  useEffect(() => {
    const timer = setTimeout(() => setDirectiveVisible(true), 300);
    return () => clearTimeout(timer);
  }, []);

  const now = new Date();
  const greeting =
    now.getHours() < 12
      ? "Good morning"
      : now.getHours() < 17
        ? "Good afternoon"
        : "Good evening";
  const dateStr = now.toLocaleDateString("en-US", {
    weekday: "long",
    month: "long",
    day: "numeric",
  });
  const displayName =
    profile?.displayName || user?.displayName || "Architect";
  const energyLabel =
    ENERGY_LABELS[Math.min(Math.floor(energy / 25), 4)];

  if (profileLoading) {
    return (
      <div className="flex items-center justify-center min-h-[60vh]">
        <div className="w-8 h-8 rounded-full border-2 border-cosmic/30 border-t-cosmic animate-spin" />
      </div>
    );
  }

  return (
    <div className="space-y-6">
      {/* Header */}
      <header className="space-y-1">
        <p className="label-upper">{dateStr}</p>
        <h1 className="font-serif text-3xl md:text-4xl text-foreground/92 leading-tight">
          {greeting}, {displayName}.
        </h1>
      </header>

      {/* Grid */}
      <div className="grid grid-cols-1 lg:grid-cols-[1fr_320px] gap-5 items-start">
        {/* Left column */}
        <div className="space-y-5">
          {/* Daily Directive */}
          <div
            className="cosmic-gradient rounded-2xl p-7 relative overflow-hidden transition-all duration-700 ease-out"
            style={{
              opacity: directiveVisible ? 1 : 0,
              transform: directiveVisible
                ? "translateY(0)"
                : "translateY(12px)",
            }}
          >
            {/* Ambient glow inside card */}
            <div className="absolute inset-0 bg-[radial-gradient(ellipse_at_20%_20%,hsl(251_39%_42%/0.08),transparent_60%)] pointer-events-none" />

            <div className="relative space-y-4">
              <div className="flex items-center gap-2">
                <span className="label-upper text-cosmic-glow/60">
                  Daily Directive
                </span>
                <span className="text-[10px] text-golden/60 bg-golden/8 border border-golden/15 px-2 py-0.5 rounded-full">
                  Mercury ☌ Saturn
                </span>
              </div>

              <h2 className="font-serif text-2xl md:text-[28px] text-foreground/95 leading-snug">
                Lead with precision today.
              </h2>

              <p className="text-sm text-muted-foreground leading-relaxed max-w-xl">
                Mercury trines your natal Saturn — your communication is
                unusually sharp. Use the morning for decisions you&apos;ve been
                postponing. After 2pm, shift to creative work as Venus enters
                your 5th house.
              </p>
            </div>
          </div>

          {/* Energy Calibration */}
          <div className="bg-card/60 border border-border/50 rounded-xl p-5">
            <div className="flex justify-between items-center mb-3">
              <span className="label-upper">Energy</span>
              <span
                className={`text-xs font-semibold ${
                  energy >= 75
                    ? "text-energy-high"
                    : energy >= 50
                      ? "text-energy-medium"
                      : energy >= 25
                        ? "text-energy-low"
                        : "text-muted-foreground"
                }`}
              >
                {energyLabel}
              </span>
            </div>
            <input
              type="range"
              min={0}
              max={100}
              value={energy}
              onChange={(e) => setEnergy(Number(e.target.value))}
              className="w-full h-1 rounded-full appearance-none cursor-pointer [&::-webkit-slider-thumb]:appearance-none [&::-webkit-slider-thumb]:w-4 [&::-webkit-slider-thumb]:h-4 [&::-webkit-slider-thumb]:rounded-full [&::-webkit-slider-thumb]:bg-white [&::-webkit-slider-thumb]:shadow-md [&::-webkit-slider-thumb]:cursor-pointer"
              style={{
                background: `linear-gradient(to right, hsl(200 60% 50% / 0.6), hsl(251 39% 55% / 0.6), hsl(38 90% 55% / 0.8))`,
              }}
            />
          </div>

          {/* Transits */}
          <div className="bg-card/60 border border-border/50 rounded-xl p-5">
            <span className="label-upper block mb-3">Current Transits</span>
            <div className="flex gap-2 overflow-x-auto pb-1">
              {[
                { symbol: "☉", planet: "Sun", sign: "Pisces", degree: "3°42'" },
                { symbol: "☽", planet: "Moon", sign: "Leo", degree: "17°15'" },
                { symbol: "☿", planet: "Mercury", sign: "Aquarius", degree: "22°08'" },
                { symbol: "♀", planet: "Venus", sign: "Aries", degree: "1°30'" },
                { symbol: "♂", planet: "Mars", sign: "Cancer", degree: "14°52'" },
              ].map((t) => (
                <div
                  key={t.planet}
                  className="flex flex-col items-center gap-1 p-2.5 rounded-xl bg-muted/20 border border-border/30 min-w-[68px]"
                >
                  <span className="text-lg text-cosmic-glow/70">
                    {t.symbol}
                  </span>
                  <span className="text-[11px] font-semibold text-foreground/70">
                    {t.sign}
                  </span>
                  <span className="text-[10px] text-muted-foreground">
                    {t.degree}
                  </span>
                </div>
              ))}
            </div>
          </div>
        </div>

        {/* Right column — Today's Schedule */}
        <div className="bg-card/60 border border-border/50 rounded-xl p-5">
          <div className="flex justify-between items-center mb-3">
            <span className="label-upper">Today&apos;s Flow</span>
            <button className="text-[11px] text-cosmic-glow/50 hover:text-cosmic-glow/80 transition-colors">
              View all →
            </button>
          </div>

          <div className="space-y-0.5">
            {/* Show intentions if available, otherwise show placeholder */}
            {intentions.length > 0
              ? intentions.map((intention, i) => (
                  <ScheduleRow
                    key={intention.id}
                    title={intention.title}
                    time={intention.scheduledTime || ""}
                    duration={intention.durationMinutes || 30}
                    energy={intention.energyOctave}
                  />
                ))
              : /* Placeholder schedule for demo */
                [
                  { title: "Morning Focus Block", time: "8:00 AM", duration: 90, energy: "high" as EnergyOctave },
                  { title: "Team Standup", time: "9:30 AM", duration: 30, energy: "medium" as EnergyOctave },
                  { title: "Contract Review", time: "10:30 AM", duration: 60, energy: "high" as EnergyOctave },
                  { title: "Lunch & Reset", time: "12:00 PM", duration: 60, energy: "recovery" as EnergyOctave },
                  { title: "Creative Exploration", time: "1:00 PM", duration: 120, energy: "medium" as EnergyOctave },
                  { title: "Email & Admin", time: "3:00 PM", duration: 45, energy: "low" as EnergyOctave },
                ].map((item, i) => (
                  <ScheduleRow key={i} {...item} />
                ))}
          </div>

          {/* Quick add */}
          <button className="w-full mt-3 py-2.5 px-4 rounded-xl border border-dashed border-border/40 text-muted-foreground text-sm hover:bg-muted/10 hover:border-border/60 transition-all flex items-center gap-2">
            <span className="text-base font-light">+</span>
            Add to today
          </button>
        </div>
      </div>

      {/* Solar Peak Bar */}
      <div className="bg-card/60 border border-border/50 rounded-xl p-4 flex items-center gap-4">
        <span className="label-upper whitespace-nowrap">Solar Peak</span>
        <div className="flex-1 h-1 bg-muted/20 rounded-full relative overflow-visible">
          <div
            className="absolute left-0 top-0 h-full rounded-full"
            style={{
              width: "62%",
              background:
                "linear-gradient(90deg, hsl(38 90% 55% / 0.3), hsl(38 90% 55% / 0.7))",
            }}
          />
          <div
            className="absolute top-1/2 -translate-y-1/2 w-3 h-3 rounded-full bg-golden shadow-[0_0_10px_hsl(38_90%_55%/0.4)]"
            style={{ left: "62%", transform: "translate(-50%, -50%)" }}
          />
        </div>
        <span className="text-sm font-semibold text-golden/80 tabular-nums">
          62%
        </span>
      </div>
    </div>
  );
}

// ============================================
// Schedule Row Component
// ============================================
function ScheduleRow({
  title,
  time,
  duration,
  energy,
}: {
  title: string;
  time: string;
  duration: number;
  energy: EnergyOctave;
}) {
  const config = ENERGY_CONFIG[energy];

  return (
    <div className="flex items-center gap-3 px-3 py-2.5 rounded-xl hover:bg-muted/5 transition-colors cursor-pointer group">
      <div
        className="w-0.5 h-9 rounded-full flex-shrink-0"
        style={{
          backgroundColor: `hsl(var(--energy-${energy}) / 0.4)`,
        }}
      />
      <div className="flex-1 min-w-0">
        <div className="text-sm font-medium text-foreground/88 truncate group-hover:text-foreground transition-colors">
          {title}
        </div>
        <div className="text-xs text-muted-foreground">
          {time} · {duration}m
        </div>
      </div>
      <span
        className={`text-[10px] font-medium px-2 py-0.5 rounded-full border flex-shrink-0 ${config.className}`}
      >
        {config.label}
      </span>
    </div>
  );
}

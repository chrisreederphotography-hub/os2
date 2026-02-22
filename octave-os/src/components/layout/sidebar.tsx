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
      {/* Desktop sidebar */}
      <nav className="hidden md:flex fixed left-0 top-0 bottom-0 w-16 bg-background/60 backdrop-blur-xl border-r border-border/50 flex-col items-center pt-6 gap-1.5 z-50">
        {/* Logo */}
        <Link
          href="/dashboard"
          className="w-9 h-9 rounded-full bg-gradient-to-br from-cosmic to-golden flex items-center justify-center text-sm font-bold text-white/90 mb-5 hover:scale-105 transition-transform"
        >
          O
        </Link>

        {NAV_ITEMS.map((item) => {
          const isActive = pathname === item.href;
          return (
            <Link
              key={item.href}
              href={item.href}
              title={item.label}
              className={cn(
                "w-10 h-10 rounded-xl flex items-center justify-center text-base transition-all duration-200",
                isActive
                  ? "bg-cosmic/15 text-cosmic-glow"
                  : "text-muted-foreground hover:text-foreground hover:bg-muted/30"
              )}
            >
              {item.icon}
            </Link>
          );
        })}
      </nav>

      {/* Mobile bottom bar */}
      <nav className="md:hidden fixed bottom-0 left-0 right-0 h-16 bg-background/80 backdrop-blur-xl border-t border-border/50 flex items-center justify-around px-2 z-50">
        {NAV_ITEMS.slice(0, 5).map((item) => {
          const isActive = pathname === item.href;
          return (
            <Link
              key={item.href}
              href={item.href}
              className={cn(
                "flex flex-col items-center gap-1 py-1 px-3 rounded-lg transition-all",
                isActive ? "text-cosmic-glow" : "text-muted-foreground"
              )}
            >
              <span className="text-lg">{item.icon}</span>
              <span className="text-[10px] font-medium">{item.label}</span>
            </Link>
          );
        })}
      </nav>
    </>
  );
}

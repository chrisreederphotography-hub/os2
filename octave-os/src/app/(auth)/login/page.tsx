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
    e.preventDefault();
    setError("");
    setLoading(true);

    try {
      await signIn(email, password);
      router.push("/dashboard");
    } catch (err: any) {
      setError(
        err.code === "auth/invalid-credential"
          ? "Invalid email or password."
          : "Something went wrong. Please try again."
      );
    } finally {
      setLoading(false);
    }
  }

  async function handleGoogle() {
    setError("");
    try {
      await signInWithGoogle();
      router.push("/dashboard");
    } catch (err: any) {
      setError("Google sign-in failed. Please try again.");
    }
  }

  return (
    <div className="space-y-8">
      {/* Header */}
      <div className="text-center space-y-2">
        <div className="w-12 h-12 rounded-full mx-auto mb-4 flex items-center justify-center text-lg font-bold bg-gradient-to-br from-[hsl(251,39%,42%)] to-[hsl(38,90%,55%)] text-white/90">
          O
        </div>
        <h1 className="font-serif text-3xl text-foreground">Welcome back</h1>
        <p className="text-muted-foreground text-sm">
          Sign in to continue your practice.
        </p>
      </div>

      {/* Error */}
      {error && (
        <div className="p-3 rounded-lg bg-destructive/10 border border-destructive/20 text-destructive text-sm text-center">
          {error}
        </div>
      )}

      {/* Form */}
      <form onSubmit={handleSubmit} className="space-y-4">
        <div className="space-y-2">
          <label htmlFor="email" className="label-upper block">
            Email
          </label>
          <input
            id="email"
            type="email"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            required
            className="w-full px-4 py-3 rounded-xl bg-card border border-border text-foreground placeholder:text-muted-foreground focus:outline-none focus:ring-2 focus:ring-cosmic/30 focus:border-cosmic/50 transition-all text-sm"
            placeholder="you@example.com"
          />
        </div>

        <div className="space-y-2">
          <label htmlFor="password" className="label-upper block">
            Password
          </label>
          <input
            id="password"
            type="password"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            required
            className="w-full px-4 py-3 rounded-xl bg-card border border-border text-foreground placeholder:text-muted-foreground focus:outline-none focus:ring-2 focus:ring-cosmic/30 focus:border-cosmic/50 transition-all text-sm"
            placeholder="••••••••"
          />
        </div>

        <button
          type="submit"
          disabled={loading}
          className="w-full py-3 rounded-xl bg-[hsl(251,39%,42%)] hover:bg-[hsl(251,39%,48%)] text-white font-medium text-sm transition-all disabled:opacity-50 disabled:cursor-not-allowed"
        >
          {loading ? "Signing in..." : "Sign in"}
        </button>
      </form>

      {/* Divider */}
      <div className="relative">
        <div className="absolute inset-0 flex items-center">
          <div className="w-full border-t border-border" />
        </div>
        <div className="relative flex justify-center text-xs">
          <span className="px-3 bg-background text-muted-foreground">or</span>
        </div>
      </div>

      {/* Google */}
      <button
        onClick={handleGoogle}
        className="w-full py-3 rounded-xl bg-card hover:bg-muted border border-border text-foreground font-medium text-sm transition-all flex items-center justify-center gap-3"
      >
        <svg className="w-4 h-4" viewBox="0 0 24 24">
          <path
            d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92a5.06 5.06 0 01-2.2 3.32v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.1z"
            fill="#4285F4"
          />
          <path
            d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z"
            fill="#34A853"
          />
          <path
            d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z"
            fill="#FBBC05"
          />
          <path
            d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z"
            fill="#EA4335"
          />
        </svg>
        Continue with Google
      </button>

      {/* Sign up link */}
      <p className="text-center text-sm text-muted-foreground">
        New to Octave?{" "}
        <Link
          href="/signup"
          className="text-[hsl(251,60%,65%)] hover:text-[hsl(251,60%,75%)] transition-colors"
        >
          Create an account
        </Link>
      </p>
    </div>
  );
}

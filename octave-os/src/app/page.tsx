import { redirect } from "next/navigation";

export default function Home() {
  // In production, you'd check auth server-side here.
  // For now, redirect to dashboard (which handles its own auth check).
  redirect("/dashboard");
}

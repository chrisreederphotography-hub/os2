import type { Metadata } from "next";
import { Instrument_Serif, DM_Sans } from "next/font/google";
import { AuthProvider } from "@/firebase/auth-provider";
import "./globals.css";

const serif = Instrument_Serif({
  subsets: ["latin"],
  weight: "400",
  variable: "--font-serif",
  display: "swap",
});

const sans = DM_Sans({
  subsets: ["latin"],
  weight: ["300", "400", "500", "600", "700"],
  variable: "--font-sans",
  display: "swap",
});

export const metadata: Metadata = {
  title: "Octave OS",
  description: "Align your work with your energy.",
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en" className="dark">
      <body
        className={`${serif.variable} ${sans.variable} font-sans`}
      >
        <AuthProvider>{children}</AuthProvider>
      </body>
    </html>
  );
}

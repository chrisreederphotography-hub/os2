export default function AuthLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <div className="min-h-screen flex items-center justify-center bg-background">
      {/* Ambient background */}
      <div className="fixed inset-0 pointer-events-none">
        <div className="absolute top-[-20%] right-[-10%] w-[500px] h-[500px] rounded-full bg-[radial-gradient(circle,hsl(251_39%_42%/0.06),transparent_70%)]" />
        <div className="absolute bottom-[-20%] left-[-10%] w-[400px] h-[400px] rounded-full bg-[radial-gradient(circle,hsl(38_90%_55%/0.03),transparent_70%)]" />
      </div>
      <div className="relative z-10 w-full max-w-md px-6">{children}</div>
    </div>
  );
}

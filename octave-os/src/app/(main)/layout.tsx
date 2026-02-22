import { Sidebar } from "@/components/layout/sidebar";
import { AuthGuard } from "@/components/layout/auth-guard";

export default function MainLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <AuthGuard>
      <div className="min-h-screen bg-background">
        {/* Ambient background gradients */}
        <div className="fixed inset-0 pointer-events-none overflow-hidden">
          <div className="absolute top-[-200px] right-[-200px] w-[600px] h-[600px] rounded-full bg-[radial-gradient(circle,hsl(251_39%_42%/0.06),transparent_70%)]" />
          <div className="absolute bottom-[-300px] left-[-100px] w-[500px] h-[500px] rounded-full bg-[radial-gradient(circle,hsl(38_90%_55%/0.03),transparent_70%)]" />
        </div>

        <Sidebar />

        {/* Page content */}
        <main className="relative md:ml-16 min-h-screen pb-20 md:pb-0">
          <div className="max-w-4xl mx-auto px-5 md:px-10 py-8">
            {children}
          </div>
        </main>
      </div>
    </AuthGuard>
  );
}

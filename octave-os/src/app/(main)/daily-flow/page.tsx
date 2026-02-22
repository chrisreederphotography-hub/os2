export default function DailyFlowPage() {
  return (
    <div className="space-y-6">
      <header>
        <p className="label-upper">Timeline</p>
        <h1 className="font-serif text-3xl text-foreground/92">Daily Flow</h1>
      </header>
      <div className="bg-card/60 border border-border/50 rounded-xl p-10 text-center text-muted-foreground">
        <p className="text-sm">Your daily timeline will appear here.</p>
        <p className="text-xs mt-2 text-muted-foreground/50">Phase 5 — Coming soon</p>
      </div>
    </div>
  );
}

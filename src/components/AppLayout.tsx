"use client";

import { AuthGate } from "./AuthGate";
import { Sidebar } from "./Sidebar";
import { Topbar } from "./Topbar";
import { WorkspaceTheme } from "./WorkspaceTheme";

export function AppLayout({ children }: { children: React.ReactNode }) {
  return (
    <AuthGate>
      <WorkspaceTheme>
        <div aria-hidden="true" className="ambient-grid" />
        <Sidebar />
        <div className="relative z-10 lg:pl-[17rem]">
          <Topbar />
          <main className="mx-auto max-w-[1500px] px-3 py-3 sm:px-4 lg:px-5 lg:py-5 xl:px-6">
            {children}
          </main>
        </div>
      </WorkspaceTheme>
    </AuthGate>
  );
}

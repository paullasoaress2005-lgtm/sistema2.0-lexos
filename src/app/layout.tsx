import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "LEX.OS Control 2.0",
  description: "Sistema jurídico-operacional LEX.OS Control 2.0.",
  icons: {
    icon: "/lexos-favicon.png",
    apple: "/lexos-favicon.png",
  },
};

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="pt-BR">
      <body>{children}</body>
    </html>
  );
}

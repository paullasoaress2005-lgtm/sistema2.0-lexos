/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  async redirects() {
    return [
      { source: "/implantacao", destination: "/configuracoes/release", permanent: false },
      { source: "/central", destination: "/central-lexos", permanent: false },
      { source: "/central/:path*", destination: "/central-lexos/:path*", permanent: false },
      { source: "/painel-socios", destination: "/socios", permanent: false },
      { source: "/painel-dos-socios", destination: "/socios", permanent: false },
      { source: "/primeiros-passos", destination: "/onboarding", permanent: false },
    ];
  },
};

export default nextConfig;

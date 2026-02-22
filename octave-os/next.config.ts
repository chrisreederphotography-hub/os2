import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  // Enable WASM for Swiss Ephemeris later
  webpack: (config) => {
    config.experiments = {
      ...config.experiments,
      asyncWebAssembly: true,
    };
    return config;
  },
};

export default nextConfig;

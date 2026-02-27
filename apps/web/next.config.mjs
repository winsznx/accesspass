/** @type {import('next').NextConfig} */
const nextConfig = {
    reactStrictMode: true,
    transpilePackages: ['@accesspass/shared', '@accesspass/base-adapter', '@accesspass/stacks-adapter'],
};

export default nextConfig;

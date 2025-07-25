// https://nuxt.com/docs/api/configuration/nuxt-config
import tailwindcss from "@tailwindcss/vite";

export default defineNuxtConfig({
  compatibilityDate: "2025-05-15",
  devtools: { enabled: true },
  future: {
    compatibilityVersion: 4,
  },
  devServer: {
    port: 3001,
  },
  css: ["~/assets/css/global.css"],
  vite: {
    plugins: [tailwindcss()],
  },
  typescript: {
    typeCheck: true,
  },
  modules: ["nuxt-svgo", "@nuxt/icon"],
  svgo: {
    dts: true,
  },
  runtimeConfig: {
    cmsApi: process.env.CMS_API || "http://localhost:3000/api",
  },
  icon: {
    customCollections: [
      {
        prefix: "custom",
        dir: "./app/assets/icons",
      },
    ],
  },
  routeRules: {
    "/": {
      prerender: true,
    },
  },
  app: {
    head: {
      htmlAttrs: {
        lang: "en",
      },
    },
  },
  nitro: {
    compressPublicAssets: true,
    minify: true,
  },
});

// https://nuxt.com/docs/api/configuration/nuxt-config
import tailwindcss from "@tailwindcss/vite";

export default defineNuxtConfig({
  compatibilityDate: '2025-05-15',
  devtools: {enabled: true},
  future: {
    compatibilityVersion: 4,
  },
  devServer: {
    port: 3001,
  },
  css: [
    '~/assets/css/global.css',
  ],
  vite: {
    plugins: [
      tailwindcss()
    ]
  }
})

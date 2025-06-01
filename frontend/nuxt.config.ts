// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  compatibilityDate: '2025-05-15',
  devtools: {enabled: true},
  future: {
    compatibilityVersion: 4,
  },
  devServer: {
    port: 3001,
  },
  vue: {
    compilerOptions: {
      // isCustomElement: (tag) => tag.includes('-l') || tag === 'stack-l'
      isCustomElement: (tag) => tag.includes('-l')
    }
  },
  css: [
    '~/assets/css/global.css',
  ],
  postcss: {
    plugins: {
      'tailwindcss/nesting': 'postcss-nesting',
      'tailwindcss': {}
    },
  },
})

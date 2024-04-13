// vite.config.ts
import {defineConfig} from 'vite'
import ViteRails from "vite-plugin-rails"
import WindiCSS from 'vite-plugin-windicss'

export default defineConfig({
    clearScreen: false,
    plugins: [
      WindiCSS({
      root: import.meta.dirname,
      scan: {
        fileExtensions: ['erb', 'haml', 'html', 'vue', 'js', 'ts', 'jsx', 'tsx'],
        dirs: ['app/views', 'app/javascript'], // or app/javascript, or app/packs
      }}),
      ViteRails({
        fullReload: {
          additionalPaths: ["config/routes.rb", "app/views/**/*"],
          delay: 300
        }
      }),
    ],
  }
)

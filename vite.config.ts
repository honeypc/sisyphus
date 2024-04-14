// vite.config.ts
import {defineConfig} from 'vite'
import react from '@vitejs/plugin-react'
import ViteRails from "vite-plugin-rails"
import WindiCSS from 'vite-plugin-windicss'
import path from 'path'

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
    resolve: {
      alias: {
        '@': path.resolve(__dirname, './app/javascript'),
      }
    }
  }
)

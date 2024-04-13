/** @type {import('tailwindcss').Config} */
const colors = require('tailwindcss/colors')
const defaultTheme = require('tailwindcss/defaultTheme')
const withMT = require("@material-tailwind/react/utils/withMT");

module.exports = withMT({
  content: [
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/views/**/*.{html,html.erb,erb}',
    './app/javascript/components/**/*.{rb,js,jsx,ts,tsx}',
  ],
  theme: {
    fontFamily: {
      'sans': ["BlinkMacSystemFont", "Avenir Next", "Avenir",
        "Nimbus Sans L", "Roboto", "Noto Sans", "Segoe UI", "Arial", "Helvetica",
        "Helvetica Neue", "sans-serif"],
      'mono': ["Consolas", "Menlo", "Monaco", "Andale Mono", "Ubuntu Mono", "monospace"]
    },
    extend: {
    },
  },
  corePlugins: {
    aspectRatio: false,
  },
  plugins: [
  ],
})

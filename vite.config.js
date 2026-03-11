import { defineConfig } from "vite"

export default defineConfig({
  build: {
    rollupOptions: {
      input: {
        main: "index.html",
        projects: "projects.html",
        services: "services.html",
        experiments: "experiments.html",
        articles: "articles.html",
        contact: "contact.html"
      }
    }
  }
})
import { defineConfig } from "vite"
import { resolve } from "path"

export default defineConfig({
  build: {
    rollupOptions: {
      input: {
        main: resolve(__dirname, "index.html"),
        projects: resolve(__dirname, "projects.html"),
        services: resolve(__dirname, "services.html"),
        experiments: resolve(__dirname, "experiments.html"),
        articles: resolve(__dirname, "articles.html"),
        contact: resolve(__dirname, "contact.html"),
        thankYou: resolve(__dirname, "thank-you.html"),

        restaurantWebsite: resolve(__dirname, "projects/restaurant-website.html"),
        ecommerceStore: resolve(__dirname, "projects/ecommerce-store.html"),
        webglInterface: resolve(__dirname, "projects/webgl-interface.html"),

        seoForLocalBusiness: resolve(__dirname, "articles/seo-for-local-business.html"),
        whyPerformanceMatters: resolve(__dirname, "articles/why-performance-matters.html")
      }
    }
  }
})
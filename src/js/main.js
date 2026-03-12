import { injectHeader } from "./components/header.js";
import { injectFooter } from "./components/footer.js";
import { initReveal } from "./modules/reveal.js";
import { initRotatingText } from "./modules/rotatingText.js";
import { initProjects } from "./modules/projects.js";
import { initFilters } from "./modules/filters.js";
import { initEffects } from "./modules/effects.js";

/* =========================
   SITE THEME
   ========================= */

document.documentElement.dataset.theme = "copper-tech";
// other options:
// "modern-tech"
// "cyber-indigo"
// "warm-purple"


/* =========================
   SITE INITIALIZATION
   ========================= */

document.addEventListener("DOMContentLoaded", async () => {

  // shared layout
  injectHeader();
  injectFooter();

  // UI systems
  initReveal();
  initRotatingText();

  // project page features
  await initProjects();
  initFilters();

  // visual interaction effects
  initEffects();

});
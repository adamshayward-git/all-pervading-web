import { injectHeader } from "./components/header.js";
import { injectFooter } from "./components/footer.js";
import { initReveal } from "./modules/reveal.js";
import { initRotatingText } from "./modules/rotatingText.js";
import { initProjects } from "./modules/projects.js";
import { initFilters } from "./modules/filters.js";
import { initEffects } from "./modules/effects.js";

document.addEventListener("DOMContentLoaded", async () => {
  injectHeader();
  injectFooter();
  initReveal();
  initRotatingText();
  await initProjects();
  initFilters();
  initEffects();
});
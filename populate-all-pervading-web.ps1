$ErrorActionPreference = 'Stop'

# Run this INSIDE your cloned all-pervading-web folder.
# Example:
#   cd D:\AdamHayward\OneDrive - Waha Grill\Desktop\all-pervading-web
#   Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
#   .\populate-all-pervading-web.ps1

$root = Get-Location

$dirs = @(
  'src/css/base',
  'src/css/layout',
  'src/css/components',
  'src/css/utilities',
  'src/css/animations',
  'src/js/components',
  'src/js/modules',
  'data',
  'projects',
  'articles',
  'assets/images/placeholders',
  'docs'
)

foreach ($dir in $dirs) {
  New-Item -ItemType Directory -Path (Join-Path $root $dir) -Force | Out-Null
}

function Write-File {
  param(
    [string]$RelativePath,
    [string]$Content
  )

  $fullPath = Join-Path $root $RelativePath
  $parent = Split-Path $fullPath -Parent
  if (-not (Test-Path $parent)) {
    New-Item -ItemType Directory -Path $parent -Force | Out-Null
  }

  $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
  [System.IO.File]::WriteAllText($fullPath, $Content.TrimStart(), $utf8NoBom)
}

Write-File 'package.json' @'
{
  "name": "all-pervading-web",
  "private": true,
  "version": "1.0.0",
  "type": "module",
  "scripts": {
    "dev": "vite",
    "build": "vite build",
    "preview": "vite preview"
  },
  "devDependencies": {
    "vite": "^5.4.0"
  }
}
'@

Write-File 'vite.config.js' @'
import { defineConfig } from "vite";

export default defineConfig({
  server: { open: true }
});
'@

Write-File 'README.md' @'
# All Pervading Web

## Quick start

```bash
npm install
npm run dev
```

## Pages
- Home
- Projects
- Services
- Experiments
- Articles
- Contact
- Project case studies
- Article pages
'@

Write-File 'NOTES-START-HERE.md' @'
# Start Here

This package is the full Vite study project.

## Includes
- split CSS architecture
- shared header/footer injection
- data-driven project cards
- filtering system
- reveal animation
- rotating hero text
- project case study pages
- article pages
- docs and deployment notes

## Study order
1. src/css/main.css
2. src/css/base
3. src/css/layout
4. src/css/components
5. src/js/main.js
6. src/js/components
7. src/js/modules
8. data/projects.json
9. docs/PROJECT-MAP.md
'@

Write-File 'docs/PROJECT-MAP.md' @'
# Project Map

## Top-level pages
- index.html
- projects.html
- services.html
- experiments.html
- articles.html
- contact.html

## Project case studies
- projects/restaurant-website.html
- projects/ecommerce-store.html
- projects/webgl-interface.html

## Article pages
- articles/seo-for-local-business.html
- articles/why-performance-matters.html
'@

Write-File 'docs/DEPLOYMENT-GUIDE.md' @'
# Deployment Guide

## Netlify / Cloudflare / Vercel

Build command:

```bash
npm run build
```

Output folder:

```bash
dist
```
'@

Write-File 'docs/CSS-ARCHITECTURE-GUIDE.md' @'
# CSS Architecture Guide

This project splits CSS by responsibility:

- base
- layout
- components
- utilities
- animations

This keeps files lean and easier to maintain.
'@

Write-File 'docs/FUTURE-UPGRADES.md' @'
# Future Upgrades

- connect contact form
- add project screenshots
- add article list generation from JSON
- add schema markup
- add custom cursor / magnetic buttons as separate modules
'@

Write-File 'src/css/main.css' @'
@import url("./base/reset.css");
@import url("./base/variables.css");
@import url("./base/typography.css");
@import url("./layout/layout.css");
@import url("./layout/header-footer.css");
@import url("./components/buttons.css");
@import url("./components/cards.css");
@import url("./components/forms.css");
@import url("./utilities/utilities.css");
@import url("./animations/animations.css");
'@

Write-File 'src/css/base/reset.css' @'
*, *::before, *::after { box-sizing: border-box; }
html { scroll-behavior: smooth; }
body, h1, h2, h3, h4, p, ul, ol, li, figure, blockquote { margin: 0; }
ul, ol { padding-left: 1.25rem; }
img { display: block; max-width: 100%; }
button, input, textarea, select { font: inherit; }
a { color: inherit; text-decoration: none; }
'@

Write-File 'src/css/base/variables.css' @'
:root {
  --bg: #0d0f15;
  --bg-soft: #151927;
  --panel: rgba(255,255,255,0.05);
  --line: rgba(255,255,255,0.12);
  --text: #eef2ff;
  --text-soft: #bcc5df;
  --accent: #7c5cff;
  --accent-2: #00d7ff;
  --shadow: 0 24px 60px rgba(0,0,0,0.35);
  --radius-md: 18px;
  --radius-lg: 28px;
  --space-3: 1.5rem;
  --space-4: 2rem;
  --space-5: 3rem;
  --space-6: 5rem;
  --container: 1180px;
  --fs-xl: clamp(2.5rem, 5vw, 5rem);
}
'@

Write-File 'src/css/base/typography.css' @'
body {
  font-family: Inter, ui-sans-serif, system-ui, -apple-system, Segoe UI, Roboto, Arial, sans-serif;
  color: var(--text);
  background:
    radial-gradient(circle at 15% 20%, rgba(124,92,255,.18), transparent 30%),
    radial-gradient(circle at 85% 10%, rgba(0,215,255,.12), transparent 28%),
    linear-gradient(135deg, #0b0d12 0%, #111624 45%, #0d1220 100%);
  line-height: 1.65;
  min-height: 100vh;
}

p, li { color: var(--text-soft); }
h1, h2, h3, h4 { line-height: 1.1; letter-spacing: -0.03em; }
h1 { font-size: var(--fs-xl); margin-bottom: 1rem; }
h2 { font-size: clamp(1.9rem, 3vw, 3rem); margin-bottom: 1rem; }
h3 { font-size: 1.25rem; margin-bottom: .55rem; }
.eyebrow { font-size: .82rem; letter-spacing: .16em; text-transform: uppercase; color: var(--accent-2); }
'@

Write-File 'src/css/layout/layout.css' @'
.site-shell { position: relative; overflow: clip; }
.container { width: min(100% - 2rem, var(--container)); margin-inline: auto; }
.section { padding: var(--space-6) 0; }
.grid-3 { display: grid; gap: var(--space-3); grid-template-columns: repeat(3, minmax(0, 1fr)); }
.hero { min-height: 84vh; display: flex; align-items: center; padding: 7.5rem 0 4rem; }
.hero__layout { display: grid; gap: var(--space-4); grid-template-columns: 1.1fr .9fr; align-items: center; }
.hero__panel, .page-hero, .surface { border: 1px solid var(--line); background: linear-gradient(180deg, rgba(255,255,255,.07), rgba(255,255,255,.03)); backdrop-filter: blur(18px); box-shadow: var(--shadow); }
.hero__panel { border-radius: var(--radius-lg); padding: clamp(1.5rem, 3vw, 3rem); }
.page-hero { width: min(100% - 2rem, var(--container)); margin: 7rem auto 2rem; padding: 2.25rem; border-radius: var(--radius-lg); }
.metrics { display: grid; gap: 1rem; grid-template-columns: repeat(3, minmax(0, 1fr)); margin-top: var(--space-4); }
.metric { padding: 1rem; border-radius: var(--radius-md); background: rgba(255,255,255,.04); border: 1px solid rgba(255,255,255,.08); }
.metric strong { display: block; font-size: 1.4rem; color: var(--text); }
.mockup { min-height: 260px; border-radius: var(--radius-lg); border: 1px solid var(--line); background: radial-gradient(circle at 20% 20%, rgba(124,92,255,.18), transparent 32%), radial-gradient(circle at 80% 30%, rgba(0,215,255,.14), transparent 28%), linear-gradient(180deg, rgba(255,255,255,.06), rgba(255,255,255,.03)); box-shadow: var(--shadow); }
.case-study__grid { display: grid; gap: var(--space-3); grid-template-columns: 1.15fr .85fr; }
.case-study__main > * + * { margin-top: var(--space-4); }
.case-study__side { display: grid; gap: var(--space-3); align-self: start; }
.contact-layout { display: grid; gap: var(--space-4); grid-template-columns: .9fr 1.1fr; }
@media (max-width: 980px) { .hero__layout, .grid-3, .case-study__grid, .contact-layout { grid-template-columns: 1fr; } .hero { min-height: auto; padding-top: 6.5rem; } .metrics { grid-template-columns: 1fr; } }
'@

Write-File 'src/css/layout/header-footer.css' @'
.site-header { position: fixed; inset: 0 0 auto 0; z-index: 100; transition: background .25s ease, border-color .25s ease; border-bottom: 1px solid transparent; }
.site-header.is-scrolled { background: rgba(8,10,15,0.72); backdrop-filter: blur(16px); border-color: var(--line); }
.site-header__inner, .site-footer__inner { width: min(100% - 2rem, var(--container)); margin-inline: auto; }
.site-header__inner { display: flex; align-items: center; justify-content: space-between; gap: 1.25rem; padding: 1rem 0; }
.brand { font-weight: 700; letter-spacing: -0.03em; }
.site-nav { display: flex; align-items: center; gap: 1rem; flex-wrap: wrap; }
.site-nav a { padding: .55rem .85rem; border-radius: 999px; color: var(--text-soft); transition: color .2s ease, background .2s ease; }
.site-nav a:hover, .site-nav a.is-active { color: var(--text); background: rgba(255,255,255,.07); }
.site-footer { padding: 2rem 0 3rem; border-top: 1px solid var(--line); margin-top: var(--space-6); }
.site-footer__inner { display: flex; justify-content: space-between; gap: 1rem; flex-wrap: wrap; }
.site-footer p { color: var(--text-soft); }
@media (max-width: 700px) { .site-header__inner { align-items: flex-start; flex-direction: column; } }
'@

Write-File 'src/css/components/buttons.css' @'
.btn, button.btn, .project-filter button { border: 0; cursor: pointer; }
.btn { display: inline-flex; align-items: center; justify-content: center; padding: .9rem 1.25rem; border-radius: 999px; font-weight: 600; transition: transform .2s ease, box-shadow .2s ease, background .2s ease, border-color .2s ease; border: 1px solid transparent; min-width: 8rem; }
.btn:hover { transform: translateY(-2px); }
.btn--primary { background: linear-gradient(135deg, var(--accent), #9b82ff); color: white; box-shadow: 0 12px 30px rgba(124,92,255,.28); }
.btn--secondary { background: rgba(255,255,255,.05); color: var(--text); border-color: var(--line); }
.hero-buttons { display: flex; gap: .85rem; flex-wrap: wrap; margin-top: 1.25rem; }
.project-filter { display: flex; gap: .75rem; flex-wrap: wrap; margin: 1.25rem 0 1.75rem; }
.project-filter button { padding: .65rem 1rem; background: rgba(255,255,255,.04); color: var(--text-soft); border-radius: 999px; border: 1px solid var(--line); transition: all .2s ease; }
.project-filter button.active, .project-filter button:hover { color: var(--text); background: rgba(124,92,255,.18); border-color: rgba(124,92,255,.45); }
'@

Write-File 'src/css/components/cards.css' @'
.project-grid, .service-grid, .article-grid { display: grid; gap: var(--space-3); grid-template-columns: repeat(3, minmax(0, 1fr)); }
.project-card, .service-card, .article-card, .info-card { display: block; padding: 1.4rem; border-radius: var(--radius-md); border: 1px solid var(--line); background: linear-gradient(180deg, rgba(255,255,255,.06), rgba(255,255,255,.035)); box-shadow: var(--shadow); position: relative; overflow: hidden; transition: transform .22s ease, border-color .22s ease, background .22s ease, box-shadow .22s ease; }
.project-card:hover, .service-card:hover, .article-card:hover, .info-card:hover { transform: translateY(-6px); border-color: rgba(124,92,255,.45); background: linear-gradient(180deg, rgba(255,255,255,.08), rgba(255,255,255,.04)); }
.project-card p, .service-card p, .article-card p { margin-top: .5rem; }
.project-card__meta, .article-card__meta { display: flex; justify-content: space-between; gap: .75rem; flex-wrap: wrap; margin-top: 1rem; font-size: .9rem; color: var(--text-soft); }
.card-tag { display: inline-block; padding: .35rem .65rem; border-radius: 999px; background: rgba(255,255,255,.06); border: 1px solid rgba(255,255,255,.08); font-size: .78rem; color: var(--text-soft); }
@media (max-width: 980px) { .project-grid, .service-grid, .article-grid { grid-template-columns: 1fr; } }
'@

Write-File 'src/css/components/forms.css' @'
.contact-form { display: grid; gap: 1rem; padding: 1.4rem; border-radius: var(--radius-md); border: 1px solid var(--line); background: linear-gradient(180deg, rgba(255,255,255,.06), rgba(255,255,255,.03)); box-shadow: var(--shadow); }
.contact-form label { display: grid; gap: .45rem; color: var(--text); font-weight: 600; }
.contact-form input, .contact-form textarea { width: 100%; padding: .95rem 1rem; border-radius: 12px; border: 1px solid var(--line); background: rgba(255,255,255,.04); color: var(--text); }
.contact-form textarea { min-height: 160px; resize: vertical; }
'@

Write-File 'src/css/utilities/utilities.css' @'
.center { text-align: center; }
.muted { color: var(--text-soft); }
.hidden { display: none !important; }
'@

Write-File 'src/css/animations/animations.css' @'
.reveal { opacity: 0; transform: translateY(24px); transition: opacity .7s ease, transform .7s ease; }
.reveal.is-visible { opacity: 1; transform: translateY(0); }
.rotating-text { display: inline-grid; position: relative; min-width: 12ch; margin-left: .35rem; vertical-align: bottom; }
.rotating-text > span { grid-area: 1 / 1; opacity: 0; transform: translateY(10px); transition: opacity .35s ease, transform .35s ease; color: var(--accent-2); }
.rotating-text > span.is-visible { opacity: 1; transform: translateY(0); }
'@

Write-File 'src/js/main.js' @'
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
'@

Write-File 'src/js/components/header.js' @'
export function injectHeader() {
  const target = document.getElementById("header-placeholder");
  if (!target) return;

  const current = window.location.pathname.split("/").pop() || "index.html";

  target.innerHTML = `
    <header class="site-header" id="site-header">
      <div class="site-header__inner">
        <a class="brand" href="/index.html">All Pervading Web</a>
        <nav class="site-nav" aria-label="Primary">
          <a href="/index.html" class="${current === "index.html" ? "is-active" : ""}">Home</a>
          <a href="/projects.html" class="${current === "projects.html" ? "is-active" : ""}">Projects</a>
          <a href="/services.html" class="${current === "services.html" ? "is-active" : ""}">Services</a>
          <a href="/experiments.html" class="${current === "experiments.html" ? "is-active" : ""}">Experiments</a>
          <a href="/articles.html" class="${current === "articles.html" ? "is-active" : ""}">Articles</a>
          <a href="/contact.html" class="${current === "contact.html" ? "is-active" : ""}">Contact</a>
        </nav>
      </div>
    </header>
  `;

  const header = document.getElementById("site-header");
  const onScroll = () => {
    if (window.scrollY > 8) header.classList.add("is-scrolled");
    else header.classList.remove("is-scrolled");
  };
  onScroll();
  window.addEventListener("scroll", onScroll, { passive: true });
}
'@

Write-File 'src/js/components/footer.js' @'
export function injectFooter() {
  const target = document.getElementById("footer-placeholder");
  if (!target) return;

  target.innerHTML = `
    <footer class="site-footer">
      <div class="site-footer__inner">
        <p>© All Pervading Web</p>
        <p>Modern websites, web applications, and future-facing UI experiments.</p>
      </div>
    </footer>
  `;
}
'@

Write-File 'src/js/modules/reveal.js' @'
export function initReveal() {
  const items = document.querySelectorAll(".reveal");
  if (!items.length) return;

  const observer = new IntersectionObserver((entries) => {
    entries.forEach((entry) => {
      if (entry.isIntersecting) entry.target.classList.add("is-visible");
    });
  }, { threshold: 0.15 });

  items.forEach((item) => observer.observe(item));
}
'@

Write-File 'src/js/modules/rotatingText.js' @'
export function initRotatingText() {
  const wrap = document.querySelector(".rotating-text");
  if (!wrap) return;

  const words = [...wrap.children];
  if (!words.length) return;

  let index = 0;
  words[index].classList.add("is-visible");

  setInterval(() => {
    words[index].classList.remove("is-visible");
    index = (index + 1) % words.length;
    words[index].classList.add("is-visible");
  }, 2200);
}
'@

Write-File 'src/js/modules/projects.js' @'
function createProjectCard(project) {
  const article = document.createElement("a");
  article.className = "project-card reveal";
  article.href = project.link;
  article.dataset.category = project.category;
  article.innerHTML = `
    <span class="card-tag">${project.category}</span>
    <h3>${project.title}</h3>
    <p>${project.description}</p>
    <div class="project-card__meta">
      <span>${project.stack.join(" • ")}</span>
      <span>View Case Study</span>
    </div>
  `;
  return article;
}

export async function initProjects() {
  const grid = document.getElementById("project-grid");
  if (!grid) return;

  try {
    const res = await fetch("/data/projects.json");
    const projects = await res.json();

    grid.innerHTML = "";
    projects.forEach((project) => {
      grid.appendChild(createProjectCard(project));
    });

    document.querySelectorAll(".project-card.reveal").forEach((item) => {
      requestAnimationFrame(() => item.classList.add("is-visible"));
    });
  } catch (error) {
    grid.innerHTML = "<p>Unable to load projects right now.</p>";
    console.error(error);
  }
}
'@

Write-File 'src/js/modules/filters.js' @'
export function initFilters() {
  const filterButtons = document.querySelectorAll(".project-filter button");
  const cards = () => document.querySelectorAll(".project-card");

  if (!filterButtons.length) return;

  filterButtons.forEach((button) => {
    button.addEventListener("click", () => {
      filterButtons.forEach((b) => b.classList.remove("active"));
      button.classList.add("active");

      const filter = button.dataset.filter;

      cards().forEach((card) => {
        if (filter === "all" || card.dataset.category === filter) {
          card.classList.remove("hidden");
        } else {
          card.classList.add("hidden");
        }
      });
    });
  });
}
'@

Write-File 'src/js/modules/effects.js' @'
export function initEffects() {
  const cards = document.querySelectorAll(".project-card");

  cards.forEach((card) => {
    card.addEventListener("mousemove", (event) => {
      const rect = card.getBoundingClientRect();
      const x = event.clientX - rect.left;
      const y = event.clientY - rect.top;
      const centerX = rect.width / 2;
      const centerY = rect.height / 2;
      const rotateX = ((y - centerY) / 18).toFixed(2);
      const rotateY = ((centerX - x) / 18).toFixed(2);
      card.style.transform = `translateY(-6px) rotateX(${rotateX}deg) rotateY(${rotateY}deg)`;
    });

    card.addEventListener("mouseleave", () => {
      card.style.transform = "";
    });
  });
}
'@

Write-File 'data/projects.json' @'
[
  {
    "title": "Restaurant Website",
    "description": "A mobile-first website that made menus, hours, and booking easy to find on any screen.",
    "category": "business",
    "stack": ["HTML", "CSS", "JavaScript"],
    "link": "/projects/restaurant-website.html"
  },
  {
    "title": "Ecommerce Store",
    "description": "A fast storefront concept with clean product browsing and a premium purchase flow.",
    "category": "ecommerce",
    "stack": ["Vite", "CSS Grid", "UI Patterns"],
    "link": "/projects/ecommerce-store.html"
  },
  {
    "title": "WebGL Interface",
    "description": "An experimental concept exploring spatial UI patterns and future-facing interaction design.",
    "category": "experimental",
    "stack": ["Three.js", "Interaction Design"],
    "link": "/projects/webgl-interface.html"
  }
]
'@

Write-File 'data/articles.json' @'
[
  {
    "title": "SEO for Local Businesses",
    "description": "How thoughtful structure, speed, and content improve search visibility.",
    "category": "seo",
    "link": "/articles/seo-for-local-business.html"
  },
  {
    "title": "Why Performance Still Matters",
    "description": "Fast sites rank better, convert better, and simply feel better.",
    "category": "performance",
    "link": "/articles/why-performance-matters.html"
  }
]
'@

Write-File 'projects/restaurant-website.html' @'
<!DOCTYPE html>
<html lang="en"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title>Restaurant Website</title><link rel="stylesheet" href="/src/css/main.css"></head><body><div class="site-shell"><div id="header-placeholder"></div><section class="page-hero reveal"><div class="eyebrow">Case Study</div><h1>Restaurant Website</h1><p>A mobile-first business website focused on fast access to menus, hours, and contact details.</p></section><section class="section"><div class="container"><div class="mockup reveal"></div></div></section><div id="footer-placeholder"></div></div><script type="module" src="/src/js/main.js"></script></body></html>
'@

Write-File 'projects/ecommerce-store.html' @'
<!DOCTYPE html>
<html lang="en"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title>Ecommerce Store</title><link rel="stylesheet" href="/src/css/main.css"></head><body><div class="site-shell"><div id="header-placeholder"></div><section class="page-hero reveal"><div class="eyebrow">Case Study</div><h1>Ecommerce Store</h1><p>A storefront concept built around speed, clarity, and a more premium browsing experience.</p></section><section class="section"><div class="container"><div class="mockup reveal"></div></div></section><div id="footer-placeholder"></div></div><script type="module" src="/src/js/main.js"></script></body></html>
'@

Write-File 'projects/webgl-interface.html' @'
<!DOCTYPE html>
<html lang="en"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title>WebGL Interface</title><link rel="stylesheet" href="/src/css/main.css"></head><body><div class="site-shell"><div id="header-placeholder"></div><section class="page-hero reveal"><div class="eyebrow">Case Study</div><h1>WebGL Interface</h1><p>An experimental concept exploring layered motion, spatial depth, and future-facing interface ideas.</p></section><section class="section"><div class="container"><div class="mockup reveal"></div></div></section><div id="footer-placeholder"></div></div><script type="module" src="/src/js/main.js"></script></body></html>
'@

Write-File 'articles/seo-for-local-business.html' @'
<!DOCTYPE html>
<html lang="en"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title>SEO for Local Businesses</title><link rel="stylesheet" href="/src/css/main.css"></head><body><div class="site-shell"><div id="header-placeholder"></div><section class="page-hero reveal"><div class="eyebrow">Article</div><h1>SEO for Local Businesses</h1><p>Simple improvements in structure, speed, and content can make a noticeable difference.</p></section><div id="footer-placeholder"></div></div><script type="module" src="/src/js/main.js"></script></body></html>
'@

Write-File 'articles/why-performance-matters.html' @'
<!DOCTYPE html>
<html lang="en"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title>Why Performance Still Matters</title><link rel="stylesheet" href="/src/css/main.css"></head><body><div class="site-shell"><div id="header-placeholder"></div><section class="page-hero reveal"><div class="eyebrow">Article</div><h1>Why Performance Still Matters</h1><p>Beautiful websites still need to be fast, especially on mobile connections.</p></section><div id="footer-placeholder"></div></div><script type="module" src="/src/js/main.js"></script></body></html>
'@

Write-File 'assets/images/placeholders/README.txt' @'
Place project screenshots here later.
Suggested files:
- restaurant-website-home.webp
- ecommerce-store-grid.webp
- webgl-interface-hero.webp
'@

Write-Host ""
Write-Host "Project created in: $root" -ForegroundColor Green
Write-Host ""
Write-Host "Next:" -ForegroundColor Cyan
Write-Host "  npm install"
Write-Host "  npm run dev"
Write-Host ""
Write-Host "Then push to GitHub:" -ForegroundColor Cyan
Write-Host "  git add ."
Write-Host "  git commit -m 'Add full portfolio project'"
Write-Host "  git push"

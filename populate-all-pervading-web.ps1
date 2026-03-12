param(
  [switch]$Force
)

$ErrorActionPreference = 'Stop'

# Run this INSIDE your all-pervading-web folder.
# Example:
#   cd D:\AdamHayward\OneDrive - Waha Grill\Documents\New Web\all-pervading-web
#   Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
#   .\populate-all-pervading-web.ps1
#
# To overwrite existing files intentionally:
#   .\populate-all-pervading-web.ps1 -Force

$root = Get-Location

$dirs = @(
  'src/css/base',
  'src/css/layout',
  'src/css/components',
  'src/css/utilities',
  'src/css/animations',
  'src/js/components',
  'src/js/modules',
  'src/assets/images',
  'src/assets/icons',
  'data',
  'projects',
  'articles',
  'docs'
)

foreach ($dir in $dirs) {
  New-Item -ItemType Directory -Path (Join-Path $root $dir) -Force | Out-Null
}

function Write-File {
  param(
    [string]$RelativePath,
    [string]$Content,
    [switch]$ForceWrite
  )

  $fullPath = Join-Path $root $RelativePath
  $parent = Split-Path $fullPath -Parent

  if (-not (Test-Path $parent)) {
    New-Item -ItemType Directory -Path $parent -Force | Out-Null
  }

  if ((Test-Path $fullPath) -and (-not $ForceWrite)) {
    Write-Host "Skipped existing file: $RelativePath" -ForegroundColor Yellow
    return
  }

  $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
  [System.IO.File]::WriteAllText($fullPath, $Content.TrimStart(), $utf8NoBom)
  Write-Host "Wrote: $RelativePath" -ForegroundColor DarkGray
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
'@ -ForceWrite:$Force

Write-File 'vite.config.js' @'
import { defineConfig } from "vite";

export default defineConfig({
  server: { open: true }
});
'@ -ForceWrite:$Force

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
'@ -ForceWrite:$Force

Write-File 'NOTES-START-HERE.md' @'
# Start Here

This package is the full Vite study project.

## Includes
- split CSS architecture
- theme-ready color system
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
'@ -ForceWrite:$Force

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
'@ -ForceWrite:$Force

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
'@ -ForceWrite:$Force

Write-File 'docs/CSS-ARCHITECTURE-GUIDE.md' @'
# CSS Architecture Guide

This project splits CSS by responsibility:

- base
- layout
- components
- utilities
- animations

Colors are kept in:
- src/css/base/colors.css

Design tokens are kept in:
- src/css/base/variables.css

This keeps files lean and easier to maintain.
'@ -ForceWrite:$Force

Write-File 'docs/FUTURE-UPGRADES.md' @'
# Future Upgrades

- connect contact form
- add project screenshots
- add article list generation from JSON
- add schema markup
- add custom cursor / magnetic buttons as separate modules
- add a live theme switcher
'@ -ForceWrite:$Force

Write-File 'docs/THEME-NOTES.md' @'
# Theme Notes

Available themes:
- copper-tech
- modern-tech
- cyber-indigo
- warm-purple

Set the theme in:
src/js/main.js

Example:
document.documentElement.dataset.theme = "copper-tech";
'@ -ForceWrite:$Force

Write-File 'src/css/main.css' @'
@import url("./base/reset.css");
@import url("./base/variables.css");
@import url("./base/colors.css");
@import url("./base/typography.css");
@import url("./layout/layout.css");
@import url("./layout/header-footer.css");
@import url("./components/buttons.css");
@import url("./components/cards.css");
@import url("./components/forms.css");
@import url("./utilities/utilities.css");
@import url("./animations/animations.css");
'@ -ForceWrite:$Force

Write-File 'src/css/base/reset.css' @'
*, *::before, *::after {
  box-sizing: border-box;
}

html {
  scroll-behavior: smooth;
}

body, h1, h2, h3, h4, p, ul, ol, li, figure, blockquote {
  margin: 0;
}

ul, ol {
  padding-left: 1.25rem;
}

img {
  display: block;
  max-width: 100%;
}

button, input, textarea, select {
  font: inherit;
}

a {
  color: inherit;
  text-decoration: none;
}
'@ -ForceWrite:$Force

Write-File 'src/css/base/variables.css' @'
:root {
  --radius-md: 18px;
  --radius-lg: 28px;

  --space-3: 1.5rem;
  --space-4: 2rem;
  --space-5: 3rem;
  --space-6: 5rem;

  --container: 1180px;
  --fs-xl: clamp(2.5rem, 5vw, 5rem);
}
'@ -ForceWrite:$Force

Write-File 'src/css/base/colors.css' @'
/* =========================
   DEFAULT / CURRENT THEME
   ========================= */

:root {
  --bg: #0d0f15;
  --bg-soft: #151927;
  --panel: rgba(255, 255, 255, 0.05);
  --line: rgba(255, 255, 255, 0.12);

  --text: #eef2ff;
  --text-soft: #bcc5df;

  --accent: #7c5cff;
  --accent-2: #00d7ff;

  --shadow: 0 24px 60px rgba(0, 0, 0, 0.35);

  --form-bg-1: rgba(255, 255, 255, 0.06);
  --form-bg-2: rgba(255, 255, 255, 0.03);
  --input-bg: rgba(255, 255, 255, 0.04);
  --input-focus-line: rgba(124, 92, 255, 0.45);
  --input-focus-ring: rgba(124, 92, 255, 0.18);

  --header-bg: rgba(8, 10, 15, 0.72);
  --nav-hover-bg: rgba(255, 255, 255, 0.06);
  --nav-active-bg: rgba(124, 92, 255, 0.18);
  --nav-active-line: rgba(124, 92, 255, 0.35);

  --surface-bg-1: rgba(255, 255, 255, 0.07);
  --surface-bg-2: rgba(255, 255, 255, 0.03);

  --metric-bg: rgba(255, 255, 255, 0.04);
  --metric-line: rgba(255, 255, 255, 0.08);

  --mockup-glow-1: rgba(124, 92, 255, 0.18);
  --mockup-glow-2: rgba(0, 215, 255, 0.14);
  --mockup-bg-1: rgba(255, 255, 255, 0.06);
  --mockup-bg-2: rgba(255, 255, 255, 0.03);
}


/* =========================
   MODERN TECH
   ========================= */

:root[data-theme="modern-tech"] {
  --bg: #0b1320;
  --bg-soft: #111827;
  --panel: rgba(255, 255, 255, 0.05);
  --line: rgba(79, 156, 249, 0.18);

  --text: #e6eaf0;
  --text-soft: #9ca3af;

  --accent: #22e3e8;
  --accent-2: #4f9cf9;

  --shadow: 0 24px 60px rgba(0, 0, 0, 0.35);

  --form-bg-1: rgba(255, 255, 255, 0.06);
  --form-bg-2: rgba(255, 255, 255, 0.03);
  --input-bg: rgba(255, 255, 255, 0.04);
  --input-focus-line: rgba(79, 156, 249, 0.45);
  --input-focus-ring: rgba(79, 156, 249, 0.18);

  --header-bg: rgba(8, 12, 20, 0.72);
  --nav-hover-bg: rgba(255, 255, 255, 0.06);
  --nav-active-bg: rgba(34, 227, 232, 0.16);
  --nav-active-line: rgba(34, 227, 232, 0.35);

  --surface-bg-1: rgba(255, 255, 255, 0.07);
  --surface-bg-2: rgba(255, 255, 255, 0.03);

  --metric-bg: rgba(255, 255, 255, 0.04);
  --metric-line: rgba(255, 255, 255, 0.08);

  --mockup-glow-1: rgba(34, 227, 232, 0.18);
  --mockup-glow-2: rgba(79, 156, 249, 0.14);
  --mockup-bg-1: rgba(255, 255, 255, 0.06);
  --mockup-bg-2: rgba(255, 255, 255, 0.03);
}


/* =========================
   COPPER TECH
   ========================= */

:root[data-theme="copper-tech"] {
  --bg: #0e1116;
  --bg-soft: #1e1a16;
  --panel: rgba(230, 169, 107, 0.06);
  --line: rgba(230, 169, 107, 0.18);

  --text: #f5f3ef;
  --text-soft: #a8a29e;

  --accent: #c97a40;
  --accent-2: #e6a96b;

  --shadow: 0 24px 60px rgba(0, 0, 0, 0.35);

  --form-bg-1: rgba(230, 169, 107, 0.08);
  --form-bg-2: rgba(230, 169, 107, 0.04);
  --input-bg: rgba(230, 169, 107, 0.05);
  --input-focus-line: rgba(230, 169, 107, 0.45);
  --input-focus-ring: rgba(230, 169, 107, 0.18);

  --header-bg: rgba(14, 17, 22, 0.75);
  --nav-hover-bg: rgba(230, 169, 107, 0.08);
  --nav-active-bg: rgba(230, 169, 107, 0.16);
  --nav-active-line: rgba(230, 169, 107, 0.35);

  --surface-bg-1: rgba(230, 169, 107, 0.09);
  --surface-bg-2: rgba(230, 169, 107, 0.04);

  --metric-bg: rgba(230, 169, 107, 0.06);
  --metric-line: rgba(230, 169, 107, 0.14);

  --mockup-glow-1: rgba(201, 122, 64, 0.2);
  --mockup-glow-2: rgba(230, 169, 107, 0.14);
  --mockup-bg-1: rgba(230, 169, 107, 0.08);
  --mockup-bg-2: rgba(230, 169, 107, 0.04);
}


/* =========================
   CYBER INDIGO
   ========================= */

:root[data-theme="cyber-indigo"] {
  --bg: #0b0b1a;
  --bg-soft: #16162b;
  --panel: rgba(255, 255, 255, 0.05);
  --line: rgba(124, 108, 242, 0.2);

  --text: #eaeaf4;
  --text-soft: #9aa0b3;

  --accent: #7c6cf2;
  --accent-2: #2ee6d6;

  --shadow: 0 24px 60px rgba(0, 0, 0, 0.35);

  --form-bg-1: rgba(255, 255, 255, 0.06);
  --form-bg-2: rgba(255, 255, 255, 0.03);
  --input-bg: rgba(255, 255, 255, 0.04);
  --input-focus-line: rgba(124, 108, 242, 0.45);
  --input-focus-ring: rgba(124, 108, 242, 0.18);

  --header-bg: rgba(11, 11, 26, 0.75);
  --nav-hover-bg: rgba(255, 255, 255, 0.06);
  --nav-active-bg: rgba(124, 108, 242, 0.16);
  --nav-active-line: rgba(124, 108, 242, 0.35);

  --surface-bg-1: rgba(255, 255, 255, 0.07);
  --surface-bg-2: rgba(255, 255, 255, 0.03);

  --metric-bg: rgba(255, 255, 255, 0.04);
  --metric-line: rgba(255, 255, 255, 0.08);

  --mockup-glow-1: rgba(124, 108, 242, 0.18);
  --mockup-glow-2: rgba(46, 230, 214, 0.14);
  --mockup-bg-1: rgba(255, 255, 255, 0.06);
  --mockup-bg-2: rgba(255, 255, 255, 0.03);
}


/* =========================
   WARM PURPLE
   ========================= */

:root[data-theme="warm-purple"] {
  --bg: #0f1020;
  --bg-soft: #1a1b2e;
  --panel: rgba(255, 255, 255, 0.05);
  --line: rgba(192, 132, 252, 0.18);

  --text: #f3f4f6;
  --text-soft: #a1a1aa;

  --accent: #8b5cf6;
  --accent-2: #c084fc;

  --shadow: 0 24px 60px rgba(0, 0, 0, 0.35);

  --form-bg-1: rgba(255, 255, 255, 0.06);
  --form-bg-2: rgba(255, 255, 255, 0.03);
  --input-bg: rgba(255, 255, 255, 0.04);
  --input-focus-line: rgba(192, 132, 252, 0.45);
  --input-focus-ring: rgba(192, 132, 252, 0.18);

  --header-bg: rgba(15, 16, 32, 0.75);
  --nav-hover-bg: rgba(255, 255, 255, 0.06);
  --nav-active-bg: rgba(192, 132, 252, 0.16);
  --nav-active-line: rgba(192, 132, 252, 0.35);

  --surface-bg-1: rgba(255, 255, 255, 0.07);
  --surface-bg-2: rgba(255, 255, 255, 0.03);

  --metric-bg: rgba(255, 255, 255, 0.04);
  --metric-line: rgba(255, 255, 255, 0.08);

  --mockup-glow-1: rgba(139, 92, 246, 0.18);
  --mockup-glow-2: rgba(192, 132, 252, 0.14);
  --mockup-bg-1: rgba(255, 255, 255, 0.06);
  --mockup-bg-2: rgba(255, 255, 255, 0.03);
}
'@ -ForceWrite:$Force

Write-File 'src/css/base/typography.css' @'
body {
  font-family: Inter, ui-sans-serif, system-ui, -apple-system, Segoe UI, Roboto, Arial, sans-serif;
  color: var(--text);
  background:
    radial-gradient(circle at 15% 20%, var(--mockup-glow-1), transparent 30%),
    radial-gradient(circle at 85% 10%, var(--mockup-glow-2), transparent 28%),
    linear-gradient(135deg, var(--bg) 0%, var(--bg-soft) 45%, var(--bg) 100%);
  line-height: 1.65;
  min-height: 100vh;
}

p,
li {
  color: var(--text-soft);
}

h1,
h2,
h3,
h4 {
  line-height: 1.1;
  letter-spacing: -0.03em;
  color: var(--text);
}

h1 {
  font-size: var(--fs-xl);
  margin-bottom: 1rem;
}

h2 {
  font-size: clamp(1.9rem, 3vw, 3rem);
  margin-bottom: 1rem;
}

h3 {
  font-size: 1.25rem;
  margin-bottom: 0.55rem;
}

.eyebrow {
  font-size: 0.82rem;
  letter-spacing: 0.16em;
  text-transform: uppercase;
  color: var(--accent-2);
}
'@ -ForceWrite:$Force

Write-File 'src/css/layout/layout.css' @'
.site-shell {
  position: relative;
  overflow: clip;
}

.container {
  width: min(100% - 2rem, var(--container));
  margin-inline: auto;
}

.section {
  padding: var(--space-6) 0;
}

.grid-3 {
  display: grid;
  gap: var(--space-3);
  grid-template-columns: repeat(3, minmax(0, 1fr));
}

.hero {
  min-height: 84vh;
  display: flex;
  align-items: center;
  padding: 7.5rem 0 4rem;
}

.hero__layout {
  display: grid;
  gap: var(--space-4);
  grid-template-columns: 1.1fr 0.9fr;
  align-items: center;
}

.hero__panel,
.page-hero,
.surface {
  border: 1px solid var(--line);
  background: linear-gradient(180deg, var(--surface-bg-1), var(--surface-bg-2));
  backdrop-filter: blur(18px);
  box-shadow: var(--shadow);
}

.hero__panel {
  border-radius: var(--radius-lg);
  padding: clamp(1.5rem, 3vw, 3rem);
}

.page-hero {
  width: min(100% - 2rem, var(--container));
  margin: 7rem auto 2rem;
  padding: 2.25rem;
  border-radius: var(--radius-lg);
}

.metrics {
  display: grid;
  gap: 1rem;
  grid-template-columns: repeat(3, minmax(0, 1fr));
  margin-top: var(--space-4);
}

.metric {
  padding: 1rem;
  border-radius: var(--radius-md);
  background: var(--metric-bg);
  border: 1px solid var(--metric-line);
}

.metric strong {
  display: block;
  font-size: 1.4rem;
  color: var(--text);
}

.mockup {
  min-height: 260px;
  border-radius: var(--radius-lg);
  border: 1px solid var(--line);
  background:
    radial-gradient(circle at 20% 20%, var(--mockup-glow-1), transparent 32%),
    radial-gradient(circle at 80% 30%, var(--mockup-glow-2), transparent 28%),
    linear-gradient(180deg, var(--mockup-bg-1), var(--mockup-bg-2));
  box-shadow: var(--shadow);
}

.case-study__grid {
  display: grid;
  gap: var(--space-3);
  grid-template-columns: 1.15fr 0.85fr;
}

.case-study__main > * + * {
  margin-top: var(--space-4);
}

.case-study__side {
  display: grid;
  gap: var(--space-3);
  align-self: start;
}

.contact-layout {
  display: grid;
  gap: var(--space-4);
  grid-template-columns: 0.9fr 1.1fr;
}

@media (max-width: 980px) {
  .hero__layout,
  .grid-3,
  .case-study__grid,
  .contact-layout {
    grid-template-columns: 1fr;
  }

  .hero {
    min-height: auto;
    padding-top: 6.5rem;
  }

  .metrics {
    grid-template-columns: 1fr;
  }
}
'@ -ForceWrite:$Force

Write-File 'src/css/layout/header-footer.css' @'
.site-header {
  position: fixed;
  inset: 0 0 auto 0;
  z-index: 100;
  background: var(--header-bg);
  backdrop-filter: blur(16px);
  border-bottom: 1px solid var(--line);
}

.site-header__inner {
  width: min(100% - 2rem, var(--container));
  margin-inline: auto;
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 1.5rem;
  padding: 1rem 0;
}

.brand {
  font-weight: 700;
  font-size: 1.2rem;
  letter-spacing: -0.03em;
  color: var(--text);
  white-space: nowrap;
}

.site-nav {
  display: flex;
  align-items: center;
  gap: 0.4rem;
  flex-wrap: wrap;
}

.site-nav a {
  padding: 0.65rem 0.9rem;
  border-radius: 999px;
  color: var(--text-soft);
  transition: color 0.2s ease, background 0.2s ease, border-color 0.2s ease;
}

.site-nav a:hover {
  color: var(--text);
  background: var(--nav-hover-bg);
}

.site-nav a.is-active {
  color: var(--text);
  background: var(--nav-active-bg);
  border: 1px solid var(--nav-active-line);
}

.site-footer {
  padding: 2rem 0 3rem;
  border-top: 1px solid var(--line);
  margin-top: var(--space-6);
}

.site-footer__inner {
  width: min(100% - 2rem, var(--container));
  margin-inline: auto;
  display: flex;
  justify-content: space-between;
  gap: 1rem;
  flex-wrap: wrap;
}

.site-footer p {
  color: var(--text-soft);
}

@media (max-width: 820px) {
  .site-header__inner {
    flex-direction: column;
    align-items: flex-start;
  }

  .site-nav {
    gap: 0.25rem;
  }

  .site-nav a {
    padding: 0.5rem 0.75rem;
  }
}
'@ -ForceWrite:$Force

Write-File 'src/css/components/buttons.css' @'
.btn,
button.btn,
.project-filter button {
  border: 0;
  cursor: pointer;
}

.btn {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  padding: 0.9rem 1.25rem;
  border-radius: 999px;
  font-weight: 600;
  transition: transform 0.2s ease, box-shadow 0.2s ease, background 0.2s ease, border-color 0.2s ease;
  border: 1px solid transparent;
  min-width: 8rem;
}

.btn:hover {
  transform: translateY(-2px);
}

.btn--primary {
  background: linear-gradient(135deg, var(--accent), var(--accent-2));
  color: white;
  box-shadow: 0 12px 30px rgba(0, 0, 0, 0.2);
}

.btn--secondary {
  background: var(--panel);
  color: var(--text);
  border-color: var(--line);
}

.hero-buttons {
  display: flex;
  gap: 0.85rem;
  flex-wrap: wrap;
  margin-top: 1.25rem;
}

.project-filter {
  display: flex;
  gap: 0.75rem;
  flex-wrap: wrap;
  margin: 1.25rem 0 1.75rem;
}

.project-filter button {
  padding: 0.65rem 1rem;
  background: var(--panel);
  color: var(--text-soft);
  border-radius: 999px;
  border: 1px solid var(--line);
  transition: all 0.2s ease;
}

.project-filter button.active,
.project-filter button:hover {
  color: var(--text);
  background: var(--nav-active-bg);
  border-color: var(--nav-active-line);
}
'@ -ForceWrite:$Force

Write-File 'src/css/components/cards.css' @'
.project-image {
  width: 100%;
  height: 180px;
  overflow: hidden;
  border-radius: 12px;
  margin-bottom: 1rem;
  position: relative;
}

.project-image::after {
  content: "";
  position: absolute;
  inset: 0;
  background: linear-gradient(to bottom, transparent, rgba(0, 0, 0, 0.35));
}

.project-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.4s ease;
}

.project-card:hover img {
  transform: scale(1.05);
}

.project-grid,
.service-grid,
.article-grid {
  display: grid;
  gap: var(--space-3);
  grid-template-columns: repeat(3, minmax(0, 1fr));
}

.project-card,
.service-card,
.article-card,
.info-card {
  display: block;
  padding: 1.4rem;
  border-radius: var(--radius-md);
  border: 1px solid var(--line);
  background: linear-gradient(180deg, var(--surface-bg-1), var(--surface-bg-2));
  box-shadow: var(--shadow);
  position: relative;
  overflow: hidden;
  transition: transform 0.22s ease, border-color 0.22s ease, background 0.22s ease, box-shadow 0.22s ease;
}

.project-card:hover,
.service-card:hover,
.article-card:hover,
.info-card:hover {
  transform: translateY(-6px);
  border-color: var(--nav-active-line);
  background: linear-gradient(180deg, var(--panel), var(--surface-bg-2));
}

.project-card p,
.service-card p,
.article-card p {
  margin-top: 0.5rem;
}

.project-card__meta,
.article-card__meta {
  display: flex;
  justify-content: space-between;
  gap: 0.75rem;
  flex-wrap: wrap;
  margin-top: 1rem;
  font-size: 0.9rem;
  color: var(--text-soft);
}

.card-tag {
  display: inline-block;
  padding: 0.35rem 0.65rem;
  border-radius: 999px;
  background: var(--panel);
  border: 1px solid var(--line);
  font-size: 0.78rem;
  color: var(--text-soft);
}

.project-category {
  font-size: 0.75rem;
  letter-spacing: 0.14em;
  text-transform: uppercase;
  color: var(--accent);
  margin-bottom: 0.35rem;
  opacity: 0.85;
  font-weight: 600;
}

.article-category {
  font-size: 0.75rem;
  letter-spacing: 0.12em;
  text-transform: uppercase;
  color: var(--accent);
  margin-bottom: 0.35rem;
  opacity: 0.8;
}

@media (max-width: 980px) {
  .project-grid,
  .service-grid,
  .article-grid {
    grid-template-columns: 1fr;
  }
}
'@ -ForceWrite:$Force

Write-File 'src/css/components/forms.css' @'
.contact-form {
  display: grid;
  gap: 1rem;
  padding: 1.4rem;
  border-radius: var(--radius-md);
  border: 1px solid var(--line);
  background: linear-gradient(180deg, var(--form-bg-1), var(--form-bg-2));
  box-shadow: var(--shadow);
}

.contact-form label {
  display: grid;
  gap: 0.45rem;
  color: var(--text);
  font-weight: 600;
}

.contact-form input,
.contact-form textarea {
  width: 100%;
  padding: 0.95rem 1rem;
  border-radius: 12px;
  border: 1px solid var(--line);
  background: var(--input-bg);
  color: var(--text);
  transition: border-color 0.2s ease, box-shadow 0.2s ease, background 0.2s ease;
}

.contact-form input:focus,
.contact-form textarea:focus {
  outline: none;
  border-color: var(--input-focus-line);
  box-shadow: 0 0 0 4px var(--input-focus-ring);
}

.contact-form textarea {
  min-height: 160px;
  resize: vertical;
}
'@ -ForceWrite:$Force

Write-File 'src/css/utilities/utilities.css' @'
.center {
  text-align: center;
}

.muted {
  color: var(--text-soft);
}

.hidden {
  display: none !important;
}
'@ -ForceWrite:$Force

Write-File 'src/css/animations/animations.css' @'
.reveal {
  opacity: 0;
  transform: translateY(24px);
  transition: opacity 0.7s ease, transform 0.7s ease;
}

.reveal.is-visible {
  opacity: 1;
  transform: translateY(0);
}

.rotating-text {
  display: inline-grid;
  position: relative;
  min-width: 12ch;
  margin-left: 0.35rem;
  vertical-align: bottom;
}

.rotating-text > span {
  grid-area: 1 / 1;
  opacity: 0;
  transform: translateY(10px);
  transition: opacity 0.35s ease, transform 0.35s ease;
  color: var(--accent-2);
}

.rotating-text > span.is-visible {
  opacity: 1;
  transform: translateY(0);
}
'@ -ForceWrite:$Force

Write-File 'src/js/main.js' @'
import { injectHeader } from "./components/header.js";
import { injectFooter } from "./components/footer.js";
import { initReveal } from "./modules/reveal.js";
import { initRotatingText } from "./modules/rotatingText.js";
import { initProjects } from "./modules/projects.js";
import { initFilters } from "./modules/filters.js";
import { initEffects } from "./modules/effects.js";

document.documentElement.dataset.theme = "copper-tech";

document.addEventListener("DOMContentLoaded", async () => {
  injectHeader();
  injectFooter();
  initReveal();
  initRotatingText();
  await initProjects();
  initFilters();
  initEffects();
});
'@ -ForceWrite:$Force

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
}
'@ -ForceWrite:$Force

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
'@ -ForceWrite:$Force

Write-File 'src/js/modules/reveal.js' @'
export function initReveal() {
  const items = document.querySelectorAll(".reveal");
  if (!items.length) return;

  const observer = new IntersectionObserver((entries) => {
    entries.forEach((entry) => {
      if (entry.isIntersecting) {
        entry.target.classList.add("is-visible");
      }
    });
  }, { threshold: 0.15 });

  items.forEach((item) => observer.observe(item));
}
'@ -ForceWrite:$Force

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
'@ -ForceWrite:$Force

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
'@ -ForceWrite:$Force

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
'@ -ForceWrite:$Force

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
'@ -ForceWrite:$Force

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
'@ -ForceWrite:$Force

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
'@ -ForceWrite:$Force

Write-File 'index.html' @'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>All Pervading Web</title>
  <link rel="stylesheet" href="/src/css/main.css">
</head>
<body>
  <div class="site-shell">
    <div id="header-placeholder"></div>

    <main class="hero">
      <div class="container hero__layout">
        <section class="hero__panel reveal">
          <div class="eyebrow">Web Development</div>
          <h1>All Pervading Web builds modern websites and future-facing interfaces.</h1>
          <p>Developer portfolio, client work, experiments, and thoughtful web craftsmanship.</p>

          <div class="hero-buttons">
            <a class="btn btn--primary" href="/projects.html">View Projects</a>
            <a class="btn btn--secondary" href="/contact.html">Contact</a>
          </div>

          <div class="metrics">
            <div class="metric">
              <strong>Fast</strong>
              <span class="muted">Performance-first builds</span>
            </div>
            <div class="metric">
              <strong>Modern</strong>
              <span class="muted">Responsive, scalable UI</span>
            </div>
            <div class="metric">
              <strong>Thoughtful</strong>
              <span class="muted">Clean structure and UX</span>
            </div>
          </div>
        </section>

        <div class="mockup reveal"></div>
      </div>
    </main>

    <div id="footer-placeholder"></div>
  </div>

  <script type="module" src="/src/js/main.js"></script>
</body>
</html>
'@ -ForceWrite:$Force

Write-File 'projects.html' @'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Projects | All Pervading Web</title>
  <link rel="stylesheet" href="/src/css/main.css">
</head>
<body>
  <div class="site-shell">
    <div id="header-placeholder"></div>

    <section class="page-hero reveal">
      <div class="eyebrow">Projects</div>
      <h1>Selected projects and case studies.</h1>
      <p>Websites, interface concepts, and development experiments.</p>
    </section>

    <section class="section">
      <div class="container">
        <div class="project-filter">
          <button class="active" data-filter="all">All</button>
          <button data-filter="business">Business</button>
          <button data-filter="ecommerce">Ecommerce</button>
          <button data-filter="experimental">Experimental</button>
        </div>

        <div class="project-grid" id="project-grid"></div>
      </div>
    </section>

    <div id="footer-placeholder"></div>
  </div>

  <script type="module" src="/src/js/main.js"></script>
</body>
</html>
'@ -ForceWrite:$Force

Write-File 'services.html' @'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Services | All Pervading Web</title>
  <link rel="stylesheet" href="/src/css/main.css">
</head>
<body>
  <div class="site-shell">
    <div id="header-placeholder"></div>

    <section class="page-hero reveal">
      <div class="eyebrow">Services</div>
      <h1>What I build.</h1>
      <p>Modern websites, landing pages, interface refreshes, and front-end development support.</p>
    </section>

    <section class="section">
      <div class="container service-grid">
        <article class="service-card reveal">
          <h3>Business Websites</h3>
          <p>Clear, responsive websites that make your business easy to understand and contact.</p>
        </article>
        <article class="service-card reveal">
          <h3>Portfolio Sites</h3>
          <p>Custom portfolios for creators, developers, and professionals who want a stronger web presence.</p>
        </article>
        <article class="service-card reveal">
          <h3>UI Experiments</h3>
          <p>Future-facing concepts, motion studies, and interface prototypes for new ideas.</p>
        </article>
      </div>
    </section>

    <div id="footer-placeholder"></div>
  </div>

  <script type="module" src="/src/js/main.js"></script>
</body>
</html>
'@ -ForceWrite:$Force

Write-File 'experiments.html' @'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Experiments | All Pervading Web</title>
  <link rel="stylesheet" href="/src/css/main.css">
</head>
<body>
  <div class="site-shell">
    <div id="header-placeholder"></div>

    <section class="page-hero reveal">
      <div class="eyebrow">Experiments</div>
      <h1>UI concepts and exploratory builds.</h1>
      <p>Motion, spatial layout, interface ideas, and front-end studies.</p>
    </section>

    <section class="section">
      <div class="container grid-3">
        <article class="info-card reveal">
          <h3>Motion Systems</h3>
          <p>Subtle animation patterns and interaction experiments.</p>
        </article>
        <article class="info-card reveal">
          <h3>3D Interface Ideas</h3>
          <p>Exploring layered depth and future-facing layouts.</p>
        </article>
        <article class="info-card reveal">
          <h3>Visual Language</h3>
          <p>Brand systems, color studies, and component exploration.</p>
        </article>
      </div>
    </section>

    <div id="footer-placeholder"></div>
  </div>

  <script type="module" src="/src/js/main.js"></script>
</body>
</html>
'@ -ForceWrite:$Force

Write-File 'articles.html' @'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Articles | All Pervading Web</title>
  <link rel="stylesheet" href="/src/css/main.css">
</head>
<body>
  <div class="site-shell">
    <div id="header-placeholder"></div>

    <section class="page-hero reveal">
      <div class="eyebrow">Articles</div>
      <h1>Notes on web design, performance, and development.</h1>
      <p>Practical writing and observations from the build process.</p>
    </section>

    <section class="section">
      <div class="container article-grid">
        <a class="article-card reveal" href="/articles/seo-for-local-business.html">
          <div class="article-category">SEO</div>
          <h3>SEO for Local Businesses</h3>
          <p>How thoughtful structure, speed, and content improve search visibility.</p>
        </a>
        <a class="article-card reveal" href="/articles/why-performance-matters.html">
          <div class="article-category">Performance</div>
          <h3>Why Performance Still Matters</h3>
          <p>Fast sites rank better, convert better, and simply feel better.</p>
        </a>
      </div>
    </section>

    <div id="footer-placeholder"></div>
  </div>

  <script type="module" src="/src/js/main.js"></script>
</body>
</html>
'@ -ForceWrite:$Force

Write-File 'contact.html' @'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Contact | All Pervading Web</title>
  <link rel="stylesheet" href="/src/css/main.css">
</head>
<body>
  <div class="site-shell">
    <div id="header-placeholder"></div>

    <section class="page-hero reveal">
      <div class="eyebrow">Contact</div>
      <h1>Let’s build something useful.</h1>
      <p>Tell me about your site, idea, redesign, or experiment.</p>
    </section>

    <section class="section">
      <div class="container contact-layout">
        <div class="info-card reveal">
          <h3>Reach Out</h3>
          <p>I’m available for web projects, front-end builds, and thoughtful UI work.</p>
        </div>

        <form class="contact-form reveal">
          <label>
            Name
            <input type="text" name="name" placeholder="Your name">
          </label>

          <label>
            Email
            <input type="email" name="email" placeholder="you@example.com">
          </label>

          <label>
            Message
            <textarea name="message" placeholder="Tell me about your project"></textarea>
          </label>

          <button class="btn btn--primary" type="submit">Send Message</button>
        </form>
      </div>
    </section>

    <div id="footer-placeholder"></div>
  </div>

  <script type="module" src="/src/js/main.js"></script>
</body>
</html>
'@ -ForceWrite:$Force

Write-File 'projects/restaurant-website.html' @'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Restaurant Website</title>
  <link rel="stylesheet" href="/src/css/main.css">
</head>
<body>
  <div class="site-shell">
    <div id="header-placeholder"></div>

    <section class="page-hero reveal">
      <div class="eyebrow">Case Study</div>
      <h1>Restaurant Website</h1>
      <p>A mobile-first business website focused on fast access to menus, hours, and contact details.</p>
    </section>

    <section class="section">
      <div class="container">
        <div class="mockup reveal"></div>
      </div>
    </section>

    <div id="footer-placeholder"></div>
  </div>

  <script type="module" src="/src/js/main.js"></script>
</body>
</html>
'@ -ForceWrite:$Force

Write-File 'projects/ecommerce-store.html' @'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Ecommerce Store</title>
  <link rel="stylesheet" href="/src/css/main.css">
</head>
<body>
  <div class="site-shell">
    <div id="header-placeholder"></div>

    <section class="page-hero reveal">
      <div class="eyebrow">Case Study</div>
      <h1>Ecommerce Store</h1>
      <p>A storefront concept built around speed, clarity, and a more premium browsing experience.</p>
    </section>

    <section class="section">
      <div class="container">
        <div class="mockup reveal"></div>
      </div>
    </section>

    <div id="footer-placeholder"></div>
  </div>

  <script type="module" src="/src/js/main.js"></script>
</body>
</html>
'@ -ForceWrite:$Force

Write-File 'projects/webgl-interface.html' @'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>WebGL Interface</title>
  <link rel="stylesheet" href="/src/css/main.css">
</head>
<body>
  <div class="site-shell">
    <div id="header-placeholder"></div>

    <section class="page-hero reveal">
      <div class="eyebrow">Case Study</div>
      <h1>WebGL Interface</h1>
      <p>An experimental concept exploring layered motion, spatial depth, and future-facing interface ideas.</p>
    </section>

    <section class="section">
      <div class="container">
        <div class="mockup reveal"></div>
      </div>
    </section>

    <div id="footer-placeholder"></div>
  </div>

  <script type="module" src="/src/js/main.js"></script>
</body>
</html>
'@ -ForceWrite:$Force

Write-File 'articles/seo-for-local-business.html' @'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>SEO for Local Businesses</title>
  <link rel="stylesheet" href="/src/css/main.css">
</head>
<body>
  <div class="site-shell">
    <div id="header-placeholder"></div>

    <section class="page-hero reveal">
      <div class="eyebrow">Article</div>
      <h1>SEO for Local Businesses</h1>
      <p>Simple improvements in structure, speed, and content can make a noticeable difference.</p>
    </section>

    <div id="footer-placeholder"></div>
  </div>

  <script type="module" src="/src/js/main.js"></script>
</body>
</html>
'@ -ForceWrite:$Force

Write-File 'articles/why-performance-matters.html' @'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Why Performance Still Matters</title>
  <link rel="stylesheet" href="/src/css/main.css">
</head>
<body>
  <div class="site-shell">
    <div id="header-placeholder"></div>

    <section class="page-hero reveal">
      <div class="eyebrow">Article</div>
      <h1>Why Performance Still Matters</h1>
      <p>Beautiful websites still need to be fast, especially on mobile connections.</p>
    </section>

    <div id="footer-placeholder"></div>
  </div>

  <script type="module" src="/src/js/main.js"></script>
</body>
</html>
'@ -ForceWrite:$Force

Write-Host ""
Write-Host "Project bootstrap complete in: $root" -ForegroundColor Green
Write-Host ""

if ($Force) {
  Write-Host "Overwrite mode was used." -ForegroundColor Red
} else {
  Write-Host "Existing files were protected. Use -Force only if you intentionally want to overwrite them." -ForegroundColor Cyan
}

Write-Host ""
Write-Host "Next:" -ForegroundColor Cyan
Write-Host "  npm install"
Write-Host "  npm run dev"
Write-Host ""
Write-Host "Optional Git steps:" -ForegroundColor Cyan
Write-Host "  git add ."
Write-Host "  git commit -m 'Update All Pervading Web bootstrap script'"
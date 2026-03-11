export function injectHeader() {
  const target = document.getElementById("header-placeholder");
  if (!target) return;

  const current = window.location.pathname.split("/").pop() || "index.html";

  target.innerHTML = `
    <header class="site-header">
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
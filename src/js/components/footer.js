export function injectFooter() {
  const target = document.getElementById("footer-placeholder");
  if (!target) return;

  target.innerHTML = `
    <footer class="site-footer">
      <div class="site-footer__inner">
        <p>&copy; All Pervading Web</p>
        <p>Modern websites, web applications, and future-facing UI experiments.</p>
      </div>
    </footer>
  `;
}
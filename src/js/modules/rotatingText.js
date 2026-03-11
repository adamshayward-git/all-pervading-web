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
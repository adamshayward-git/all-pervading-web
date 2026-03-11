function createArticleCard(article) {
  const card = document.createElement("a");
  card.className = "article-card reveal";
  card.href = article.link;

  card.innerHTML = `
    <span class="article-category">${article.category}</span>
    <h3>${article.title}</h3>
    <p>${article.description}</p>
    <div class="article-card__meta">
      <span>Read article</span>
    </div>
  `;

  return card;
}

export async function initArticles() {
  const grid = document.getElementById("article-grid");
  if (!grid) return;

  try {
    const res = await fetch("/data/articles.json");
    const articles = await res.json();

    grid.innerHTML = "";
    articles.forEach((article) => {
      grid.appendChild(createArticleCard(article));
    });

    document.querySelectorAll(".article-card.reveal").forEach((item) => {
      requestAnimationFrame(() => item.classList.add("is-visible"));
    });
  } catch (error) {
    grid.innerHTML = "<p>Unable to load articles right now.</p>";
    console.error(error);
  }
}
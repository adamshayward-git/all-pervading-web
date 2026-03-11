function createProjectCard(project) {
  const article = document.createElement("a");
  article.className = "project-card reveal";
  article.href = project.link;
  article.dataset.category = project.category;

  article.innerHTML = `
    <div class="project-image">
      <img src="${project.image}" alt="${project.title}">
    </div>

    <span class="card-tag">${project.category}</span>

    <h3>${project.title}</h3>

    <p>${project.description}</p>

    <div class="project-card__meta">
      <span>${project.stack.join(" • ")}</span>
      <span>View Case Study →</span>
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
"use strict";

const filterPanel = document.querySelector("[data-filter-panel]");
const filterInput = document.querySelector("#module-filter");
const filterStatus = document.querySelector("#filter-status");
const clearButton = document.querySelector("[data-filter-clear]");
const emptyState = document.querySelector("[data-empty-state]");
const moduleGroups = Array.from(document.querySelectorAll("[data-module-group]"));
const moduleItems = Array.from(document.querySelectorAll("[data-module-item]"));

const normalize = (value) => value.toLowerCase().replaceAll("_", " ").trim();

if (filterPanel && filterInput && filterStatus && clearButton && emptyState) {
  filterPanel.hidden = false;

  const applyFilter = () => {
    const query = normalize(filterInput.value);
    let visibleCount = 0;

    moduleGroups.forEach((group) => {
      const category = normalize(group.dataset.category || "");
      const items = Array.from(group.querySelectorAll("[data-module-item]"));
      let groupCount = 0;

      items.forEach((item) => {
        const searchable = `${category} ${normalize(item.textContent || "")}`;
        const matches = !query || searchable.includes(query);
        item.hidden = !matches;
        if (matches) {
          groupCount += 1;
          visibleCount += 1;
        }
      });

      group.hidden = groupCount === 0;
    });

    filterStatus.textContent = `${visibleCount} ${visibleCount === 1 ? "module" : "modules"} shown`;
    emptyState.hidden = visibleCount !== 0;
    clearButton.disabled = filterInput.value.length === 0;
  };

  filterInput.addEventListener("input", applyFilter);
  clearButton.addEventListener("click", () => {
    filterInput.value = "";
    applyFilter();
    filterInput.focus();
  });
  applyFilter();
}

const liveRegion = document.createElement("div");
liveRegion.className = "visually-hidden";
liveRegion.setAttribute("role", "status");
liveRegion.setAttribute("aria-live", "polite");
liveRegion.setAttribute("aria-atomic", "true");
document.body.append(liveRegion);

document.querySelectorAll("[data-copy]").forEach((frame) => {
  const code = frame.querySelector("code");
  if (!code || !navigator.clipboard) {
    return;
  }

  const button = document.createElement("button");
  button.className = "copy-button";
  button.type = "button";
  button.textContent = "Copy";
  button.setAttribute("aria-label", "Copy Terraform example");

  button.addEventListener("click", async () => {
    try {
      await navigator.clipboard.writeText(code.textContent || "");
      button.textContent = "Copied";
      liveRegion.textContent = "Terraform example copied to clipboard.";
      window.setTimeout(() => {
        button.textContent = "Copy";
      }, 1800);
    } catch {
      liveRegion.textContent = "Copy failed. Select the code and copy it manually.";
    }
  });

  frame.append(button);
});

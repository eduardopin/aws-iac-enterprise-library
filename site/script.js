"use strict";

const filterPanel = document.querySelector("[data-filter-panel]");
const filterInput = document.querySelector("#module-filter");
const filterStatus = document.querySelector("#filter-status");
const clearButton = document.querySelector("[data-filter-clear]");
const emptyState = document.querySelector("[data-empty-state]");
const moduleGroups = Array.from(document.querySelectorAll("[data-module-group]"));
const moduleItems = Array.from(document.querySelectorAll("[data-module-item]"));

const normalize = (value) => value.toLowerCase().replace(/[_-]+/g, " ").replace(/\s+/g, " ").trim();

const matchesFilter = (moduleName, categoryName, query) => {
  const normalizedQuery = normalize(query);
  const searchable = `${normalize(moduleName)} ${normalize(categoryName)}`;
  return !normalizedQuery || searchable.includes(normalizedQuery);
};

if (filterPanel && filterInput && filterStatus && clearButton && emptyState) {
  filterPanel.hidden = false;

  const applyFilter = () => {
    const query = normalize(filterInput.value);
    let visibleCount = 0;

    moduleGroups.forEach((group) => {
      const category = group.dataset.category || "";
      const items = Array.from(group.querySelectorAll("[data-module-item]"));
      let groupCount = 0;

      items.forEach((item) => {
        const moduleName = item.querySelector("code")?.textContent || "";
        const matches = matchesFilter(moduleName, category, query);
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

// InstallSnippet copy button: rest "Copy", success "Copied" for 1.8s, failure "Select text" with the block selected.
const copyStatus = document.querySelector("#copy-status");

const selectContents = (element) => {
  const range = document.createRange();
  range.selectNodeContents(element);
  const selection = window.getSelection();
  selection?.removeAllRanges();
  selection?.addRange(range);
};

document.querySelectorAll("[data-copy]").forEach((frame) => {
  const code = frame.querySelector("code");
  const button = frame.querySelector(".po-copy");
  if (!code || !button) {
    return;
  }
  let resetTimer = 0;
  button.hidden = false;

  const announce = (message) => {
    if (copyStatus) {
      copyStatus.textContent = message;
    }
  };

  button.addEventListener("click", async () => {
    window.clearTimeout(resetTimer);
    try {
      if (!navigator.clipboard) {
        throw new Error("Clipboard API unavailable");
      }
      await navigator.clipboard.writeText(code.textContent || "");
      button.textContent = "Copied";
      button.dataset.state = "copied";
      announce("Command copied.");
      resetTimer = window.setTimeout(() => {
        button.textContent = "Copy";
        delete button.dataset.state;
      }, 1800);
    } catch {
      button.textContent = "Select text";
      button.dataset.state = "failed";
      selectContents(code);
      announce("Copy unavailable; command selected.");
    }
  });
});

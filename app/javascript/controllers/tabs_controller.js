import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["tabContent"];

  connect() {
    const urlParams = new URLSearchParams(window.location.search);
    const tab = urlParams.get("tab");
    if (tab) {
      this.showTab(tab);
    } else {
      this.showTab("profile");
      window.history.pushState(null, "", "?tab=profile");
    }
  }

  showTab(tab) {
    this.tabContentTargets.forEach((content) => {
      content.classList.toggle("hidden", content.id !== tab);
    });

    this.element.querySelectorAll("[data-tab]").forEach((link) => {
      link.classList.toggle("active", link.dataset.tab === tab);
      link.classList.toggle("border", link.dataset.tab === tab);
      link.classList.toggle("rounded-full", link.dataset.tab === tab);
      link.classList.toggle("text-indigo-900", link.dataset.tab === tab);
    });
  }

  changeTab(event) {
    event.preventDefault();
    const tab = event.currentTarget.dataset.tab;
    this.showTab(tab);
    window.history.pushState(null, "", `?tab=${tab}`);
  }
}

let dataLinks = document.querySelectorAll('tr[data-link]')

dataLinks.forEach(element => element.addEventListener("click", function () {
    window.location = this.dataset.link
}));

document.addEventListener("DOMContentLoaded", function () {
    const toggle = document.querySelector('.menu-toggle');
    const nav = document.querySelector('.nav-links'); // ✅ now works

    if (toggle && nav) {
        toggle.addEventListener('click', function () {
            nav.classList.toggle('show');
        });
    }

    document.querySelectorAll('.scroll-link').forEach(link => {
        link.addEventListener('click', function (e) {
            e.preventDefault();
            const targetId = this.getAttribute('href');
            const targetElement = document.querySelector(targetId);

            if (targetElement) {
                targetElement.scrollIntoView({
                    behavior: "smooth",
                    block: "start"
                });
            }

            nav.classList.remove('show');
        });
    });
});

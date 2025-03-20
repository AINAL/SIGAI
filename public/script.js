document.addEventListener("DOMContentLoaded", function () {
    // Smooth Scroll for Navigation Links
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

            // Close the mobile menu after clicking a link (for mobile users)
            document.querySelector('.nav-links').classList.remove('nav-active');
        });
    });

    // Toggle mobile menu
    document.querySelector('.menu-toggle').addEventListener('click', function () {
        document.querySelector('.nav-links').classList.toggle('nav-active');
    });
});

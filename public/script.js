document.addEventListener("DOMContentLoaded", function () {
    const toggle = document.querySelector('.menu-toggle');
    const nav = document.querySelector('.nav-links');

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

    // 🎠 Fixed Centering & Move by 2 Images with Accurate Width
    const track = document.querySelector('.carousel-track');
    const btnLeft = document.querySelector('.carousel-btn.left');
    const btnRight = document.querySelector('.carousel-btn.right');
    const items = document.querySelectorAll('.carousel-item');

    let index = 0;
    const imagesPerView = 2;
    const totalItems = items.length;

    function getItemFullWidth() {
        const item = items[0];
        const style = getComputedStyle(item);
        const width = item.offsetWidth;
        const gap = parseFloat(getComputedStyle(track).gap || 0);
        return width + gap;
    }

    function updateCarousel() {
        const fullWidth = getItemFullWidth();
        track.style.transform = `translateX(-${index * fullWidth}px)`;
    }

    btnLeft.addEventListener('click', () => {
        index -= imagesPerView;
        if (index < 0) index = 0;
        updateCarousel();
    });

    btnRight.addEventListener('click', () => {
        const maxIndex = totalItems - imagesPerView;
        index += imagesPerView;
        if (index > maxIndex) index = maxIndex;
        updateCarousel();
    });

    window.addEventListener('resize', updateCarousel);
    updateCarousel();

    // 📸 Zoom Function
    const zoomOverlay = document.querySelector('.fullscreen-overlay');
    const zoomImage = document.getElementById('zoomed-image');
    const closeZoom = document.querySelector('.close-zoom');

    document.querySelectorAll('.zoom-img').forEach(img => {
        img.addEventListener('click', () => {
            zoomImage.src = img.src;
            zoomOverlay.style.display = "flex";
        });
    });

    closeZoom.addEventListener('click', () => {
        zoomOverlay.style.display = "none";
    });

    zoomOverlay.addEventListener('click', (e) => {
        if (e.target === zoomOverlay) {
            zoomOverlay.style.display = "none";
        }
    });
});

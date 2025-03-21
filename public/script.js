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
            const targetId = this.getAttribute('href') || this.getAttribute('data-target');
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

    // 🎠 Infinite Loop Carousel
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
        track.style.transition = "transform 0.4s ease-in-out";
        track.style.transform = `translateX(-${index * fullWidth}px)`;
    }

    btnLeft.addEventListener('click', () => {
        if (index === 0) {
            index = totalItems - imagesPerView;
            track.style.transition = "none"; // Remove animation for instant reset
            track.style.transform = `translateX(-${index * getItemFullWidth()}px)`;
            setTimeout(() => {
                track.style.transition = "transform 0.4s ease-in-out";
                index -= imagesPerView;
                updateCarousel();
            }, 50);
        } else {
            index -= imagesPerView;
            updateCarousel();
        }
    });

    btnRight.addEventListener('click', () => {
        if (index >= totalItems - imagesPerView) {
            index = 0;
            track.style.transition = "none";
            track.style.transform = `translateX(0)`;
            setTimeout(() => {
                track.style.transition = "transform 0.4s ease-in-out";
                index += imagesPerView;
                updateCarousel();
            }, 50);
        } else {
            index += imagesPerView;
            updateCarousel();
        }
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

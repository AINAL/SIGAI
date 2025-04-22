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

// 🖼️ Screenshot Carousel (2 per view, loop without empty space)
const track = document.querySelector('.carousel-track');
const btnLeft = document.querySelector('.carousel-btn.left');
const btnRight = document.querySelector('.carousel-btn.right');
const items = document.querySelectorAll('.carousel-item');

let index = 0;
const itemsPerView = 2;

function getItemWidth() {
  return items[0].offsetWidth + 16; // 16px = approx gap
}

function updateCarousel() {
  const shift = index * getItemWidth();
  track.style.transition = "transform 0.4s ease-in-out";
  track.style.transform = `translateX(-${shift}px)`;
}

function getMaxIndex() {
  // prevent scrolling to last "incomplete" view
  return items.length - itemsPerView - 5;
}

btnRight.addEventListener('click', () => {
  index = index >= getMaxIndex() ? 0 : index + itemsPerView;
  updateCarousel();
});

btnLeft.addEventListener('click', () => {
  index = index <= 0 ? getMaxIndex() : index - itemsPerView;
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

	// 🎞️ Video Carousel (1 per view, loop)
const videoTrack = document.querySelector('.video-track');
const videoItems = document.querySelectorAll('.video-item');
const videoBtnLeft = document.querySelector('.carousel-btn.left.video-btn');
const videoBtnRight = document.querySelector('.carousel-btn.right.video-btn');

let videoIndex = 0;

function updateVideoCarousel() {
  const itemWidth = videoItems[0].offsetWidth + 16; // include margin
  videoTrack.style.transform = `translateX(-${videoIndex * itemWidth}px)`;
}

videoBtnLeft.addEventListener('click', () => {
  videoIndex = (videoIndex - 1 + videoItems.length) % videoItems.length;
  updateVideoCarousel();
});

videoBtnRight.addEventListener('click', () => {
  videoIndex = (videoIndex + 1) % videoItems.length;
  updateVideoCarousel();
});

window.addEventListener('resize', updateVideoCarousel);
updateVideoCarousel();

// ▶️ Video Modal Popup
const videoOverlay = document.getElementById('videoOverlay');
const videoContainer = document.getElementById('videoContainer');
const closeVideoBtn = document.querySelector('.close-video');

document.querySelectorAll('.video-item').forEach(item => {
  item.addEventListener('click', () => {
    const type = item.dataset.type;
    const id = item.dataset.id;
    const src = item.dataset.src;
    videoContainer.innerHTML = '';

    if (type === 'youtube') {
      const iframe = document.createElement('iframe');
      iframe.src = `https://www.youtube.com/embed/${id}?autoplay=1`;
      iframe.frameBorder = 0;
      iframe.allow = "accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture";
      iframe.allowFullscreen = true;
      iframe.width = "100%";
      iframe.height = "100%";
      videoContainer.appendChild(iframe);
    } else if (type === 'local') {
      const video = document.createElement('video');
      video.src = src;
      video.controls = true;
      video.autoplay = true;
      video.style.width = '100%';
      video.style.height = '100%';
      videoContainer.appendChild(video);
    }

    videoOverlay.style.display = 'flex';
  });
});

closeVideoBtn.addEventListener('click', () => {
  videoOverlay.style.display = 'none';
  videoContainer.innerHTML = '';
});

videoOverlay.addEventListener('click', e => {
  if (e.target === videoOverlay) {
    videoOverlay.style.display = 'none';
    videoContainer.innerHTML = '';
  }
});

// Scroll-Reveal for Timeline Entries
const revealElements = document.querySelectorAll('[data-reveal]');
const revealObserver = new IntersectionObserver((entries, observer) => {
  entries.forEach(entry => {
    if (entry.isIntersecting) {
      entry.target.classList.add('active');
      observer.unobserve(entry.target);
    }
  });
}, { threshold: 0.1 });

revealElements.forEach(el => revealObserver.observe(el));

});

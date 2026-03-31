/**
 * Awwwards-Level Interactions
 * "The Poetic Layer"
 *
 * Features:
 * 1. Lenis Smooth Scroll
 * 2. Custom Magnetic Cursor
 * 3. Text & Image Reveal Animations
 */

// --- 1. Lenis Smooth Scroll ---
const initSmoothScroll = () => {
  if (typeof Lenis === "undefined") return;

  const lenis = new Lenis({
    duration: 1.2,
    easing: (t) => Math.min(1, 1.001 - Math.pow(2, -10 * t)),
    direction: "vertical",
    gestureDirection: "vertical",
    smooth: true,
    mouseMultiplier: 1,
    smoothTouch: false,
    touchMultiplier: 2,
  });

  function raf(time) {
    lenis.raf(time);
    requestAnimationFrame(raf);
  }

  requestAnimationFrame(raf);

  // Connect Lenis to ScrollTrigger if available
  // if (typeof ScrollTrigger !== 'undefined') {
  //     lenis.on('scroll', ScrollTrigger.update);
  //     gsap.ticker.add((time) => {
  //         lenis.raf(time * 1000);
  //     });
  //     gsap.ticker.lagSmoothing(0);
  // }

  console.log("Lenis Smooth Scroll Initialized");
};

// --- 2. Custom Cursor ---
const initCustomCursor = () => {
  // Only on desktop
  if (window.matchMedia("(max-width: 1024px)").matches) return;

  const cursorDot = document.createElement("div");
  cursorDot.className = "cursor-dot";

  const cursorOutline = document.createElement("div");
  cursorOutline.className = "cursor-outline";

  document.body.appendChild(cursorDot);
  document.body.appendChild(cursorOutline);

  window.addEventListener("mousemove", (e) => {
    const posX = e.clientX;
    const posY = e.clientY;

    // Dot follows instantly
    cursorDot.style.left = `${posX}px`;
    cursorDot.style.top = `${posY}px`;

    // Outline follows with lag
    cursorOutline.animate(
      {
        left: `${posX}px`,
        top: `${posY}px`,
      },
      { duration: 500, fill: "forwards" }
    );
  });

  // Hover effects
  const interactiveElements = document.querySelectorAll(
    'a, button, [role="button"], input, textarea, [data-annotation]'
  );

  interactiveElements.forEach((el) => {
    el.addEventListener("mouseenter", () => {
      document.body.classList.add("hovering");
      // Magnetic effect could go here
    });

    el.addEventListener("mouseleave", () => {
      document.body.classList.remove("hovering");
    });
  });

  console.log("Custom Cursor Initialized");
};

// --- 3. Reveal Animations ---
const initRevealAnimations = () => {
  const observerOptions = {
    threshold: 0.15,
    rootMargin: "0px",
  };

  const observer = new IntersectionObserver((entries) => {
    entries.forEach((entry) => {
      if (entry.isIntersecting) {
        entry.target.classList.add("is-visible");
        observer.unobserve(entry.target); // Only animate once
      }
    });
  }, observerOptions);

  // Text Reveals
  document.querySelectorAll("h1, h2, h3, p.hero-subtitle").forEach((el) => {
    el.classList.add("reveal-text");
    // Wrap content in span for animation
    const content = el.innerHTML;
    el.innerHTML = `<span>${content}</span>`;
    observer.observe(el);
  });

  // Image Reveals
  document
    .querySelectorAll(".card-media, .bio-image, .exhibition-card img")
    .forEach((el) => {
      // If it's an img directly, wrap it
      if (el.tagName === "IMG") {
        const wrapper = document.createElement("div");
        wrapper.className = "reveal-image";
        el.parentNode.insertBefore(wrapper, el);
        wrapper.appendChild(el);
        observer.observe(wrapper);
      } else {
        el.classList.add("reveal-image");
        observer.observe(el);
      }
    });

  console.log("Reveal Animations Initialized");
};

// Initialize All
document.addEventListener("DOMContentLoaded", () => {
  // Load Lenis Script dynamically if not present
  if (typeof Lenis === "undefined") {
    const script = document.createElement("script");
    script.src =
      "https://cdn.jsdelivr.net/gh/studio-freight/lenis@1.0.29/bundled/lenis.min.js";
    script.onload = () => {
      initSmoothScroll();
    };
    document.head.appendChild(script);
  } else {
    initSmoothScroll();
  }

  initCustomCursor();
  initRevealAnimations();
});

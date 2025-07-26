/*
==========================================================================
  AWARD-WINNING PORTFOLIO - CURSOR CONTROLLER v1.0
  This module creates a custom cursor and handles advanced hover
  and magnetic effects for a premium, tactile user experience.
==========================================================================
*/

class CursorController {
  constructor() {
    this.cursor = {
      el: null,
      pos: { x: 0, y: 0 },
      mouse: { x: 0, y: 0 },
      speed: 0.1, // Lower is slower/smoother
    };

    this.magneticElements = [];

    // Don't initialize on touch devices
    if ("ontouchstart" in window) {
      return;
    }

    this.init();
  }

  init() {
    this.createCursorElement();
    this.findAllMagneticElements();
    this.bindEvents();
    this.animate();
    console.log('✨ Cursor Controller initialized.');
  }

  createCursorElement() {
    this.cursor.el = document.createElement('div');
    this.cursor.el.className = 'custom-cursor';
    document.body.appendChild(this.cursor.el);
  }

  findAllMagneticElements() {
    this.magneticElements = document.querySelectorAll('[data-magnetic]');
  }

  bindEvents() {
    // Update mouse position
    window.addEventListener('mousemove', (e) => {
      this.cursor.mouse.x = e.clientX;
      this.cursor.mouse.y = e.clientY;
    });

    // Handle magnetic elements
    this.magneticElements.forEach(el => {
      el.addEventListener('mouseenter', (e) => this.handleMagneticEnter(e, el));
      el.addEventListener('mouseleave', (e) => this.handleMagneticLeave(e, el));
    });

    // Handle standard hover growth
    document.querySelectorAll('a, button, .project-card').forEach(el => {
      el.addEventListener('mouseenter', () => this.cursor.el.classList.add('grow'));
      el.addEventListener('mouseleave', () => this.cursor.el.classList.remove('grow'));
    });
  }

  handleMagneticEnter(e, el) {
    gsap.to(el, { duration: 0.4, ease: 'power3.out', x: (e.offsetX - el.offsetWidth / 2) * 0.3, y: (e.offsetY - el.offsetHeight / 2) * 0.3 });
  }

  handleMagneticLeave(e, el) {
    gsap.to(el, { duration: 0.6, ease: 'elastic.out(1, 0.3)', x: 0, y: 0 });
  }

  // This runs on every frame for smooth animation
  animate() {
    // "Lerp" (linear interpolation) for smooth cursor following
    this.cursor.pos.x += (this.cursor.mouse.x - this.cursor.pos.x) * this.cursor.speed;
    this.cursor.pos.y += (this.cursor.mouse.y - this.cursor.pos.y) * this.cursor.speed;
    
    // Apply the position to the cursor element
    this.cursor.el.style.transform = `translate3d(${this.cursor.pos.x}px, ${this.cursor.pos.y}px, 0)`;
    
    // Keep the animation loop going
    requestAnimationFrame(() => this.animate());
  }
}
/*
==========================================================================
  AWARD-WINNING PORTFOLIO - SCROLL CONTROLLER
  This module uses GSAP (GreenSock Animation Platform) to handle all
  scroll-based animations and the main entrance sequence.
==========================================================================
*/

class ScrollController {
  constructor() {
    // Register GSAP plugins
    gsap.registerPlugin(ScrollTrigger, ScrollToPlugin);
    
    // Timelines allow us to chain animations
    this.heroTimeline = gsap.timeline({ paused: true });

    this.init();
  }

  init() {
    this.setupHeroAnimation();
    this.setupScrollAnimations();
    console.log('🎬 ScrollController initialized.');
  }

  /**
   * Defines the master timeline for the hero section's entrance animation.
   * It starts in a paused state and will be played by main.js.
   */
  setupHeroAnimation() {
    // We target the individual lines of the title for a staggered effect
    this.heroTimeline
      .to(".hero-title .title-line", {
        y: "0%", // Animate to default position
        opacity: 1,
        duration: 1.2,
        ease: "power3.out",
        stagger: 0.1 // This animates each line 0.1s after the previous one
      })
      .to(".hero-subtitle", {
        opacity: 1,
        duration: 0.8,
        ease: "power2.out"
      }, "-=0.8") // The "-=0.8" starts this animation 0.8s before the previous one ends
      .to(".scroll-indicator", {
        opacity: 1,
        duration: 0.8,
        ease: "power2.out"
      }, "-=0.5");
  }

  /**
   * Sets up animations for elements that should appear as the user scrolls.
   */
  setupScrollAnimations() {
    // Use GSAP's utility to grab all elements we want to animate on scroll
    const animatedElements = gsap.utils.toArray([
      '.section-title',
      '.portfolio-filters',
      '.system-card',
      '.archive-content',
      '.connect-link'
    ]);

    animatedElements.forEach(element => {
      gsap.to(element, {
        opacity: 1,
        y: 0,
        duration: 0.8,
        ease: 'power2.out',
        scrollTrigger: {
          trigger: element,
          start: 'top 85%', // Animate when the top of the element is 85% from the top of the viewport
          toggleActions: 'play none none none', // Play the animation once and don't reverse it
        }
      });
    });
  }

  /**
   * Public method to be called by main.js to start the hero animation.
   */
  playHeroAnimation() {
    this.heroTimeline.play();
  }
}
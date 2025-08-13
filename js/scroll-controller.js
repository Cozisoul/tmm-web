/*
==========================================================================
  AWARD-WINNING PORTFOLIO - SCROLL CONTROLLER v2.0 (Awwwards Polish)
  This version implements cinematic text reveals and scroll-linked animations.
==========================================================================
*/

class ScrollController {
  constructor() {
    this.heroTimeline = null;
    this.init();
  }

  init() {
    if (typeof gsap === 'undefined') {
      console.error('GSAP not loaded.');
      return;
    }
    gsap.registerPlugin(ScrollTrigger, ScrollToPlugin);
    
    this.heroTimeline = gsap.timeline({ paused: true });

    // New: Run the text split before setting up animations
    AnimationUtils.splitTextIntoSpans('.hero-title');

    this.setupHeroAnimation();
    this.setupScrollAnimations();
    this.setupScrollLinkedAnimations(); // New
    console.log('🎬 ScrollController v2.0 initialized.');
  }

  setupHeroAnimation() {
    // Upgraded: Target the new .anim-word spans for a cinematic reveal
    this.heroTimeline
      .to(".hero-title .anim-word", {
        y: "0%",
        opacity: 1,
        duration: 1,
        ease: "power3.out",
        stagger: 0.1
      })
      .to(".hero-subtitle", {
        opacity: 1,
        duration: 0.8,
        ease: "power2.out"
      }, "-=0.8")
      .to(".scroll-indicator", {
        opacity: 1,
        duration: 0.8,
        ease: "power2.out"
      }, "-=0.5");
  }

  setupScrollAnimations() {
    const animatedElements = gsap.utils.toArray([
      '.section-title',
      '.portfolio-filters',
      '.system-card',
      '.archive-content',
      '.connect-link'
    ]);
    animatedElements.forEach(element => {
      gsap.fromTo(element,
        { y: 40, opacity: 0 },
        {
          y: 0,
          opacity: 1,
          duration: 0.8,
          ease: 'power2.out',
          scrollTrigger: {
            trigger: element,
            start: 'top 85%',
            toggleActions: 'play none none none',
          }
        }
      );
    });
  }

  // New: Add animations linked directly to scroll progress
  setupScrollLinkedAnimations() {
    gsap.to('.hero-content', {
      scrollTrigger: {
        trigger: '.hero',
        start: 'top top',
        end: 'bottom top',
        scrub: true // This links the animation directly to the scrollbar
      },
      opacity: 0,
      y: -100, // Move it up as it fades out
      ease: 'power1.in'
    });
  }

  playHeroAnimation() {
    if (this.heroTimeline) {
      this.heroTimeline.play();
    }
  }
}
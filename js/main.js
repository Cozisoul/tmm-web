/*
==========================================================================
  AWARD-WINNING PORTFOLIO - MAIN CONTROLLER (THE CONDUCTOR) - v1.1
  This file is the entry point for all JavaScript functionality.
==========================================================================
*/

class MainApp {
  constructor() {
    // We will select the loader element later, "just-in-time".
    this.body = document.body;
    
    // Initialize all modules
    this.themeController = new ThemeController();
    this.constellation = new ConstellationCanvas('constellationCanvas');
    this.scrollController = new ScrollController();
    this.portfolio = new PortfolioEngine();

    this.init();
  }

  init() {
    console.log('🚀 MainApp initialized. Preparing to launch.');
    this.initLoader();
  }

  initLoader() {
    // We listen for the window's 'load' event, which fires after all
    // content (including images, stylesheets) has been fully loaded.
    window.addEventListener('load', () => {
      // Use a short delay to prevent jarring transitions and ensure rendering is complete
      setTimeout(() => {
        this.removeLoader();
      }, 500);
    });
  }

  removeLoader() {
    // FIX APPLIED HERE: Select the loader element at the exact moment we need it.
    const loader = document.getElementById('loader');
    
    // Add a "guard clause" to prevent errors if the loader is somehow missing.
    if (!loader) {
      console.error('Loader element not found when trying to remove it.');
      this.body.classList.add('loaded'); // Still try to show the body
      this.startEntranceAnimations();
      return;
    }

    // Fade out the loader
    loader.style.opacity = '0';

    // When the fade-out transition is complete, remove it from the DOM
    loader.addEventListener('transitionend', () => {
      loader.remove();
    });
    
    // Add the 'loaded' class to the body to fade it in
    this.body.classList.add('loaded');

    this.startEntranceAnimations();
  }

  startEntranceAnimations() {
    console.log('🎬 Triggering hero entrance animation...');
    this.scrollController.playHeroAnimation(); 
  }
}

document.addEventListener('DOMContentLoaded', () => {
  const app = new MainApp();
});
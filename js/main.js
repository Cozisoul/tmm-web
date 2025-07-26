/*
==========================================================================
  AWARD-WINNING PORTFOLIO - MAIN CONTROLLER (THE CONDUCTOR)
==========================================================================
*/

class MainApp {
  constructor() {
    // ... (other initializations)
    this.themeController = new ThemeController();
    this.constellation = new ConstellationCanvas('constellationCanvas');
    this.scrollController = new ScrollController();
    this.portfolio = new PortfolioEngine(); // ACTIVATE THE PORTFOLIO ENGINE

    this.init();
  }

  init() {
    console.log('🚀 MainApp initialized. Preparing to launch.');
    this.initLoader();
  }

  initLoader() {
    window.addEventListener('load', () => {
      setTimeout(() => {
        this.removeLoader();
      }, 500);
    });
  }

  removeLoader() {
    this.loader.style.opacity = '0';
    this.loader.addEventListener('transitionend', () => {
      this.loader.remove();
    });
    
    this.body.classList.add('loaded');
    
    // The entrance animations are now handled by the ScrollController
    this.startEntranceAnimations(); 
  }

  startEntranceAnimations() {
    // Tell the ScrollController to play the hero timeline
    console.log('🎬 Triggering hero entrance animation...');
    this.scrollController.playHeroAnimation(); 
  }
}

document.addEventListener('DOMContentLoaded', () => {
  const app = new MainApp();
});
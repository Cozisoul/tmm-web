/*
==========================================================================
  AWARD-WINNING PORTFOLIO - MAIN CONTROLLER (THE CONDUCTOR) - v1.3
  This file is the entry point for all JavaScript functionality.
==========================================================================
*/

class MainApp {
  constructor() {
    this.body = document.body;
    
    // Initialize all modules
    this.themeController = new ThemeController();
    this.constellation = new ConstellationCanvas('constellationCanvas');
    this.scrollController = new ScrollController();
    this.cursorController = new CursorController();
    this.dataViz = new DataVisualization(); // INITIALIZE DATA-VIZ
    this.portfolio = new PortfolioEngine(this); // Pass main app instance to portfolio engine

    this.init();
  }

  init() {
    console.log('🚀 MainApp v1.3 initialized. Preparing to launch.');
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
    const loader = document.getElementById('loader');
    if (!loader) {
      console.error('Loader element not found when trying to remove it.');
      this.body.classList.add('loaded');
      this.startEntranceAnimations();
      return;
    }
    loader.style.opacity = '0';
    loader.addEventListener('transitionend', () => loader.remove());
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
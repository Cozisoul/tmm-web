/*
==========================================================================
  AWARD-WINNING PORTFOLIO - THEME CONTROLLER
  This module manages the "Systematic" <=> "Poetic" duality toggle.
  - Detects and applies user's saved preference from localStorage.
  - Updates the data-theme attribute on the <body>.
  - Dispatches a custom event when the theme changes so other
    JS modules (like the canvas animation) can react.
==========================================================================
*/

class ThemeController {
  constructor() {
    this.body = document.body;
    this.toggleButton = document.getElementById('dualityToggle');
    
    // Default to 'systematic' if no preference is saved
    this.currentTheme = localStorage.getItem('tm-theme') || 'systematic';

    if (!this.toggleButton) {
      console.error('Duality Toggle button not found!');
      return;
    }

    this.init();
  }

  init() {
    // Apply the initial theme as soon as the script loads
    this.applyTheme(this.currentTheme);

    // Set up the event listener for the toggle button
    this.toggleButton.addEventListener('click', () => this.toggle());
    
    console.log(`🎨 ThemeController initialized. Current theme: ${this.currentTheme}`);
  }

  /**
   * Toggles between 'systematic' and 'poetic' themes.
   */
  toggle() {
    const newTheme = this.currentTheme === 'systematic' ? 'poetic' : 'systematic';
    this.applyTheme(newTheme);
  }

  /**
   * Applies a specific theme to the site.
   * @param {string} theme - The name of the theme to apply ('systematic' or 'poetic').
   */
  applyTheme(theme) {
    // 1. Update the current theme state
    this.currentTheme = theme;

    // 2. Update the data-theme attribute on the body tag
    //    This is what triggers all the CSS variable changes.
    this.body.setAttribute('data-theme', theme);

    // 3. Save the user's preference for their next visit
    localStorage.setItem('tm-theme', theme);

    // 4. Dispatch a custom event so other modules can listen for changes
    //    This is crucial for decoupling our code.
    window.dispatchEvent(new CustomEvent('themeChanged', { 
      detail: { theme: this.currentTheme } 
    }));

    console.log(`🔄 Theme switched to: ${this.currentTheme}`);
  }
}
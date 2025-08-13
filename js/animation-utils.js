/*
==========================================================================
  AWARD-WINNING PORTFOLIO - ANIMATION UTILITIES - v1.0
  This file provides utility functions for creating advanced animations.
==========================================================================
*/

class AnimationUtils {
  /**
   * Splits the text content of an element into words, wrapping each word
   * in a span to allow for word-by-word animations.
   * @param {string} selector - The CSS selector for the target element.
   */
  static splitTextIntoSpans(selector) {
    const element = document.querySelector(selector);
    if (!element) {
      console.error(`AnimationUtils: Element with selector "${selector}" not found.`);
      return;
    }

    const text = element.textContent.trim();
    const words = text.split(/\s+/); // Split by whitespace

    const wrappedWords = words.map(word => {
      // Create a wrapper for the word to maintain layout
      const wordWrapper = document.createElement('span');
      wordWrapper.classList.add('anim-word-wrapper'); // For styling display: inline-block

      // The inner span is what we'll actually animate
      const innerSpan = document.createElement('span');
      innerSpan.classList.add('anim-word');
      innerSpan.textContent = word;

      wordWrapper.appendChild(innerSpan);
      return wordWrapper.outerHTML;
    }).join(' '); // Join with a space to preserve word separation

    element.innerHTML = wrappedWords;

    // Add a non-breaking space to the end of each word wrapper to ensure
    // correct spacing between lines when text wraps.
    const wordWrappers = element.querySelectorAll('.anim-word-wrapper');
    wordWrappers.forEach(wrapper => {
        wrapper.insertAdjacentHTML('afterend', '&nbsp;');
    });
  }
}

/**
 * Cookie Consent Management System
 * TMM-OS Design System v4.0
 */

class CookieConsent {
    constructor() {
        this.consentKey = 'tmm_cookie_consent';
        this.preferencesKey = 'tmm_cookie_preferences';
        this.consentGiven = false;
        this.preferences = {
            necessary: true, // Always true, cannot be disabled
            analytics: false,
            marketing: false,
            preferences: false
        };
        
        this.init();
    }
    
    init() {
        // Check if consent has already been given
        const savedConsent = this.getConsent();
        if (savedConsent) {
            this.consentGiven = true;
            this.preferences = { ...this.preferences, ...savedConsent.preferences };
            this.applyConsent();
        } else {
            // Show consent banner after a short delay
            setTimeout(() => this.showConsentBanner(), 1000);
        }
        
        // Listen for theme changes to update preferences
        this.setupThemeListener();
    }
    
    showConsentBanner() {
        // Don't show if already shown or consent given
        if (document.getElementById('cookie-consent-banner') || this.consentGiven) {
            return;
        }
        
        const banner = this.createConsentBanner();
        document.body.appendChild(banner);
        
        // Animate in
        setTimeout(() => {
            banner.classList.add('show');
        }, 100);
    }
    
    createConsentBanner() {
        const banner = document.createElement('div');
        banner.id = 'cookie-consent-banner';
        banner.innerHTML = `
            <div class="cookie-consent-overlay">
                <div class="cookie-consent-modal">
                    <div class="cookie-consent-header">
                        <h3>🍪 Cookie Preferences</h3>
                        <p>We use cookies to enhance your experience and analyze our traffic. Choose your preferences below.</p>
                    </div>
                    
                    <div class="cookie-consent-options">
                        <div class="cookie-option">
                            <label class="cookie-option-label">
                                <input type="checkbox" id="necessary-cookies" checked disabled>
                                <span class="cookie-option-text">
                                    <strong>Necessary Cookies</strong>
                                    <small>Essential for website functionality (always active)</small>
                                </span>
                            </label>
                        </div>
                        
                        <div class="cookie-option">
                            <label class="cookie-option-label">
                                <input type="checkbox" id="analytics-cookies">
                                <span class="cookie-option-text">
                                    <strong>Analytics Cookies</strong>
                                    <small>Help us understand how visitors use our site</small>
                                </span>
                            </label>
                        </div>
                        
                        <div class="cookie-option">
                            <label class="cookie-option-label">
                                <input type="checkbox" id="preferences-cookies">
                                <span class="cookie-option-text">
                                    <strong>Preference Cookies</strong>
                                    <small>Remember your settings and preferences</small>
                                </span>
                            </label>
                        </div>
                        
                        <div class="cookie-option">
                            <label class="cookie-option-label">
                                <input type="checkbox" id="marketing-cookies">
                                <span class="cookie-option-text">
                                    <strong>Marketing Cookies</strong>
                                    <small>Used for targeted advertising (we don't use these currently)</small>
                                </span>
                            </label>
                        </div>
                    </div>
                    
                    <div class="cookie-consent-actions">
                        <button class="cookie-btn cookie-btn--secondary" id="customize-cookies">Customize</button>
                        <button class="cookie-btn cookie-btn--secondary" id="reject-all-cookies">Reject All</button>
                        <button class="cookie-btn cookie-btn--primary" id="accept-all-cookies">Accept All</button>
                    </div>
                    
                    <div class="cookie-consent-footer">
                        <p>By continuing to use this site, you agree to our use of cookies. 
                        <a href="/privacy-policy.html" target="_blank">Privacy Policy</a> • 
                        <a href="/cookie-consent.html" target="_blank">Cookie Policy</a></p>
                    </div>
                </div>
            </div>
        `;
        
        this.addConsentStyles();
        this.attachConsentListeners(banner);
        
        return banner;
    }
    
    addConsentStyles() {
        if (document.getElementById('cookie-consent-styles')) return;
        
        const styles = document.createElement('style');
        styles.id = 'cookie-consent-styles';
        styles.textContent = `
            .cookie-consent-overlay {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.5);
                z-index: 10000;
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 1rem;
                opacity: 0;
                transition: opacity 0.3s ease;
            }
            
            .cookie-consent-overlay.show {
                opacity: 1;
            }
            
            .cookie-consent-modal {
                background: var(--clr-bg, #FFF8E7);
                border-radius: 12px;
                padding: 2rem;
                max-width: 500px;
                width: 100%;
                max-height: 80vh;
                overflow-y: auto;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
                transform: scale(0.9);
                transition: transform 0.3s ease;
            }
            
            .cookie-consent-overlay.show .cookie-consent-modal {
                transform: scale(1);
            }
            
            .cookie-consent-header h3 {
                font-family: 'DM Serif Display', serif;
                font-size: 1.5rem;
                margin-bottom: 0.5rem;
                color: var(--clr-text, #111111);
            }
            
            .cookie-consent-header p {
                color: var(--clr-muted, #666666);
                margin-bottom: 1.5rem;
                line-height: 1.5;
            }
            
            .cookie-consent-options {
                margin-bottom: 1.5rem;
            }
            
            .cookie-option {
                margin-bottom: 1rem;
            }
            
            .cookie-option-label {
                display: flex;
                align-items: flex-start;
                gap: 0.75rem;
                cursor: pointer;
                padding: 0.5rem;
                border-radius: 8px;
                transition: background-color 0.2s ease;
            }
            
            .cookie-option-label:hover {
                background-color: rgba(0, 0, 255, 0.05);
            }
            
            .cookie-option-label input[type="checkbox"] {
                margin: 0;
                width: 18px;
                height: 18px;
                accent-color: var(--clr-accent, #0000FF);
            }
            
            .cookie-option-label input[type="checkbox"]:disabled {
                opacity: 0.6;
                cursor: not-allowed;
            }
            
            .cookie-option-text {
                flex: 1;
            }
            
            .cookie-option-text strong {
                display: block;
                color: var(--clr-text, #111111);
                margin-bottom: 0.25rem;
            }
            
            .cookie-option-text small {
                color: var(--clr-muted, #666666);
                font-size: 0.875rem;
                line-height: 1.4;
            }
            
            .cookie-consent-actions {
                display: flex;
                gap: 0.75rem;
                margin-bottom: 1rem;
                flex-wrap: wrap;
            }
            
            .cookie-btn {
                padding: 0.75rem 1.5rem;
                border: 2px solid;
                border-radius: 8px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.2s ease;
                font-size: 0.875rem;
                min-width: 120px;
            }
            
            .cookie-btn--primary {
                background-color: var(--clr-accent, #0000FF);
                color: var(--clr-bg, #FFF8E7);
                border-color: var(--clr-accent, #0000FF);
            }
            
            .cookie-btn--primary:hover {
                background-color: transparent;
                color: var(--clr-accent, #0000FF);
                transform: translateY(-1px);
            }
            
            .cookie-btn--secondary {
                background-color: transparent;
                color: var(--clr-muted, #666666);
                border-color: var(--clr-muted, #666666);
            }
            
            .cookie-btn--secondary:hover {
                background-color: var(--clr-muted, #666666);
                color: var(--clr-bg, #FFF8E7);
            }
            
            .cookie-consent-footer {
                text-align: center;
                font-size: 0.875rem;
                color: var(--clr-muted, #666666);
            }
            
            .cookie-consent-footer a {
                color: var(--clr-accent, #0000FF);
                text-decoration: none;
            }
            
            .cookie-consent-footer a:hover {
                text-decoration: underline;
            }
            
            @media (max-width: 768px) {
                .cookie-consent-modal {
                    padding: 1.5rem;
                    margin: 1rem;
                }
                
                .cookie-consent-actions {
                    flex-direction: column;
                }
                
                .cookie-btn {
                    width: 100%;
                }
            }
        `;
        
        document.head.appendChild(styles);
    }
    
    attachConsentListeners(banner) {
        // Accept all cookies
        banner.querySelector('#accept-all-cookies').addEventListener('click', () => {
            this.preferences = {
                necessary: true,
                analytics: true,
                marketing: true,
                preferences: true
            };
            this.saveConsent();
            this.hideBanner();
        });
        
        // Reject all cookies
        banner.querySelector('#reject-all-cookies').addEventListener('click', () => {
            this.preferences = {
                necessary: true,
                analytics: false,
                marketing: false,
                preferences: false
            };
            this.saveConsent();
            this.hideBanner();
        });
        
        // Customize cookies
        banner.querySelector('#customize-cookies').addEventListener('click', () => {
            this.saveCustomPreferences(banner);
            this.hideBanner();
        });
        
        // Update checkboxes based on current preferences
        this.updateCheckboxes(banner);
    }
    
    updateCheckboxes(banner) {
        banner.querySelector('#analytics-cookies').checked = this.preferences.analytics;
        banner.querySelector('#preferences-cookies').checked = this.preferences.preferences;
        banner.querySelector('#marketing-cookies').checked = this.preferences.marketing;
    }
    
    saveCustomPreferences(banner) {
        this.preferences.analytics = banner.querySelector('#analytics-cookies').checked;
        this.preferences.preferences = banner.querySelector('#preferences-cookies').checked;
        this.preferences.marketing = banner.querySelector('#marketing-cookies').checked;
        
        this.saveConsent();
    }
    
    saveConsent() {
        const consentData = {
            given: true,
            date: new Date().toISOString(),
            preferences: this.preferences
        };
        
        localStorage.setItem(this.consentKey, JSON.stringify(consentData));
        localStorage.setItem(this.preferencesKey, JSON.stringify(this.preferences));
        
        this.consentGiven = true;
        this.applyConsent();
    }
    
    getConsent() {
        try {
            const consent = localStorage.getItem(this.consentKey);
            return consent ? JSON.parse(consent) : null;
        } catch (e) {
            return null;
        }
    }
    
    applyConsent() {
        // Apply theme preference if allowed
        if (this.preferences.preferences) {
            this.applyThemePreference();
        }
        
        // Initialize analytics if allowed
        if (this.preferences.analytics) {
            this.initializeAnalytics();
        }
        
        // Show cookie settings button
        this.showCookieSettingsButton();
    }
    
    applyThemePreference() {
        const savedTheme = localStorage.getItem('tmm_theme');
        if (savedTheme) {
            document.documentElement.setAttribute('data-theme', savedTheme);
        }
    }
    
    initializeAnalytics() {
        // Placeholder for analytics initialization
        console.log('Analytics initialized (placeholder)');
    }
    
    showCookieSettingsButton() {
        // Add cookie settings button to footer if not already present
        if (document.getElementById('cookie-settings-btn')) return;
        
        const footer = document.querySelector('.main-footer');
        if (footer) {
            const settingsBtn = document.createElement('button');
            settingsBtn.id = 'cookie-settings-btn';
            settingsBtn.innerHTML = '🍪 Cookie Settings';
            settingsBtn.className = 'cookie-settings-btn';
            settingsBtn.style.cssText = `
                background: transparent;
                border: 1px solid var(--clr-muted, #666666);
                color: var(--clr-muted, #666666);
                padding: 0.5rem 1rem;
                border-radius: 4px;
                cursor: pointer;
                font-size: 0.875rem;
                transition: all 0.2s ease;
            `;
            
            settingsBtn.addEventListener('click', () => {
                this.showConsentBanner();
            });
            
            settingsBtn.addEventListener('mouseenter', () => {
                settingsBtn.style.backgroundColor = 'var(--clr-muted, #666666)';
                settingsBtn.style.color = 'var(--clr-bg, #FFF8E7)';
            });
            
            settingsBtn.addEventListener('mouseleave', () => {
                settingsBtn.style.backgroundColor = 'transparent';
                settingsBtn.style.color = 'var(--clr-muted, #666666)';
            });
            
            const footerTech = footer.querySelector('.footer-tech');
            if (footerTech) {
                footerTech.appendChild(settingsBtn);
            }
        }
    }
    
    setupThemeListener() {
        // Listen for theme changes and save if preferences are allowed
        const themeToggle = document.getElementById('theme-toggle');
        if (themeToggle) {
            themeToggle.addEventListener('click', () => {
                if (this.preferences.preferences) {
                    setTimeout(() => {
                        const currentTheme = document.documentElement.getAttribute('data-theme');
                        localStorage.setItem('tmm_theme', currentTheme);
                    }, 100);
                }
            });
        }
    }
    
    hideBanner() {
        const banner = document.getElementById('cookie-consent-banner');
        if (banner) {
            banner.classList.remove('show');
            setTimeout(() => {
                banner.remove();
            }, 300);
        }
    }
    
    // Public method to reset consent
    resetConsent() {
        localStorage.removeItem(this.consentKey);
        localStorage.removeItem(this.preferencesKey);
        this.consentGiven = false;
        this.preferences = {
            necessary: true,
            analytics: false,
            marketing: false,
            preferences: false
        };
        this.showConsentBanner();
    }
}

// Initialize cookie consent when DOM is loaded
document.addEventListener('DOMContentLoaded', () => {
    window.cookieConsent = new CookieConsent();
});

// Export for use in other scripts
if (typeof module !== 'undefined' && module.exports) {
    module.exports = CookieConsent;
}

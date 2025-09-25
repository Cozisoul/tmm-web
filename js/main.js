// Main application entry point with integrated annotations

// Annotation data
const annotationData = {
    "transdisciplinary": {
        title: "Transdisciplinary Practice",
        text: "Moving fluidly across art, design, and technology within a single, unified practice, as opposed to collaborating between separate fields.",
        link: { text: "Read 'The Observer\'s Toolbox'", url: "#" }
    },
    "data-scientist": {
        title: "Data Scientist",
        text: "A practitioner who uses scientific methods, processes, algorithms, and systems to extract knowledge and insights from structured and unstructured data.",
        link: { text: "View Data Science Portfolio on GitHub", url: "https://github.com/Cozisoul/DataSciencePortfolio", target: "_blank" }
    },
    "python": {
        title: "Python",
        text: "The primary programming language for my data science and creative coding work, utilizing libraries like Pandas, TensorFlow, and p5.py.",
        link: { text: "See Python projects on GitHub", url: "https://github.com/Cozisoul", target: "_blank" }
    },
    "sql": {
        title: "SQL",
        text: "Structured Query Language. The tool I use to manage and query the relational database that forms the backbone of my TMM-OS.",
        link: { text: "View Database Schemas", url: "#" }
    },
    "tensorflow": {
        title: "TensorFlow",
        text: "An open-source library for machine learning and artificial intelligence, which I use for deep learning and generative art projects.",
        link: { text: "See Certifications Below", url: "#" }
    },
    "eda": {
        title: "Exploratory Data Analysis (EDA)",
        text: "A core data science skill focused on analyzing datasets to summarize their main characteristics, often with visual methods. This is the bridge between raw data and creative insight.",
        link: { text: "View Data Science Portfolio", url: "https://github.com/Cozisoul/DataSciencePortfolio", target: "_blank" }
    },
    "ogilvy": {
        title: "Ogilvy South Africa",
        text: "A world-renowned creative agency where I am applying my data science skills to real-world client challenges, bridging the gap between data and creativity.",
        link: { text: "Visit Ogilvy.com", url: "https://www.ogilvy.co.za/", target: "_blank" }
    },
    "deviare": {
        title: "Deviare",
        text: "A structured Data Science Learnership program where I am formalizing my skills in Python, R, SQL, Power BI, and Tableau.",
        link: { text: "Visit Deviare.co.za", url: "https://www.deviare.co.za/", target: "_blank" }
    },
    "freelance": {
        title: "Freelance Practice (2017-Present)",
        text: "Extensive experience as a commercial photographer and videographer for major brands including Vans, Sportscene, Cotton On, and Viktor & Rolf, and for artists like Enhle Mbali.",
        link: { text: "View Creative Portfolio", url: "#" }
    },
    "varsity": {
        title: "Varsity Newspaper (UCT)",
        text: "As Image Editor, I was responsible for the selection, curation, and technical quality of all photographic content for the University of Cape Town's official student newspaper.",
        link: { text: "Demonstrates Editorial & Management Skills", url: "#" }
    },
    "google-analytics": {
        title: "Google Analytics Certification",
        text: "A professional certification demonstrating proficiency in using Google Analytics for web traffic analysis, audience insights, and conversion tracking.",
        link: { text: "View Credential", url: "#" }
    },
    "aws-ml": {
        title: "AWS: Machine Learning Foundations",
        text: "A foundational certification covering the core concepts and services for machine learning on the Amazon Web Services platform.",
        link: { text: "View Credential", url: "#" }
    },
    "aws-genai": {
        title: "AWS: Introducing Generative AI",
        text: "A certification covering the fundamentals of Generative AI, including Large Language Models (LLMs) and their applications on AWS.",
        link: { text: "View Credential", url: "#" }
    },
    "tf-deep-learning": {
        title: "Deep Learning with TensorFlow",
        text: "A certification focused on building and training deep neural networks using Google's TensorFlow framework.",
        link: { text: "View Credential", url: "#" }
    },
     "tf-genai": {
        title: "GenAI for Data Scientists",
        text: "A specialized TensorFlow certification on the practical application of Generative AI models for data science tasks.",
        link: { text: "View Credential", url: "#" }
    },
    "photographer": {
        title: "Photography Practice",
        text: "The art and practice of creating durable images by recording light, either electronically or chemically. My journey spans from automotive photography to fine art.",
        link: { text: "View Photography", url: "https://www.instagram.com/thaeplo_gv72/", target: "_blank" }
    },
    "documentary": {
        title: "Documentary Photography",
        text: "A style of photography that provides a straightforward and accurate representation of people, places, objects and events. I documented the historic Fees Must Fall protests.",
        link: { text: "View Documentary Work", url: "https://www.instagram.com/thaeplo_gv72/", target: "_blank" }
    },
    "portraiture": {
        title: "Portraiture",
        text: "A type of photography aimed toward capturing the personality of a person or group of people by using effective lighting, backdrops, and poses.",
        link: { text: "View Portraits", url: "https://www.instagram.com/thaporaphy/", target: "_blank" }
    },
    "fashion": {
        title: "Fashion Photography",
        text: "A genre of photography devoted to displaying clothing and other fashion items, often for advertisements or fashion magazines. I've worked with major brands.",
        link: { text: "View Fashion Work", url: "https://www.behance.net/thapelomasebe", target: "_blank" }
    },
    "fine-art": {
        title: "Fine Art Photography",
        text: "Photography created in accordance with the vision of the artist as photographer, using photography as a medium for creative expression.",
        link: { text: "View Fine Art", url: "https://www.instagram.com/72film/", target: "_blank" }
    },
    "architecture": {
        title: "Architecture Photography",
        text: "The photographing of buildings and similar structures that are both aesthetically pleasing and accurate representations of their subjects.",
        link: { text: "View Architecture", url: "https://www.instagram.com/thaeplo_gv72/", target: "_blank" }
    }
};

// Enhanced annotation system with mobile support
let activeAnnotation = null;
let annotationContent = null;

function showAnnotation(element) {
    const key = element.getAttribute('data-annotation');
    const data = annotationData[key];

    console.log('Showing annotation for:', key, data);

    if (data && annotationContent) {
        // Remove active class from previous annotation
        if (activeAnnotation) {
            activeAnnotation.classList.remove('active');
        }
        
        // Add active class to current annotation
        element.classList.add('active');
        activeAnnotation = element;

        let html = `<h3 class="annotation-title">${data.title}</h3>`;
        html += `<p class="annotation-text">${data.text}</p>`;
        if (data.link && data.link.url !== "#") {
            html += `<a href="${data.link.url}" class="annotation-link" target="${data.link.target || '_self'}" rel="noopener noreferrer">${data.link.text}</a>`;
        }
        annotationContent.innerHTML = html;
        // Prevent layout shift by using fixed positioning
        annotationContent.style.position = 'fixed';
        console.log('Annotation content updated');
    } else {
        console.log('No data or annotationContent:', { data, annotationContent });
    }
}

function hideAnnotation() {
    if (activeAnnotation) {
        activeAnnotation.classList.remove('active');
        activeAnnotation = null;
    }
    if (annotationContent) {
        annotationContent.innerHTML = '<p class="placeholder">* Tap on a highlighted term for context.</p>';
    }
}

// Main application initialization
document.addEventListener('DOMContentLoaded', () => {
  // Initialize annotation system
  const annotationPanel = document.getElementById('annotation-panel');
  annotationContent = annotationPanel.querySelector('.annotation-content');
  const annotatedElements = document.querySelectorAll('[data-annotation]');
  
  console.log('Annotation elements found:', annotatedElements.length);
  console.log('Annotation content element:', annotationContent);

  // Add event listeners for both mouse and touch interactions
  annotatedElements.forEach(element => {
      // Mouse events for desktop
      element.addEventListener('mouseenter', () => {
          console.log('Mouse enter on:', element.getAttribute('data-annotation'));
          if (window.innerWidth > 768) {
              showAnnotation(element);
          }
      });

      // Touch events for mobile
      element.addEventListener('click', (e) => {
          console.log('Click event on:', element.getAttribute('data-annotation'));
          if (window.innerWidth <= 768) {
              e.preventDefault();
              if (activeAnnotation === element) {
                  hideAnnotation();
              } else {
                  showAnnotation(element);
              }
          }
      });

      // Focus events for keyboard navigation
      element.addEventListener('focus', () => {
          showAnnotation(element);
      });
  });

  // Hide annotation when clicking outside on mobile
  document.addEventListener('click', (e) => {
      if (window.innerWidth <= 768 && !e.target.closest('[data-annotation]') && !e.target.closest('.right-column')) {
          hideAnnotation();
      }
  });

  // Handle window resize
  window.addEventListener('resize', () => {
      if (window.innerWidth > 768) {
          hideAnnotation();
      }
  });

  // Initialize complete
  console.log('Annotation system initialized successfully');
  
  // Initialize theme toggle
  initializeThemeToggle();
  
  // Initialize smooth scrolling
  initializeSmoothScrolling();
  
  // Initialize mobile optimizations
  initializeMobileOptimizations();
  
  // Initialize dynamic responsiveness
  initializeDynamicResponsiveness();
});

// Theme Toggle Functionality
function initializeThemeToggle() {
  const themeToggle = document.getElementById('theme-toggle');
  const themeIcon = document.getElementById('theme-icon');
  const body = document.body;
  
  console.log('Theme toggle element:', themeToggle);
  console.log('Theme icon element:', themeIcon);
  
  if (!themeToggle || !themeIcon) {
    console.error('Theme toggle elements not found!');
    return;
  }
  
  // Force light mode to maintain your design system
  const currentTheme = 'light';
  body.setAttribute('data-theme', currentTheme);
  updateThemeIcon(currentTheme);
  
  themeToggle.addEventListener('click', () => {
    const currentTheme = body.getAttribute('data-theme');
    const newTheme = currentTheme === 'light' ? 'dark' : 'light';
    
    body.setAttribute('data-theme', newTheme);
    localStorage.setItem('theme', newTheme);
    updateThemeIcon(newTheme);
    
    console.log('Theme switched to:', newTheme);
  });
  
  function updateThemeIcon(theme) {
    if (themeIcon) {
      themeIcon.textContent = theme === 'light' ? '🌙' : '☀️';
    }
  }
}

// Enhanced Smooth Scrolling
function initializeSmoothScrolling() {
  // Add smooth scrolling to all internal links
  const internalLinks = document.querySelectorAll('a[href^="#"]');
  
  internalLinks.forEach(link => {
    link.addEventListener('click', (e) => {
      e.preventDefault();
      const targetId = link.getAttribute('href').substring(1);
      const targetElement = document.getElementById(targetId);
      
      if (targetElement) {
        targetElement.scrollIntoView({
          behavior: 'smooth',
          block: 'start',
          inline: 'nearest'
        });
      }
    });
  });
  
  // Add smooth scrolling to annotation elements
  const annotationElements = document.querySelectorAll('[data-annotation]');
  annotationElements.forEach(element => {
    element.addEventListener('click', () => {
      if (window.innerWidth <= 768) {
        // On mobile, scroll to annotation panel
        const annotationPanel = document.getElementById('annotation-panel');
        if (annotationPanel) {
          annotationPanel.scrollIntoView({
            behavior: 'smooth',
            block: 'start',
            inline: 'nearest'
          });
        }
      }
    });
  });
  
  console.log('Smooth scrolling initialized');
}

// Mobile Optimization Functions
function initializeMobileOptimizations() {
  // Handle viewport height on mobile browsers
  function setViewportHeight() {
    const vh = window.innerHeight * 0.01;
    document.documentElement.style.setProperty('--vh', `${vh}px`);
  }

  // Set initial viewport height
  setViewportHeight();

  // Update on resize
  window.addEventListener('resize', setViewportHeight);

  // Handle orientation change
  window.addEventListener('orientationchange', () => {
    setTimeout(setViewportHeight, 100);
  });

  // Prevent zoom on double tap for iOS
  let lastTouchEnd = 0;
  document.addEventListener('touchend', (e) => {
    const now = (new Date()).getTime();
    if (now - lastTouchEnd <= 300) {
      e.preventDefault();
    }
    lastTouchEnd = now;
  }, false);

  // Add touch feedback for interactive elements
  const touchElements = document.querySelectorAll('a, button, [data-annotation]');
  touchElements.forEach(element => {
    element.addEventListener('touchstart', () => {
      element.classList.add('touch-active');
    }, { passive: true });

    element.addEventListener('touchend', () => {
      setTimeout(() => {
        element.classList.remove('touch-active');
      }, 150);
    }, { passive: true });
  });

  console.log('Mobile optimizations initialized');
}

// Dynamic Responsive Functions
function initializeDynamicResponsiveness() {
  let resizeTimeout;
  
  // Function to update responsive classes based on current viewport
  function updateResponsiveClasses() {
    const width = window.innerWidth;
    const height = window.innerHeight;
    
    // Remove all responsive classes
    document.body.classList.remove(
      'screen-ultra-small',
      'screen-small',
      'screen-medium',
      'screen-large',
      'screen-extra-large',
      'screen-ultra-wide',
      'screen-extra-ultra-wide',
      'screen-4k',
      'screen-8k',
      'orientation-portrait',
      'orientation-landscape'
    );
    
    // Add appropriate screen size class
    if (width <= 320) {
      document.body.classList.add('screen-ultra-small');
    } else if (width <= 480) {
      document.body.classList.add('screen-small');
    } else if (width <= 768) {
      document.body.classList.add('screen-medium');
    } else if (width <= 1024) {
      document.body.classList.add('screen-large');
    } else if (width <= 1439) {
      document.body.classList.add('screen-extra-large');
    } else if (width <= 1919) {
      document.body.classList.add('screen-ultra-wide');
    } else if (width <= 2559) {
      document.body.classList.add('screen-extra-ultra-wide');
    } else if (width <= 3839) {
      document.body.classList.add('screen-4k');
    } else {
      document.body.classList.add('screen-8k');
    }
    
    // Add orientation class
    if (height > width) {
      document.body.classList.add('orientation-portrait');
    } else {
      document.body.classList.add('orientation-landscape');
    }
    
    // Update CSS custom properties for dynamic sizing
    document.documentElement.style.setProperty('--viewport-width', `${width}px`);
    document.documentElement.style.setProperty('--viewport-height', `${height}px`);
    document.documentElement.style.setProperty('--viewport-ratio', `${width / height}`);
    
    // Update container max-width dynamically
    const container = document.querySelector('.cv-container');
    if (container) {
      const maxWidth = Math.min(1440, width * 0.95);
      container.style.maxWidth = `${maxWidth}px`;
    }
    
    console.log(`Dynamic responsive update: ${width}x${height} (${document.body.className})`);
  }
  
  // Debounced resize handler
  function handleResize() {
    clearTimeout(resizeTimeout);
    resizeTimeout = setTimeout(updateResponsiveClasses, 16); // ~60fps
  }
  
  // Initial setup
  updateResponsiveClasses();
  
  // Listen for resize events
  window.addEventListener('resize', handleResize);
  window.addEventListener('orientationchange', () => {
    setTimeout(updateResponsiveClasses, 100);
  });
  
  // Listen for fullscreen changes
  document.addEventListener('fullscreenchange', updateResponsiveClasses);
  document.addEventListener('webkitfullscreenchange', updateResponsiveClasses);
  document.addEventListener('mozfullscreenchange', updateResponsiveClasses);
  document.addEventListener('MSFullscreenChange', updateResponsiveClasses);
  
        console.log('Dynamic responsiveness initialized');
      }

      // Theme Toggle Function (for footer)
      window.toggleTheme = function() {
        const body = document.body;
        const currentTheme = body.getAttribute('data-theme');
        const newTheme = currentTheme === 'light' ? 'dark' : 'light';
        
        body.setAttribute('data-theme', newTheme);
        localStorage.setItem('theme', newTheme);
        
        // Update theme icon if it exists
        const themeIcon = document.getElementById('theme-icon');
        if (themeIcon) {
          themeIcon.textContent = newTheme === 'light' ? '🌙' : '☀️';
        }
        
        console.log('Theme toggled to:', newTheme);
      };

// Add intersection observer for performance
if ('IntersectionObserver' in window) {
  const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        entry.target.classList.add('in-view');
      }
    });
  }, {
    threshold: 0.1,
    rootMargin: '50px'
  });

  // Observe sections for lazy loading effects
  document.addEventListener('DOMContentLoaded', () => {
    const sections = document.querySelectorAll('section, aside');
    sections.forEach(section => observer.observe(section));
  });
}
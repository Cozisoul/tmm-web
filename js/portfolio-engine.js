/*
==========================================================================
  AWARD-WINNING PORTFOLIO - PORTFOLIO ENGINE
  This module fetches project data from a JSON file, renders the
  portfolio grid, and handles the interactive filtering logic.
==========================================================================
*/

class PortfolioEngine {
  constructor() {
    this.grid = document.getElementById('portfolioGrid');
    this.filters = document.getElementById('portfolioFilters');
    
    if (!this.grid || !this.filters) {
      console.error('Portfolio grid or filters not found!');
      return;
    }

    this.allProjects = [];
    this.activeFilter = 'all';

    this.init();
  }

  async init() {
    await this.fetchProjects();
    this.renderGrid();
    this.bindEvents();
    console.log('📁 Portfolio Engine initialized.');
  }

  async fetchProjects() {
    try {
      const response = await fetch('data/portfolio.json');
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }
      const data = await response.json();
      this.allProjects = data.projects || [];
    } catch (error) {
      console.error('Could not fetch portfolio projects:', error);
      this.grid.innerHTML = '<p class="error">Failed to load projects.</p>';
    }
  }
  
  bindEvents() {
    this.filters.addEventListener('click', (e) => {
      if (e.target.tagName === 'BUTTON') {
        const filter = e.target.dataset.filter;
        this.setActiveFilter(filter);
      }
    });
  }

  setActiveFilter(filter) {
    if (this.activeFilter === filter) return; // Do nothing if filter is already active
    
    this.activeFilter = filter;
    
    // Update active class on buttons
    this.filters.querySelectorAll('.filter-btn').forEach(btn => {
      btn.classList.toggle('active', btn.dataset.filter === filter);
    });

    this.animateFilter();
  }

  renderGrid() {
    const projectsToRender = this.activeFilter === 'all'
      ? this.allProjects
      : this.allProjects.filter(p => p.category === this.activeFilter);

    this.grid.innerHTML = projectsToRender.map(project => `
      <div class="project-card" data-category="${project.category}">
        <div class="project-image">
          <img src="${project.thumbnail}" alt="${project.title}" loading="lazy">
        </div>
        <div class="project-content">
          <h3 class="project-title">${project.title}</h3>
          <p class="project-description">${project.description}</p>
        </div>
      </div>
    `).join('');
  }

  animateFilter() {
    // GSAP animation for a seamless filter transition
    gsap.to(this.grid, {
      opacity: 0,
      duration: 0.2,
      ease: 'power1.in',
      onComplete: () => {
        this.renderGrid(); // Re-render the grid with the new filter
        gsap.fromTo(this.grid.children, 
          { opacity: 0, y: 30 },
          { 
            opacity: 1, 
            y: 0,
            duration: 0.4,
            ease: 'power2.out',
            stagger: 0.05 // Animate each card in sequence
          }
        );
      }
    });
  }
}
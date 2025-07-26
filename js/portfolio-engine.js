/*
==========================================================================
  AWARD-WINNING PORTFOLIO - PORTFOLIO ENGINE v2.4 (Awwwards Polish)
  This version adds advanced GSAP hover effects to the portfolio grid.
==========================================================================
*/

class PortfolioEngine {
  constructor(mainApp) {
    this.mainApp = mainApp;
    this.grid = null;
    this.filters = null;
    this.allProjects = [];
    this.activeFilter = 'all';
    this.init();
  }

  async init() {
    this.grid = document.getElementById('portfolioGrid');
    this.filters = document.getElementById('portfolioFilters');
    if (!this.grid || !this.filters) {
      console.error('Portfolio Engine failed: Critical elements not found.');
      return;
    }
    await this.fetchProjects();
    this.renderGrid();
    this.bindEvents();
    console.log('📁 Portfolio Engine v2.4 (Polished) initialized.');
  }

  async fetchProjects() {
    try {
      const response = await fetch('/data/portfolio.json');
      if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);
      const data = await response.json();
      this.allProjects = data.projects || [];
    } catch (error) {
      console.error('Could not fetch portfolio projects:', error);
      this.grid.innerHTML = '<p class="error">Failed to load projects.</p>';
    }
  }
  
  bindEvents() {
    this.filters.addEventListener('click', (e) => {
      if (e.target.tagName === 'BUTTON') this.setActiveFilter(e.target.dataset.filter);
    });
    this.grid.addEventListener('click', (e) => {
      const card = e.target.closest('.project-card');
      if (card) this.openProjectModal(card.dataset.id);
    });
  }

  setActiveFilter(filter) {
    if (this.activeFilter === filter) return;
    this.activeFilter = filter;
    this.filters.querySelectorAll('.filter-btn').forEach(btn => {
      btn.classList.toggle('active', btn.dataset.filter === filter);
    });
    this.animateFilter();
  }

  renderGrid() {
    if (!this.grid) return;
    const projectsToRender = this.activeFilter === 'all'
      ? this.allProjects
      : this.allProjects.filter(p => p.category === this.activeFilter);

    this.grid.innerHTML = projectsToRender.map(project => `
      <div class="project-card" data-id="${project.id}" data-category="${project.category}">
        <div class="project-image-wrapper">
          <img class="project-image" src="${project.thumbnail}" alt="${project.title}" loading="lazy">
        </div>
        <div class="project-content">
          <h3 class="project-title">${project.title}</h3>
          <p class="project-description">${project.description}</p>
        </div>
      </div>
    `).join('');
    
    // New: Add advanced hover listeners after rendering
    this.addHoverListeners();
  }

  // New: Advanced GSAP hover effects
  addHoverListeners() {
    const cards = this.grid.querySelectorAll('.project-card');
    cards.forEach(card => {
      const image = card.querySelector('.project-image');
      const title = card.querySelector('.project-title');
      
      const tl = gsap.timeline({ paused: true });
      tl.to(image, { scale: 1.1, duration: 0.6, ease: 'power2.out' });
      
      card.addEventListener('mouseenter', () => tl.play());
      card.addEventListener('mouseleave', () => tl.reverse());
    });
  }

  animateFilter() {
    gsap.to(this.grid, {
      opacity: 0,
      duration: 0.2,
      ease: 'power1.in',
      onComplete: () => {
        this.renderGrid();
        gsap.fromTo(this.grid.children, 
          { opacity: 0, y: 30 },
          { opacity: 1, y: 0, duration: 0.4, ease: 'power2.out', stagger: 0.05 }
        );
      }
    });
  }

  openProjectModal(projectId) {
    const projectData = this.allProjects.find(p => p.id === projectId);
    if (!projectData) return;

    const modalHTML = this.createModalHTML(projectData);
    document.body.insertAdjacentHTML('beforeend', modalHTML);
    
    const modalElement = document.getElementById('projectModal');
    if (!modalElement) return;

    const modalContent = modalElement.querySelector('.modal-content');
    const modalBackdrop = modalElement.querySelector('.modal-backdrop');

    document.body.style.overflow = 'hidden';

    gsap.timeline()
      .to(modalBackdrop, { opacity: 1, duration: 0.4 })
      .to(modalContent, { opacity: 1, y: 0, scale: 1, duration: 0.4, ease: 'power2.out' }, "-=0.2")
      .call(() => {
        if (projectData.interactive && this.mainApp && this.mainApp.dataViz) {
          const container = modalElement.querySelector('#interactive-module-container');
          this.mainApp.dataViz.initializeModule(projectData.interactive, container);
        }
      });
      
    modalElement.querySelector('.modal-close').addEventListener('click', () => this.closeProjectModal());
    modalBackdrop.addEventListener('click', () => this.closeProjectModal());
  }
  
  closeProjectModal() {
    const modalElement = document.getElementById('projectModal');
    if (!modalElement) return;
    document.body.style.overflow = 'auto';
    gsap.timeline({ onComplete: () => modalElement.remove() })
      .to(modalElement, { opacity: 0, duration: 0.3, ease: 'power2.in' });
  }

  createModalHTML(project) {
    const imageGalleryHTML = (project.images && project.images.length > 0)
      ? project.images.map(imgUrl => `<img class="modal-gallery-image" src="${imgUrl}" alt="${project.title} detail image" loading="lazy">`).join('')
      : `<img class="modal-gallery-image" src="${project.thumbnail}" alt="${project.title} detail image" loading="lazy">`;

    const interactiveModuleHTML = project.interactive
      ? `<div class="interactive-module" id="interactive-module-container"></div>`
      : '';

    return `
      <div class="project-modal" id="projectModal">
        <div class="modal-backdrop"></div>
        <div class="modal-content">
          <button class="modal-close" aria-label="Close project details">×</button>
          <div class="modal-header">
            <h2 class="modal-title">${project.title}</h2>
            <span class="modal-category">${project.category} / ${project.year}</span>
          </div>
          <div class="modal-body">
            <div class="modal-gallery">
              ${imageGalleryHTML}
            </div>
            <div class="modal-details">
              <p class="modal-full-description">${project.fullDescription || project.description}</p>
              ${interactiveModuleHTML}
              <div class="modal-tags">
                ${project.tags.map(tag => `<span class="tag">${tag}</span>`).join('')}
              </div>
            </div>
          </div>
        </div>
      </div>
    `;
  }
}
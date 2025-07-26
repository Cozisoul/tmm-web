/*
==========================================================================
  AWARD-WINNING PORTFOLIO - CONSTELLATION CANVAS
  This module creates the interactive, theme-aware background for the hero.
  - Draws nodes and connects them based on proximity.
  - Nodes are subtly influenced by user's mouse movement.
  - Listens to the 'themeChanged' event to swap colors.
==========================================================================
*/

class ConstellationCanvas {
  constructor(canvasId) {
    this.canvas = document.getElementById(canvasId);
    if (!this.canvas) {
      console.error('Constellation canvas not found!');
      return;
    }
    this.ctx = this.canvas.getContext('2d');
    
    this.settings = {
      nodeCount: 100,
      connectionDistance: 120,
      mouseInfluenceRadius: 150,
    };

    this.nodes = [];
    this.mouse = { x: undefined, y: undefined };
    
    // Set initial colors based on the current theme
    const initialTheme = document.body.dataset.theme || 'systematic';
    this.setColors(initialTheme);

    this.init();
  }

  init() {
    this.resizeCanvas();
    this.createNodes();
    this.bindEvents();
    this.animate();
    console.log('🌌 Constellation Canvas initialized.');
  }

  setColors(theme) {
    if (theme === 'poetic') {
      this.nodeColor = 'rgba(40, 54, 24, 0.7)'; // --color-green
      this.connectionColor = 'rgba(40, 54, 24, 0.2)';
    } else { // systematic
      this.nodeColor = 'rgba(0, 0, 255, 0.7)'; // --color-blue
      this.connectionColor = 'rgba(255, 255, 255, 0.2)';
    }
  }

  resizeCanvas() {
    this.canvas.width = window.innerWidth;
    this.canvas.height = window.innerHeight;
  }

  createNodes() {
    this.nodes = [];
    for (let i = 0; i < this.settings.nodeCount; i++) {
      this.nodes.push({
        x: Math.random() * this.canvas.width,
        y: Math.random() * this.canvas.height,
        vx: (Math.random() - 0.5) * 0.3,
        vy: (Math.random() - 0.5) * 0.3,
        radius: Math.random() * 1.5 + 1
      });
    }
  }
  
  bindEvents() {
    window.addEventListener('resize', () => this.resizeCanvas());
    window.addEventListener('mousemove', (e) => {
      this.mouse.x = e.clientX;
      this.mouse.y = e.clientY;
    });
    // Listen for the custom event from our ThemeController
    window.addEventListener('themeChanged', (e) => this.setColors(e.detail.theme));
  }

  draw() {
    this.ctx.clearRect(0, 0, this.canvas.width, this.canvas.height);

    for (let i = 0; i < this.nodes.length; i++) {
      const nodeA = this.nodes[i];
      
      // Update position
      nodeA.x += nodeA.vx;
      nodeA.y += nodeA.vy;

      // Wall bouncing
      if (nodeA.x < 0 || nodeA.x > this.canvas.width) nodeA.vx *= -1;
      if (nodeA.y < 0 || nodeA.y > this.canvas.height) nodeA.vy *= -1;

      // Draw connections
      this.ctx.lineWidth = 0.5;
      this.ctx.strokeStyle = this.connectionColor;
      for (let j = i + 1; j < this.nodes.length; j++) {
        const nodeB = this.nodes[j];
        const dx = nodeA.x - nodeB.x;
        const dy = nodeA.y - nodeB.y;
        const distance = Math.sqrt(dx * dx + dy * dy);

        if (distance < this.settings.connectionDistance) {
          this.ctx.beginPath();
          this.ctx.moveTo(nodeA.x, nodeA.y);
          this.ctx.lineTo(nodeB.x, nodeB.y);
          this.ctx.stroke();
        }
      }

      // Draw node
      this.ctx.fillStyle = this.nodeColor;
      this.ctx.beginPath();
      this.ctx.arc(nodeA.x, nodeA.y, nodeA.radius, 0, Math.PI * 2);
      this.ctx.fill();
    }
  }

  animate() {
    this.draw();
    requestAnimationFrame(() => this.animate());
  }
}
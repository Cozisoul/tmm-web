/*
==========================================================================
  AWARD-WINNING PORTFOLIO - DATA VISUALIZATION ENGINE v1.0
  This module contains the logic to build and render specific
  interactive data modules within the project modals.
==========================================================================
*/

class DataVisualization {
  constructor() {
    this.d3 = window.d3; // Use the globally loaded D3.js library
    if (!this.d3) {
      console.warn('D3.js library not found. Knowledge graph will not function.');
    }
    console.log('📊 Data Visualization Engine initialized.');
  }

  /**
   * Main entry point to initialize a module.
   * @param {object} interactiveData - The "interactive" object from portfolio.json.
   * @param {HTMLElement} container - The container element to build the module inside.
   */
  initializeModule(interactiveData, container) {
    if (!interactiveData || !container) return;

    switch (interactiveData.type) {
      case 'sentiment-analyzer':
        this.renderSentimentAnalyzer(container);
        break;
      case 'knowledge-graph':
        if (this.d3) {
          this.renderKnowledgeGraph(container);
        }
        break;
      default:
        console.warn(`Unknown interactive module type: ${interactiveData.type}`);
    }
  }

  // --- MODULE 1: SENTIMENT ANALYZER ---
  renderSentimentAnalyzer(container) {
    container.innerHTML = `
      <div class="sentiment-interface">
        <textarea class="sentiment-textarea" placeholder="Enter text in Sepedi or English..."></textarea>
        <button class="sentiment-button">Analyze Sentiment</button>
        <div class="sentiment-result"></div>
      </div>
    `;

    const analyzeBtn = container.querySelector('.sentiment-button');
    const textarea = container.querySelector('.sentiment-textarea');
    const resultDiv = container.querySelector('.sentiment-result');

    analyzeBtn.addEventListener('click', () => {
      const text = textarea.value.trim();
      if (!text) return;
      
      analyzeBtn.textContent = 'Analyzing...';
      analyzeBtn.disabled = true;

      // Simulate API call
      setTimeout(() => {
        const score = (text.length % 100) / 100; // Simple simulated score
        const sentiment = score > 0.6 ? 'Positive' : score < 0.4 ? 'Negative' : 'Neutral';
        resultDiv.innerHTML = `<p><strong>Result:</strong> ${sentiment} (Score: ${score.toFixed(2)})</p>`;
        
        analyzeBtn.textContent = 'Analyze Sentiment';
        analyzeBtn.disabled = false;
      }, 1000);
    });
  }

  // --- MODULE 2: KNOWLEDGE GRAPH ---
  renderKnowledgeGraph(container) {
    const width = container.clientWidth;
    const height = 400;

    const svg = this.d3.select(container)
      .append("svg")
      .attr("width", width)
      .attr("height", height);

    const nodes = [
      { id: 'Biko', group: 'person', size: 12 },
      { id: 'BCM', group: 'org', size: 10 },
      { id: 'Black Consciousness', group: 'concept', size: 10 },
      { id: 'SASO', group: 'org', size: 8 },
      { id: 'Apartheid', group: 'system', size: 8 },
    ];
    const links = [
      { source: 'Biko', target: 'BCM', value: 2 },
      { source: 'Biko', target: 'Black Consciousness', value: 2 },
      { source: 'BCM', target: 'SASO', value: 1.5 },
      { source: 'Biko', target: 'Apartheid', value: 1.5 },
    ];

    const simulation = this.d3.forceSimulation(nodes)
      .force("link", this.d3.forceLink(links).id(d => d.id).distance(100))
      .force("charge", this.d3.forceManyBody().strength(-200))
      .force("center", this.d3.forceCenter(width / 2, height / 2));

    const link = svg.append("g")
      .attr("stroke", "var(--border-color)")
      .attr("stroke-opacity", 0.6)
      .selectAll("line")
      .data(links)
      .join("line")
      .attr("stroke-width", d => d.value);

    const node = svg.append("g")
      .selectAll("circle")
      .data(nodes)
      .join("circle")
      .attr("r", d => d.size)
      .attr("fill", "var(--accent-primary)")
      .attr("stroke", "var(--bg-primary)")
      .attr("stroke-width", 2)
      .call(this.drag(simulation));

    node.append("title").text(d => d.id);

    simulation.on("tick", () => {
      link
        .attr("x1", d => d.source.x)
        .attr("y1", d => d.source.y)
        .attr("x2", d => d.target.x)
        .attr("y2", d => d.target.y);
      node
        .attr("cx", d => d.x)
        .attr("cy", d => d.y);
    });
  }
  
  drag(simulation) {
    function dragstarted(event, d) {
      if (!event.active) simulation.alphaTarget(0.3).restart();
      d.fx = d.x;
      d.fy = d.y;
    }
    function dragged(event, d) {
      d.fx = event.x;
      d.fy = event.y;
    }
    function dragended(event, d) {
      if (!event.active) simulation.alphaTarget(0);
      d.fx = null;
      d.fy = null;
    }
    return this.d3.drag()
      .on("start", dragstarted)
      .on("drag", dragged)
      .on("end", dragended);
  }
}
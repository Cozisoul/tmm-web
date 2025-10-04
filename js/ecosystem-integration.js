// Ecosystem Integration JavaScript
// Handles GitHub API, Research Radio, and other integrations

// GitHub API Integration
async function loadGitHubRepos() {
    try {
        const response = await fetch('https://api.github.com/users/Cozisoul/repos?sort=updated&per_page=5');
        const repos = await response.json();
        
        const githubContainer = document.getElementById('github-repos');
        if (githubContainer && repos.length > 0) {
            // Clear existing content
            githubContainer.innerHTML = '';
            
            repos.forEach(repo => {
                const repoItem = document.createElement('div');
                repoItem.className = 'repo-item';
                
                repoItem.innerHTML = `
                    <h4>${repo.name}</h4>
                    <p>${repo.description || 'No description available'}</p>
                    <div class="repo-links">
                        <a href="${repo.html_url}" target="_blank" rel="noopener noreferrer">View Repository →</a>
                        ${repo.homepage ? `<a href="${repo.homepage}" target="_blank" rel="noopener noreferrer">Live Site →</a>` : ''}
                    </div>
                `;
                
                githubContainer.appendChild(repoItem);
            });
        }
    } catch (error) {
        console.log('GitHub API not available or rate limited:', error);
        // Keep the existing static content
    }
}

// Research Radio Integration
function loadResearchRadioContent() {
    // This would integrate with Research Radio RSS feed or API
    // For now, we'll keep the static content
    console.log('Research Radio integration ready');
}

// Photography Portfolio Integration
function loadPhotographyContent() {
    // This would integrate with Instagram API
    // For now, we'll keep the static content
    console.log('Photography portfolio integration ready');
}

// Initialize all integrations
document.addEventListener('DOMContentLoaded', () => {
    console.log('Ecosystem integration initializing...');
    
    // Load GitHub repositories
    loadGitHubRepos();
    
    // Load other content
    loadResearchRadioContent();
    loadPhotographyContent();
    
    console.log('Ecosystem integration complete');
});

// Export for potential use in other scripts
if (typeof module !== 'undefined') {
    module.exports = {
        loadGitHubRepos,
        loadResearchRadioContent,
        loadPhotographyContent
    };
}

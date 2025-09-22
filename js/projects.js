// Projects and Portfolio Data
// Update this file with your current projects and images

const projectsData = {
    photography: {
        title: "Commercial Photography",
        description: "Major brand campaigns for Vans, Sportscene, Cotton On, and Viktor & Rolf. High-end fashion and lifestyle photography.",
        link: "https://www.instagram.com/thaeplo_gv72/",
        projects: ["LEBO SELECTS", "MOSA", "STAINED"],
        brands: ["Vans", "Sportscene", "Cotton On", "Viktor & Rolf", "Enhle Mbali"],
        featured: true
    },
    dataScience: {
        title: "Data Science & AI",
        description: "Python, SQL, TensorFlow projects. Machine learning models and data visualization for business insights.",
        link: "https://github.com/Cozisoul",
        repositories: ["tmm-os", "tmm-web", "DataSciencePortfolio"],
        technologies: ["Python", "SQL", "TensorFlow", "Machine Learning", "Data Visualization"],
        featured: true
    },
    research: {
        title: "Research Radio",
        description: "Podcast series exploring transdisciplinary methodologies and creative tools. 'The Observer's Toolbox' series.",
        link: "https://www.researchradio.co.za/",
        episodes: ["The Observer's Toolbox", "Transdisciplinary Practice", "Creative Methodologies"],
        featured: true
    },
    editorial: {
        title: "Editorial Work",
        description: "Image Editor at Varsity Newspaper (UCT). Curated visual content for university publication.",
        link: "https://www.researchradio.co.za/",
        publications: ["Varsity Newspaper", "University Publications"],
        featured: true
    },
    creative: {
        title: "Creative Collaborations",
        description: "Transdisciplinary projects blending art, technology, and data. Worked with artists like Enhle Mbali.",
        link: "https://www.instagram.com/thaeplo_gv72/",
        collaborations: ["Enhle Mbali", "Creative Technologists", "Data Artists"],
        featured: false
    }
};

// Function to update the work gallery with current projects
function updateWorkGallery() {
    const workGallery = document.querySelector('.work-gallery');
    if (!workGallery) return;

    let html = '';
    
    Object.values(projectsData).forEach(project => {
        if (project.featured) {
            html += `
                <div class="work-item">
                    <h3>${project.title}</h3>
                    <p>${project.description}</p>
                    <a href="${project.link}" target="_blank" rel="noopener noreferrer">View ${project.title.includes('Photography') ? 'Portfolio' : 'Projects'} →</a>
                </div>
            `;
        }
    });
    
    workGallery.innerHTML = html;
}

// Initialize when DOM is loaded
document.addEventListener('DOMContentLoaded', updateWorkGallery);

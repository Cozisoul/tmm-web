// annotations.js v2.0 (Complete)

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
        link: { text: "View Creative Portfolio", url: "#" } // This will link to your future portfolio site
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
    }
};

// --- The rest of the file remains the same ---

const annotationPanel = document.getElementById('annotation-panel');
const annotationContent = annotationPanel.querySelector('.annotation-content');
const annotatedElements = document.querySelectorAll('[data-annotation]');

annotatedElements.forEach(element => {
    element.addEventListener('mouseenter', () => {
        const key = element.getAttribute('data-annotation');
        const data = annotationData[key];

        if (data && annotationContent) {
            let html = `<h3 class="annotation-title">${data.title}</h3>`;
            html += `<p class="annotation-text">${data.text}</p>`;
            if (data.link && data.link.url !== "#") {
                html += `<a href="${data.link.url}" class="annotation-link" target="${data.link.target || '_self'}" rel="noopener noreferrer">${data.link.text}</a>`;
            }
            annotationContent.innerHTML = html;
        }
    });
});
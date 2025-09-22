// Portfolio Update Helper Script
// Run this in your browser console to check your portfolio status

function checkPortfolioStatus() {
    console.log('🔍 Portfolio Status Check');
    console.log('========================');
    
    // Check if all sections are present
    const sections = [
        'identity-header',
        'contact-info', 
        'online-presence',
        'recent-work',
        'cv-download',
        'archive-link'
    ];
    
    sections.forEach(section => {
        const element = document.querySelector(`.${section}`);
        if (element) {
            console.log(`✅ ${section} - Present`);
        } else {
            console.log(`❌ ${section} - Missing`);
        }
    });
    
    // Check annotation system
    const annotations = document.querySelectorAll('[data-annotation]');
    console.log(`📝 Annotations found: ${annotations.length}`);
    
    // Check work items
    const workItems = document.querySelectorAll('.work-item');
    console.log(`💼 Work items: ${workItems.length}`);
    
    // Check image placeholders
    const imagePlaceholders = document.querySelectorAll('.image-placeholder');
    console.log(`🖼️  Image placeholders: ${imagePlaceholders.length}`);
    
    console.log('\n📋 Next Steps:');
    console.log('1. Add your actual images to replace placeholders');
    console.log('2. Update project links with real URLs');
    console.log('3. Add your GitHub repositories');
    console.log('4. Test on mobile devices');
    console.log('5. Check the archive page: /archive.html');
}

// Auto-run the check
if (typeof window !== 'undefined') {
    document.addEventListener('DOMContentLoaded', checkPortfolioStatus);
}

// Export for manual use
if (typeof module !== 'undefined') {
    module.exports = { checkPortfolioStatus };
}

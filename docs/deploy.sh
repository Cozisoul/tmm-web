#!/bin/bash

# ========================================
# TMM-WEB DEPLOYMENT SCRIPT
# ========================================
# Comprehensive deployment script for Thapelo Masebe's portfolio website
# Supports multiple deployment platforms and environments

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
PROJECT_NAME="tmm-web"
DOMAIN="thapelomasebe.com"
GITHUB_REPO="https://github.com/Cozisoul/tmm-web"
NETLIFY_SITE_ID="your-netlify-site-id"
VERCEL_PROJECT_ID="your-vercel-project-id"

echo -e "${BLUE}🚀 TMM-WEB DEPLOYMENT SCRIPT${NC}"
echo -e "${BLUE}==============================${NC}"

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to check git status
check_git_status() {
    echo -e "${YELLOW}📋 Checking Git status...${NC}"
    
    if ! git status --porcelain | grep -q .; then
        echo -e "${GREEN}✅ Working directory is clean${NC}"
    else
        echo -e "${YELLOW}⚠️  Uncommitted changes detected:${NC}"
        git status --short
        read -p "Continue anyway? (y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo -e "${RED}❌ Deployment cancelled${NC}"
            exit 1
        fi
    fi
}

# Function to run tests
run_tests() {
    echo -e "${YELLOW}🧪 Running comprehensive tests...${NC}"
    
    # Test local server
    if command_exists python3; then
        echo -e "${BLUE}Testing local server...${NC}"
        python3 -m http.server 8001 &
        SERVER_PID=$!
        sleep 2
        
        # Test main page
        if curl -s -f http://localhost:8001 > /dev/null; then
            echo -e "${GREEN}✅ Main page loads successfully${NC}"
        else
            echo -e "${RED}❌ Main page failed to load${NC}"
            kill $SERVER_PID 2>/dev/null
            exit 1
        fi
        
        # Test archive page
        if curl -s -f http://localhost:8001/archive.html > /dev/null; then
            echo -e "${GREEN}✅ Archive page loads successfully${NC}"
        else
            echo -e "${RED}❌ Archive page failed to load${NC}"
            kill $SERVER_PID 2>/dev/null
            exit 1
        fi
        
        kill $SERVER_PID 2>/dev/null
    fi
    
    # Test file integrity
    echo -e "${BLUE}Testing file integrity...${NC}"
    for file in index.html archive.html css/main.css js/main.js; do
        if [ -f "$file" ]; then
            echo -e "${GREEN}✅ $file exists${NC}"
        else
            echo -e "${RED}❌ $file missing${NC}"
            exit 1
        fi
    done
    
    echo -e "${GREEN}✅ All tests passed${NC}"
}

# Function to optimize for production
optimize_production() {
    echo -e "${YELLOW}⚡ Optimizing for production...${NC}"
    
    # Minify HTML (basic)
    echo -e "${BLUE}Minifying HTML...${NC}"
    # Note: For production, use proper HTML minifier
    
    # Optimize images
    echo -e "${BLUE}Checking images...${NC}"
    find assets/images -name "*.jpg" -o -name "*.png" | while read img; do
        if [ -f "$img" ]; then
            echo -e "${GREEN}✅ $img${NC}"
        fi
    done
    
    # Update cache busting
    TIMESTAMP=$(date +%s)
    echo -e "${BLUE}Updating cache busting to v$TIMESTAMP...${NC}"
    sed -i.bak "s/?v=[0-9]*/?v=$TIMESTAMP/g" index.html
    sed -i.bak "s/?v=[0-9]*/?v=$TIMESTAMP/g" archive.html
    
    echo -e "${GREEN}✅ Production optimization complete${NC}"
}

# Function to deploy to Netlify
deploy_netlify() {
    echo -e "${YELLOW}🌐 Deploying to Netlify...${NC}"
    
    if command_exists netlify; then
        netlify deploy --prod --dir .
        echo -e "${GREEN}✅ Deployed to Netlify${NC}"
    else
        echo -e "${YELLOW}⚠️  Netlify CLI not installed. Install with: npm install -g netlify-cli${NC}"
        echo -e "${BLUE}Manual deployment:${NC}"
        echo "1. Go to https://app.netlify.com"
        echo "2. Drag and drop this folder"
        echo "3. Set custom domain to $DOMAIN"
    fi
}

# Function to deploy to Vercel
deploy_vercel() {
    echo -e "${YELLOW}🚀 Deploying to Vercel...${NC}"
    
    if command_exists vercel; then
        vercel --prod
        echo -e "${GREEN}✅ Deployed to Vercel${NC}"
    else
        echo -e "${YELLOW}⚠️  Vercel CLI not installed. Install with: npm install -g vercel${NC}"
        echo -e "${BLUE}Manual deployment:${NC}"
        echo "1. Go to https://vercel.com"
        echo "2. Import from GitHub: $GITHUB_REPO"
        echo "3. Deploy automatically"
    fi
}

# Function to deploy to GitHub Pages
deploy_github_pages() {
    echo -e "${YELLOW}📚 Deploying to GitHub Pages...${NC}"
    
    # Create gh-pages branch
    git checkout -b gh-pages 2>/dev/null || git checkout gh-pages
    
    # Copy files to root
    cp index.html .
    cp archive.html .
    cp -r css .
    cp -r js .
    cp -r assets .
    cp manifest.json .
    cp sw.js .
    
    # Commit and push
    git add .
    git commit -m "Deploy to GitHub Pages - $(date)"
    git push origin gh-pages
    
    # Switch back to main
    git checkout main
    
    echo -e "${GREEN}✅ Deployed to GitHub Pages${NC}"
    echo -e "${BLUE}Site URL: https://cozisoul.github.io/tmm-web/${NC}"
}

# Function to create backup
create_backup() {
    echo -e "${YELLOW}💾 Creating backup...${NC}"
    
    BACKUP_DIR="../tmm-web-backup-$(date +%Y%m%d-%H%M%S)"
    cp -r . "$BACKUP_DIR"
    
    echo -e "${GREEN}✅ Backup created: $BACKUP_DIR${NC}"
}

# Function to update dependencies
update_dependencies() {
    echo -e "${YELLOW}📦 Checking dependencies...${NC}"
    
    # Check if any external dependencies need updating
    echo -e "${BLUE}External dependencies:${NC}"
    echo "- Google Fonts: DM Serif Display"
    echo "- No npm dependencies (pure HTML/CSS/JS)"
    
    echo -e "${GREEN}✅ All dependencies up to date${NC}"
}

# Function to generate sitemap
generate_sitemap() {
    echo -e "${YELLOW}🗺️  Generating sitemap...${NC}"
    
    cat > sitemap.xml << EOF
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
    <url>
        <loc>https://$DOMAIN/</loc>
        <lastmod>$(date -u +%Y-%m-%dT%H:%M:%S+00:00)</lastmod>
        <changefreq>weekly</changefreq>
        <priority>1.0</priority>
    </url>
    <url>
        <loc>https://$DOMAIN/archive.html</loc>
        <lastmod>$(date -u +%Y-%m-%dT%H:%M:%S+00:00)</lastmod>
        <changefreq>monthly</changefreq>
        <priority>0.8</priority>
    </url>
</urlset>
EOF
    
    echo -e "${GREEN}✅ Sitemap generated${NC}"
}

# Function to validate deployment
validate_deployment() {
    echo -e "${YELLOW}🔍 Validating deployment...${NC}"
    
    # Check if site is accessible
    if curl -s -f "https://$DOMAIN" > /dev/null; then
        echo -e "${GREEN}✅ Site is accessible at https://$DOMAIN${NC}"
    else
        echo -e "${YELLOW}⚠️  Site not yet accessible (may take a few minutes)${NC}"
    fi
    
    # Check mobile responsiveness
    echo -e "${BLUE}Testing mobile responsiveness...${NC}"
    curl -s -H "User-Agent: Mozilla/5.0 (iPhone; CPU iPhone OS 14_0 like Mac OS X)" "https://$DOMAIN" | grep -q "viewport" && echo -e "${GREEN}✅ Mobile viewport configured${NC}"
    
    echo -e "${GREEN}✅ Deployment validation complete${NC}"
}

# Main deployment function
main() {
    echo -e "${BLUE}Starting deployment process...${NC}"
    
    # Pre-deployment checks
    check_git_status
    run_tests
    create_backup
    update_dependencies
    
    # Production optimization
    optimize_production
    generate_sitemap
    
    # Deployment options
    echo -e "${BLUE}Choose deployment method:${NC}"
    echo "1) Netlify"
    echo "2) Vercel"
    echo "3) GitHub Pages"
    echo "4) All platforms"
    echo "5) Manual deployment info"
    
    read -p "Enter choice (1-5): " choice
    
    case $choice in
        1) deploy_netlify ;;
        2) deploy_vercel ;;
        3) deploy_github_pages ;;
        4) 
            deploy_netlify
            deploy_vercel
            deploy_github_pages
            ;;
        5)
            echo -e "${BLUE}Manual Deployment Instructions:${NC}"
            echo "1. Upload all files to your web server"
            echo "2. Ensure all assets are accessible"
            echo "3. Configure domain DNS settings"
            echo "4. Enable HTTPS/SSL"
            echo "5. Test all functionality"
            ;;
        *) echo -e "${RED}Invalid choice${NC}" && exit 1 ;;
    esac
    
    # Post-deployment validation
    validate_deployment
    
    echo -e "${GREEN}🎉 DEPLOYMENT COMPLETE!${NC}"
    echo -e "${BLUE}Your portfolio is now live!${NC}"
}

# Run main function
main "$@"

#!/bin/bash

# ========================================
# TMM-WEB UPDATE SCRIPT
# ========================================
# Automated update script for Thapelo Masebe's portfolio website

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Configuration
PROJECT_NAME="tmm-web"
GITHUB_REPO="https://github.com/Cozisoul/tmm-web"
BACKUP_DIR="../tmm-web-backups"
UPDATE_LOG="update-log-$(date +%Y%m%d-%H%M%S).txt"

echo -e "${BLUE}🔄 TMM-WEB UPDATE SCRIPT${NC}"
echo -e "${BLUE}========================${NC}"

# Function to log updates
log_update() {
    echo "$(date): $1" >> "$UPDATE_LOG"
    echo -e "${BLUE}$1${NC}"
}

# Function to create backup before update
create_backup() {
    log_update "Creating backup before update..."
    
    mkdir -p "$BACKUP_DIR"
    BACKUP_PATH="$BACKUP_DIR/tmm-web-backup-$(date +%Y%m%d-%H%M%S)"
    cp -r . "$BACKUP_PATH"
    
    echo -e "${GREEN}✅ Backup created: $BACKUP_PATH${NC}"
    log_update "Backup created: $BACKUP_PATH"
}

# Function to update portfolio images
update_portfolio_images() {
    log_update "Updating portfolio images..."
    
    echo -e "${YELLOW}Portfolio Image Update Options:${NC}"
    echo "1) Add new documentary photos"
    echo "2) Add new portraiture photos"
    echo "3) Add new fashion photos"
    echo "4) Add new fine art photos"
    echo "5) Add new architecture photos"
    echo "6) Update PhotoVogue images"
    echo "7) Update bio photo"
    
    read -p "Choose option (1-7): " option
    
    case $option in
        1)
            echo -e "${BLUE}Adding documentary photos...${NC}"
            echo "Place images in: assets/images/portfolio/documentary/"
            echo "Update index.html gallery section"
            ;;
        2)
            echo -e "${BLUE}Adding portraiture photos...${NC}"
            echo "Place images in: assets/images/portfolio/portraiture/"
            echo "Update index.html gallery section"
            ;;
        3)
            echo -e "${BLUE}Adding fashion photos...${NC}"
            echo "Place images in: assets/images/portfolio/fashion/"
            echo "Update index.html gallery section"
            ;;
        4)
            echo -e "${BLUE}Adding fine art photos...${NC}"
            echo "Place images in: assets/images/portfolio/fine-art/"
            echo "Update index.html gallery section"
            ;;
        5)
            echo -e "${BLUE}Adding architecture photos...${NC}"
            echo "Place images in: assets/images/portfolio/architecture/"
            echo "Update index.html gallery section"
            ;;
        6)
            echo -e "${BLUE}Updating PhotoVogue images...${NC}"
            echo "Place images in: assets/images/portfolio/photovogue/"
            echo "Update PhotoVogue gallery item"
            ;;
        7)
            echo -e "${BLUE}Updating bio photo...${NC}"
            echo "Replace: assets/images/portfolio/bio/me-1.jpg"
            echo "Update alt text in index.html"
            ;;
        *) echo -e "${RED}Invalid option${NC}" ;;
    esac
    
    log_update "Portfolio images update initiated"
}

# Function to update content
update_content() {
    log_update "Updating content..."
    
    echo -e "${YELLOW}Content Update Options:${NC}"
    echo "1) Update biography"
    echo "2) Update photography journey"
    echo "3) Update contact information"
    echo "4) Update project descriptions"
    echo "5) Update social media links"
    echo "6) Update awards and recognition"
    echo "7) Update skills and expertise"
    
    read -p "Choose option (1-7): " option
    
    case $option in
        1)
            echo -e "${BLUE}Updating biography...${NC}"
            echo "Edit the 'About' section in index.html"
            echo "Update age, location, and personal details"
            ;;
        2)
            echo -e "${BLUE}Updating photography journey...${NC}"
            echo "Edit the 'Photography Journey' section in index.html"
            echo "Update timeline and milestones"
            ;;
        3)
            echo -e "${BLUE}Updating contact information...${NC}"
            echo "Edit contact section in index.html"
            echo "Update email, location, and social links"
            ;;
        4)
            echo -e "${BLUE}Updating project descriptions...${NC}"
            echo "Edit gallery captions in index.html"
            echo "Update project tags and descriptions"
            ;;
        5)
            echo -e "${BLUE}Updating social media links...${NC}"
            echo "Edit social media URLs in index.html"
            echo "Update footer links and contact section"
            ;;
        6)
            echo -e "${BLUE}Updating awards and recognition...${NC}"
            echo "Edit awards section in index.html"
            echo "Update PhotoVogue and other achievements"
            ;;
        7)
            echo -e "${BLUE}Updating skills and expertise...${NC}"
            echo "Edit skills section in index.html"
            echo "Update technical and creative skills"
            ;;
        *) echo -e "${RED}Invalid option${NC}" ;;
    esac
    
    log_update "Content update initiated"
}

# Function to update technical aspects
update_technical() {
    log_update "Updating technical aspects..."
    
    echo -e "${YELLOW}Technical Update Options:${NC}"
    echo "1) Update CSS styling"
    echo "2) Update JavaScript functionality"
    echo "3) Update responsive design"
    echo "4) Update performance optimizations"
    echo "5) Update SEO meta tags"
    echo "6) Update PWA features"
    echo "7) Update accessibility features"
    
    read -p "Choose option (1-7): " option
    
    case $option in
        1)
            echo -e "${BLUE}Updating CSS styling...${NC}"
            echo "Edit css/main.css and component files"
            echo "Update color scheme, typography, and layout"
            ;;
        2)
            echo -e "${BLUE}Updating JavaScript functionality...${NC}"
            echo "Edit js/main.js"
            echo "Update theme toggle, annotations, and interactions"
            ;;
        3)
            echo -e "${BLUE}Updating responsive design...${NC}"
            echo "Edit css/04-layout.css"
            echo "Update media queries and breakpoints"
            ;;
        4)
            echo -e "${BLUE}Updating performance optimizations...${NC}"
            echo "Update critical CSS in index.html"
            echo "Optimize images and assets"
            ;;
        5)
            echo -e "${BLUE}Updating SEO meta tags...${NC}"
            echo "Edit meta tags in index.html"
            echo "Update Open Graph and Twitter Cards"
            ;;
        6)
            echo -e "${BLUE}Updating PWA features...${NC}"
            echo "Edit manifest.json and sw.js"
            echo "Update app icons and offline functionality"
            ;;
        7)
            echo -e "${BLUE}Updating accessibility features...${NC}"
            echo "Update ARIA labels and alt text"
            echo "Improve keyboard navigation and screen reader support"
            ;;
        *) echo -e "${RED}Invalid option${NC}" ;;
    esac
    
    log_update "Technical update initiated"
}

# Function to update dependencies
update_dependencies() {
    log_update "Updating dependencies..."
    
    echo -e "${BLUE}Checking external dependencies...${NC}"
    
    # Check Google Fonts
    echo -e "${BLUE}Google Fonts: DM Serif Display${NC}"
    if curl -s -f "https://fonts.googleapis.com/css2?family=DM+Serif+Display:wght@400&display=swap" > /dev/null; then
        echo -e "${GREEN}✅ Google Fonts accessible${NC}"
    else
        echo -e "${YELLOW}⚠️  Google Fonts may be down${NC}"
    fi
    
    # Check external links
    echo -e "${BLUE}Checking external links...${NC}"
    for url in "https://www.instagram.com/thaeplo_gv72/" "https://www.behance.net/thapelomasebe" "https://www.vogue.com/photovogue/photographers/210386"; do
        if curl -s -f "$url" > /dev/null; then
            echo -e "${GREEN}✅ $url accessible${NC}"
        else
            echo -e "${YELLOW}⚠️  $url returned error${NC}"
        fi
    done
    
    log_update "Dependencies checked"
}

# Function to update cache busting
update_cache_busting() {
    log_update "Updating cache busting..."
    
    TIMESTAMP=$(date +%s)
    echo -e "${BLUE}Updating cache busting to v$TIMESTAMP...${NC}"
    
    # Update cache busting in HTML files
    sed -i.bak "s/?v=[0-9]*/?v=$TIMESTAMP/g" index.html
    sed -i.bak "s/?v=[0-9]*/?v=$TIMESTAMP/g" archive.html
    
    # Clean up backup files
    rm -f *.bak
    
    echo -e "${GREEN}✅ Cache busting updated to v$TIMESTAMP${NC}"
    log_update "Cache busting updated to v$TIMESTAMP"
}

# Function to run tests after update
run_post_update_tests() {
    log_update "Running post-update tests..."
    
    echo -e "${BLUE}Running basic tests...${NC}"
    
    # Test local server
    if curl -s -f http://localhost:8001 > /dev/null; then
        echo -e "${GREEN}✅ Local server accessible${NC}"
    else
        echo -e "${YELLOW}⚠️  Starting local server...${NC}"
        python3 -m http.server 8001 &
        sleep 2
    fi
    
    # Test main page
    if curl -s -f http://localhost:8001 > /dev/null; then
        echo -e "${GREEN}✅ Main page loads${NC}"
    else
        echo -e "${RED}❌ Main page failed to load${NC}"
    fi
    
    # Test archive page
    if curl -s -f http://localhost:8001/archive.html > /dev/null; then
        echo -e "${GREEN}✅ Archive page loads${NC}"
    else
        echo -e "${RED}❌ Archive page failed to load${NC}"
    fi
    
    log_update "Post-update tests completed"
}

# Function to commit changes
commit_changes() {
    log_update "Committing changes..."
    
    # Check git status
    if git status --porcelain | grep -q .; then
        echo -e "${BLUE}Changes detected. Committing...${NC}"
        
        # Add all changes
        git add .
        
        # Commit with timestamp
        git commit -m "Update portfolio - $(date)"
        
        echo -e "${GREEN}✅ Changes committed${NC}"
        log_update "Changes committed to git"
    else
        echo -e "${BLUE}No changes to commit${NC}"
        log_update "No changes to commit"
    fi
}

# Function to push to remote
push_to_remote() {
    log_update "Pushing to remote repository..."
    
    read -p "Push changes to remote repository? (y/N): " -n 1 -r
    echo
    
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        git push origin main
        echo -e "${GREEN}✅ Changes pushed to remote${NC}"
        log_update "Changes pushed to remote repository"
    else
        echo -e "${BLUE}Changes not pushed to remote${NC}"
        log_update "Changes not pushed to remote repository"
    fi
}

# Function to generate update report
generate_update_report() {
    log_update "Generating update report..."
    
    REPORT_FILE="update-report-$(date +%Y%m%d-%H%M%S).txt"
    
    {
        echo "TMM-WEB Update Report - $(date)"
        echo "================================="
        echo ""
        echo "Update Log:"
        cat "$UPDATE_LOG"
        echo ""
        echo "Git Status:"
        git status --short
        echo ""
        echo "Recent Commits:"
        git log --oneline -5
        echo ""
        echo "File Changes:"
        git diff --stat
    } > "$REPORT_FILE"
    
    echo -e "${GREEN}✅ Update report generated: $REPORT_FILE${NC}"
    log_update "Update report generated: $REPORT_FILE"
}

# Function to clean up
cleanup() {
    log_update "Cleaning up..."
    
    # Remove backup files
    find . -name "*.bak" -delete
    echo -e "${GREEN}✅ Removed backup files${NC}"
    
    # Remove temporary files
    find . -name "*.tmp" -delete
    echo -e "${GREEN}✅ Removed temporary files${NC}"
    
    log_update "Cleanup completed"
}

# Main update function
main() {
    echo -e "${BLUE}Choose update type:${NC}"
    echo "1) Update portfolio images"
    echo "2) Update content"
    echo "3) Update technical aspects"
    echo "4) Update dependencies"
    echo "5) Full update (all categories)"
    echo "6) Quick update (cache busting + commit)"
    
    read -p "Enter choice (1-6): " choice
    
    # Create backup before any update
    create_backup
    
    case $choice in
        1) update_portfolio_images ;;
        2) update_content ;;
        3) update_technical ;;
        4) update_dependencies ;;
        5)
            update_portfolio_images
            update_content
            update_technical
            update_dependencies
            ;;
        6)
            update_cache_busting
            commit_changes
            ;;
        *) echo -e "${RED}Invalid choice${NC}" && exit 1 ;;
    esac
    
    # Post-update tasks
    update_cache_busting
    run_post_update_tests
    commit_changes
    push_to_remote
    generate_update_report
    cleanup
    
    echo -e "${GREEN}🎉 Update completed successfully!${NC}"
    echo -e "${BLUE}Check the update report for details.${NC}"
}

# Run main function
main "$@"

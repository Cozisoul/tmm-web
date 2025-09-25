#!/bin/bash

# ========================================
# TMM-WEB MAINTENANCE SCRIPT
# ========================================
# Comprehensive maintenance and monitoring script for Thapelo Masebe's portfolio

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Configuration
PROJECT_NAME="tmm-web"
DOMAIN="thapelomasebe.com"
LOCAL_PORT="8001"
BACKUP_DIR="../tmm-web-backups"

echo -e "${BLUE}🔧 TMM-WEB MAINTENANCE SCRIPT${NC}"
echo -e "${BLUE}================================${NC}"

# Function to check site health
check_site_health() {
    echo -e "${YELLOW}🏥 Checking site health...${NC}"
    
    # Check local server
    if curl -s -f "http://localhost:$LOCAL_PORT" > /dev/null; then
        echo -e "${GREEN}✅ Local server running${NC}"
    else
        echo -e "${RED}❌ Local server not running${NC}"
        echo -e "${BLUE}Starting local server...${NC}"
        python3 -m http.server $LOCAL_PORT &
        sleep 2
    fi
    
    # Check all pages
    for page in "" "archive.html"; do
        if curl -s -f "http://localhost:$LOCAL_PORT/$page" > /dev/null; then
            echo -e "${GREEN}✅ $page loads successfully${NC}"
        else
            echo -e "${RED}❌ $page failed to load${NC}"
        fi
    done
    
    # Check external links
    echo -e "${BLUE}Checking external links...${NC}"
    for url in "https://www.instagram.com/thaeplo_gv72/" "https://www.behance.net/thapelomasebe" "https://www.vogue.com/photovogue/photographers/210386"; do
        if curl -s -f "$url" > /dev/null; then
            echo -e "${GREEN}✅ $url accessible${NC}"
        else
            echo -e "${YELLOW}⚠️  $url returned error${NC}"
        fi
    done
}

# Function to update content
update_content() {
    echo -e "${YELLOW}📝 Content update options:${NC}"
    echo "1) Update portfolio images"
    echo "2) Update biography text"
    echo "3) Update contact information"
    echo "4) Update project descriptions"
    echo "5) Add new project"
    echo "6) Update social media links"
    
    read -p "Choose option (1-6): " option
    
    case $option in
        1)
            echo -e "${BLUE}Updating portfolio images...${NC}"
            echo "Place new images in assets/images/portfolio/[category]/"
            echo "Update image references in index.html"
            ;;
        2)
            echo -e "${BLUE}Updating biography...${NC}"
            echo "Edit the biography section in index.html"
            echo "Update the 'About' section content"
            ;;
        3)
            echo -e "${BLUE}Updating contact info...${NC}"
            echo "Edit contact information in index.html"
            echo "Update email, location, and social links"
            ;;
        4)
            echo -e "${BLUE}Updating project descriptions...${NC}"
            echo "Edit project descriptions in index.html"
            echo "Update gallery captions and project tags"
            ;;
        5)
            echo -e "${BLUE}Adding new project...${NC}"
            echo "1. Add image to assets/images/portfolio/[category]/"
            echo "2. Add gallery item to index.html"
            echo "3. Update project tags and descriptions"
            ;;
        6)
            echo -e "${BLUE}Updating social media links...${NC}"
            echo "Edit social media URLs in index.html"
            echo "Update footer links and contact section"
            ;;
        *) echo -e "${RED}Invalid option${NC}" ;;
    esac
}

# Function to backup site
backup_site() {
    echo -e "${YELLOW}💾 Creating site backup...${NC}"
    
    # Create backup directory
    mkdir -p "$BACKUP_DIR"
    
    # Create timestamped backup
    TIMESTAMP=$(date +%Y%m%d-%H%M%S)
    BACKUP_PATH="$BACKUP_DIR/tmm-web-backup-$TIMESTAMP"
    
    cp -r . "$BACKUP_PATH"
    
    echo -e "${GREEN}✅ Backup created: $BACKUP_PATH${NC}"
    
    # Clean old backups (keep last 10)
    cd "$BACKUP_DIR"
    ls -t | tail -n +11 | xargs -r rm -rf
    cd - > /dev/null
    
    echo -e "${BLUE}Cleaned old backups (kept last 10)${NC}"
}

# Function to restore from backup
restore_backup() {
    echo -e "${YELLOW}🔄 Available backups:${NC}"
    
    if [ ! -d "$BACKUP_DIR" ]; then
        echo -e "${RED}No backup directory found${NC}"
        return
    fi
    
    # List available backups
    ls -la "$BACKUP_DIR" | grep "tmm-web-backup-" | awk '{print $9, $6, $7, $8}'
    
    read -p "Enter backup name to restore: " backup_name
    
    if [ -d "$BACKUP_DIR/$backup_name" ]; then
        echo -e "${BLUE}Restoring from $backup_name...${NC}"
        cp -r "$BACKUP_DIR/$backup_name"/* .
        echo -e "${GREEN}✅ Restore complete${NC}"
    else
        echo -e "${RED}Backup not found${NC}"
    fi
}

# Function to optimize images
optimize_images() {
    echo -e "${YELLOW}🖼️  Optimizing images...${NC}"
    
    # Check if imagemagick is available
    if command -v convert >/dev/null 2>&1; then
        echo -e "${BLUE}Optimizing images with ImageMagick...${NC}"
        
        find assets/images -name "*.jpg" -o -name "*.png" | while read img; do
            echo -e "${BLUE}Optimizing $img...${NC}"
            convert "$img" -quality 85 -strip "$img.optimized"
            mv "$img.optimized" "$img"
        done
        
        echo -e "${GREEN}✅ Images optimized${NC}"
    else
        echo -e "${YELLOW}⚠️  ImageMagick not installed. Install with: brew install imagemagick${NC}"
        echo -e "${BLUE}Manual optimization:${NC}"
        echo "1. Use online tools like TinyPNG or Squoosh"
        echo "2. Compress images to 85% quality"
        echo "3. Use WebP format for better compression"
    fi
}

# Function to check performance
check_performance() {
    echo -e "${YELLOW}⚡ Checking performance...${NC}"
    
    # Test page load time
    START_TIME=$(date +%s%N)
    curl -s "http://localhost:$LOCAL_PORT" > /dev/null
    END_TIME=$(date +%s%N)
    LOAD_TIME=$(( (END_TIME - START_TIME) / 1000000 ))
    
    echo -e "${BLUE}Page load time: ${LOAD_TIME}ms${NC}"
    
    if [ $LOAD_TIME -lt 1000 ]; then
        echo -e "${GREEN}✅ Excellent performance${NC}"
    elif [ $LOAD_TIME -lt 3000 ]; then
        echo -e "${YELLOW}⚠️  Good performance${NC}"
    else
        echo -e "${RED}❌ Slow performance - consider optimization${NC}"
    fi
    
    # Check file sizes
    echo -e "${BLUE}File sizes:${NC}"
    du -h index.html archive.html css/main.css js/main.js 2>/dev/null | while read size file; do
        echo -e "${BLUE}$file: $size${NC}"
    done
    
    # Check image sizes
    echo -e "${BLUE}Image sizes:${NC}"
    find assets/images -name "*.jpg" -o -name "*.png" | head -5 | while read img; do
        size=$(du -h "$img" | cut -f1)
        echo -e "${BLUE}$img: $size${NC}"
    done
}

# Function to update cache busting
update_cache_busting() {
    echo -e "${YELLOW}🔄 Updating cache busting...${NC}"
    
    TIMESTAMP=$(date +%s)
    echo -e "${BLUE}Updating to version $TIMESTAMP...${NC}"
    
    # Update cache busting in HTML files
    sed -i.bak "s/?v=[0-9]*/?v=$TIMESTAMP/g" index.html
    sed -i.bak "s/?v=[0-9]*/?v=$TIMESTAMP/g" archive.html
    
    # Clean up backup files
    rm -f *.bak
    
    echo -e "${GREEN}✅ Cache busting updated${NC}"
}

# Function to check for broken links
check_broken_links() {
    echo -e "${YELLOW}🔗 Checking for broken links...${NC}"
    
    # Check internal links
    echo -e "${BLUE}Checking internal links...${NC}"
    for page in "" "archive.html"; do
        if curl -s -f "http://localhost:$LOCAL_PORT/$page" > /dev/null; then
            echo -e "${GREEN}✅ $page accessible${NC}"
        else
            echo -e "${RED}❌ $page broken${NC}"
        fi
    done
    
    # Check external links
    echo -e "${BLUE}Checking external links...${NC}"
    curl -s "http://localhost:$LOCAL_PORT" | grep -o 'href="http[^"]*"' | sed 's/href="//;s/"//' | while read url; do
        if curl -s -f "$url" > /dev/null; then
            echo -e "${GREEN}✅ $url working${NC}"
        else
            echo -e "${RED}❌ $url broken${NC}"
        fi
    done
}

# Function to generate analytics report
generate_analytics() {
    echo -e "${YELLOW}📊 Generating analytics report...${NC}"
    
    REPORT_FILE="analytics-report-$(date +%Y%m%d).txt"
    
    {
        echo "TMM-WEB Analytics Report - $(date)"
        echo "=================================="
        echo ""
        echo "Site Health:"
        curl -s -f "http://localhost:$LOCAL_PORT" > /dev/null && echo "✅ Main page: OK" || echo "❌ Main page: ERROR"
        curl -s -f "http://localhost:$LOCAL_PORT/archive.html" > /dev/null && echo "✅ Archive page: OK" || echo "❌ Archive page: ERROR"
        echo ""
        echo "File Sizes:"
        du -h index.html archive.html css/main.css js/main.js 2>/dev/null
        echo ""
        echo "Image Count:"
        find assets/images -name "*.jpg" -o -name "*.png" | wc -l | xargs echo "Total images:"
        echo ""
        echo "External Links:"
        curl -s "http://localhost:$LOCAL_PORT" | grep -o 'href="http[^"]*"' | wc -l | xargs echo "External links:"
        echo ""
        echo "Performance:"
        START_TIME=$(date +%s%N)
        curl -s "http://localhost:$LOCAL_PORT" > /dev/null
        END_TIME=$(date +%s%N)
        LOAD_TIME=$(( (END_TIME - START_TIME) / 1000000 ))
        echo "Load time: ${LOAD_TIME}ms"
    } > "$REPORT_FILE"
    
    echo -e "${GREEN}✅ Analytics report saved: $REPORT_FILE${NC}"
}

# Function to clean up
cleanup() {
    echo -e "${YELLOW}🧹 Cleaning up...${NC}"
    
    # Remove backup files
    find . -name "*.bak" -delete
    echo -e "${GREEN}✅ Removed backup files${NC}"
    
    # Remove temporary files
    find . -name "*.tmp" -delete
    echo -e "${GREEN}✅ Removed temporary files${NC}"
    
    # Clean up old logs
    find . -name "*.log" -mtime +7 -delete
    echo -e "${GREEN}✅ Cleaned old log files${NC}"
}

# Main menu
main_menu() {
    echo -e "${BLUE}Choose maintenance task:${NC}"
    echo "1) Check site health"
    echo "2) Update content"
    echo "3) Backup site"
    echo "4) Restore from backup"
    echo "5) Optimize images"
    echo "6) Check performance"
    echo "7) Update cache busting"
    echo "8) Check broken links"
    echo "9) Generate analytics report"
    echo "10) Clean up"
    echo "11) Run all checks"
    echo "0) Exit"
    
    read -p "Enter choice (0-11): " choice
    
    case $choice in
        1) check_site_health ;;
        2) update_content ;;
        3) backup_site ;;
        4) restore_backup ;;
        5) optimize_images ;;
        6) check_performance ;;
        7) update_cache_busting ;;
        8) check_broken_links ;;
        9) generate_analytics ;;
        10) cleanup ;;
        11)
            check_site_health
            check_performance
            check_broken_links
            generate_analytics
            ;;
        0) echo -e "${GREEN}Goodbye!${NC}" && exit 0 ;;
        *) echo -e "${RED}Invalid choice${NC}" && main_menu ;;
    esac
}

# Run main menu
main_menu

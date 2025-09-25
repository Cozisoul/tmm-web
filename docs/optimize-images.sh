#!/bin/bash

# Image Optimization Script
# TMM-OS Design System v4.0

echo "🖼️  Starting Image Optimization..."
echo "=================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check if ImageMagick is installed
if ! command -v convert >/dev/null 2>&1; then
    echo -e "${YELLOW}⚠️  ImageMagick not found. Installing...${NC}"
    
    # Try to install ImageMagick based on OS
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        if command -v brew >/dev/null 2>&1; then
            brew install imagemagick
        else
            echo -e "${RED}❌ Homebrew not found. Please install ImageMagick manually.${NC}"
            exit 1
        fi
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Linux
        if command -v apt-get >/dev/null 2>&1; then
            sudo apt-get update && sudo apt-get install -y imagemagick
        elif command -v yum >/dev/null 2>&1; then
            sudo yum install -y ImageMagick
        else
            echo -e "${RED}❌ Package manager not found. Please install ImageMagick manually.${NC}"
            exit 1
        fi
    else
        echo -e "${RED}❌ Unsupported OS. Please install ImageMagick manually.${NC}"
        exit 1
    fi
fi

# Function to optimize image
optimize_image() {
    local input="$1"
    local output="$2"
    local max_width="$3"
    local quality="$4"
    
    if [ -f "$input" ]; then
        echo -e "${BLUE}🔄 Optimizing: $(basename "$input")${NC}"
        
        # Get original size
        original_size=$(stat -f%z "$input" 2>/dev/null || stat -c%s "$input" 2>/dev/null)
        
        # Optimize image
        convert "$input" \
            -resize "${max_width}x${max_width}>" \
            -quality "$quality" \
            -strip \
            -interlace Plane \
            "$output"
        
        # Get new size
        new_size=$(stat -f%z "$output" 2>/dev/null || stat -c%s "$output" 2>/dev/null)
        
        # Calculate savings
        savings=$((original_size - new_size))
        savings_percent=$((savings * 100 / original_size))
        
        if [ $savings -gt 0 ]; then
            echo -e "${GREEN}✅ Optimized: $(basename "$input") - Saved $savings bytes ($savings_percent%)${NC}"
        else
            echo -e "${YELLOW}⚠️  No optimization needed: $(basename "$input")${NC}"
        fi
    else
        echo -e "${RED}❌ File not found: $input${NC}"
    fi
}

# Create backup directory
mkdir -p assets/images/portfolio/backup
echo -e "${BLUE}📁 Created backup directory${NC}"

# Backup original images
echo -e "${BLUE}💾 Backing up original images...${NC}"
cp -r assets/images/portfolio/* assets/images/portfolio/backup/ 2>/dev/null || true

# Optimize portfolio images
echo -e "\n${BLUE}🎨 Optimizing Portfolio Images${NC}"
echo "================================"

# Profile photo
optimize_image "assets/images/portfolio/bio/me-1.jpg" "assets/images/portfolio/bio/me-1.jpg" 400 85

# Documentary
optimize_image "assets/images/portfolio/documentary/life-as-it-happens-2.jpg" "assets/images/portfolio/documentary/life-as-it-happens-2.jpg" 800 85

# Portraiture
optimize_image "assets/images/portfolio/portraiture/amaqamata-1.jpg" "assets/images/portfolio/portraiture/amaqamata-1.jpg" 800 85

# Fashion (this one was large)
optimize_image "assets/images/portfolio/fashion/vans-editorial-1.jpg" "assets/images/portfolio/fashion/vans-editorial-1.jpg" 800 80

# Fine Art
optimize_image "assets/images/portfolio/fine-art/reading-genesis-art-series-3.jpg" "assets/images/portfolio/fine-art/reading-genesis-art-series-3.jpg" 800 85

# Architecture
optimize_image "assets/images/portfolio/architecture/untitled-01-city-skyline-installation-1.jpg" "assets/images/portfolio/architecture/untitled-01-city-skyline-installation-1.jpg" 800 85

# PhotoVogue (this one was large)
optimize_image "assets/images/portfolio/photovogue/0.jpg" "assets/images/portfolio/photovogue/0.jpg" 600 80

# Create WebP versions for better compression
echo -e "\n${BLUE}🌐 Creating WebP versions${NC}"
echo "=========================="

create_webp() {
    local input="$1"
    local output="${input%.*}.webp"
    
    if [ -f "$input" ]; then
        echo -e "${BLUE}🔄 Creating WebP: $(basename "$output")${NC}"
        convert "$input" -quality 85 "$output"
        
        # Check if WebP is smaller
        original_size=$(stat -f%z "$input" 2>/dev/null || stat -c%s "$input" 2>/dev/null)
        webp_size=$(stat -f%z "$output" 2>/dev/null || stat -c%s "$output" 2>/dev/null)
        
        if [ $webp_size -lt $original_size ]; then
            echo -e "${GREEN}✅ WebP created: $(basename "$output") - $(($original_size - $webp_size)) bytes saved${NC}"
        else
            echo -e "${YELLOW}⚠️  WebP not smaller, keeping original${NC}"
            rm "$output"
        fi
    fi
}

# Create WebP versions
create_webp "assets/images/portfolio/bio/me-1.jpg"
create_webp "assets/images/portfolio/documentary/life-as-it-happens-2.jpg"
create_webp "assets/images/portfolio/portraiture/amaqamata-1.jpg"
create_webp "assets/images/portfolio/fashion/vans-editorial-1.jpg"
create_webp "assets/images/portfolio/fine-art/reading-genesis-art-series-3.jpg"
create_webp "assets/images/portfolio/architecture/untitled-01-city-skyline-installation-1.jpg"
create_webp "assets/images/portfolio/photovogue/0.jpg"

# Generate responsive image sizes
echo -e "\n${BLUE}📱 Generating responsive image sizes${NC}"
echo "====================================="

generate_responsive() {
    local input="$1"
    local base_name="${input%.*}"
    local extension="${input##*.}"
    
    if [ -f "$input" ]; then
        echo -e "${BLUE}🔄 Generating responsive sizes for: $(basename "$input")${NC}"
        
        # Small (mobile)
        convert "$input" -resize 400x400^ -gravity center -crop 400x400+0+0 "${base_name}-small.${extension}" 2>/dev/null || true
        
        # Medium (tablet)
        convert "$input" -resize 800x800^ -gravity center -crop 800x800+0+0 "${base_name}-medium.${extension}" 2>/dev/null || true
        
        # Large (desktop)
        convert "$input" -resize 1200x1200^ -gravity center -crop 1200x1200+0+0 "${base_name}-large.${extension}" 2>/dev/null || true
        
        echo -e "${GREEN}✅ Responsive sizes created for: $(basename "$input")${NC}"
    fi
}

# Generate responsive sizes for key images
generate_responsive "assets/images/portfolio/bio/me-1.jpg"
generate_responsive "assets/images/portfolio/documentary/life-as-it-happens-2.jpg"
generate_responsive "assets/images/portfolio/portraiture/amaqamata-1.jpg"

# Create image manifest
echo -e "\n${BLUE}📋 Creating image manifest${NC}"
echo "============================"

cat > assets/images/manifest.json << EOF
{
  "images": [
    {
      "src": "portfolio/bio/me-1.jpg",
      "alt": "Thapelo Madiba Masebe - Portrait",
      "sizes": ["400x400", "800x800", "1200x1200"],
      "formats": ["jpg", "webp"]
    },
    {
      "src": "portfolio/documentary/life-as-it-happens-2.jpg",
      "alt": "Documentary photography - Life as it happens",
      "sizes": ["400x400", "800x800", "1200x1200"],
      "formats": ["jpg", "webp"]
    },
    {
      "src": "portfolio/portraiture/amaqamata-1.jpg",
      "alt": "Portraiture - Amaqamata series",
      "sizes": ["400x400", "800x800", "1200x1200"],
      "formats": ["jpg", "webp"]
    },
    {
      "src": "portfolio/fashion/vans-editorial-1.jpg",
      "alt": "Fashion photography - Vans editorial",
      "sizes": ["800x800"],
      "formats": ["jpg", "webp"]
    },
    {
      "src": "portfolio/fine-art/reading-genesis-art-series-3.jpg",
      "alt": "Fine art photography - Reading Genesis series",
      "sizes": ["800x800"],
      "formats": ["jpg", "webp"]
    },
    {
      "src": "portfolio/architecture/untitled-01-city-skyline-installation-1.jpg",
      "alt": "Architecture photography - City skyline installation",
      "sizes": ["800x800"],
      "formats": ["jpg", "webp"]
    },
    {
      "src": "portfolio/photovogue/0.jpg",
      "alt": "Thapelo Masebe - Black and white portrait, PhotoVogue featured work",
      "sizes": ["600x600"],
      "formats": ["jpg", "webp"]
    }
  ],
  "lastUpdated": "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
}
EOF

echo -e "${GREEN}✅ Image manifest created${NC}"

# Summary
echo -e "\n${BLUE}📊 OPTIMIZATION SUMMARY${NC}"
echo "========================"

total_original=0
total_optimized=0

for img in assets/images/portfolio/*/*.jpg; do
    if [ -f "$img" ]; then
        original_size=$(stat -f%z "$img" 2>/dev/null || stat -c%s "$img" 2>/dev/null)
        total_original=$((total_original + original_size))
        total_optimized=$((total_optimized + original_size))
    fi
done

echo -e "${GREEN}✅ Image optimization complete!${NC}"
echo -e "${BLUE}📁 Original images backed up to: assets/images/portfolio/backup/${NC}"
echo -e "${BLUE}📋 Image manifest created: assets/images/manifest.json${NC}"

# Check if we can run the test again
if [ -f "test-comprehensive.sh" ]; then
    echo -e "\n${BLUE}🧪 Running performance test...${NC}"
    ./test-comprehensive.sh | grep -A 20 "PERFORMANCE TESTS"
fi

echo -e "\n${GREEN}🎉 Image optimization complete!${NC}"

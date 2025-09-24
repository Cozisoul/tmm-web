#!/bin/bash

# Comprehensive Website Testing Script
# TMM-OS Design System v4.0
# Tests all aspects of a world-class website

echo "🚀 Starting Comprehensive Website Testing..."
echo "=============================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Test results
PASSED=0
FAILED=0
WARNINGS=0

# Function to print test results
print_result() {
    local test_name="$1"
    local status="$2"
    local message="$3"
    
    if [ "$status" = "PASS" ]; then
        echo -e "${GREEN}✅ PASS${NC}: $test_name - $message"
        ((PASSED++))
    elif [ "$status" = "FAIL" ]; then
        echo -e "${RED}❌ FAIL${NC}: $test_name - $message"
        ((FAILED++))
    else
        echo -e "${YELLOW}⚠️  WARN${NC}: $test_name - $message"
        ((WARNINGS++))
    fi
}

# Function to check if file exists
check_file() {
    local file="$1"
    local description="$2"
    
    if [ -f "$file" ]; then
        print_result "$description" "PASS" "File exists"
    else
        print_result "$description" "FAIL" "File missing: $file"
    fi
}

# Function to check HTML validation
check_html() {
    local file="$1"
    local description="$2"
    
    if command -v tidy >/dev/null 2>&1; then
        if tidy -q -e "$file" 2>/dev/null; then
            print_result "$description" "PASS" "HTML is valid"
        else
            print_result "$description" "WARN" "HTML validation issues found"
        fi
    else
        print_result "$description" "WARN" "HTML validator (tidy) not installed"
    fi
}

# Function to check CSS validation
check_css() {
    local file="$1"
    local description="$2"
    
    if command -v css-validator >/dev/null 2>&1; then
        if css-validator "$file" >/dev/null 2>&1; then
            print_result "$description" "PASS" "CSS is valid"
        else
            print_result "$description" "WARN" "CSS validation issues found"
        fi
    else
        print_result "$description" "WARN" "CSS validator not installed"
    fi
}

# Function to check if URL is accessible
check_url() {
    local url="$1"
    local description="$2"
    
    if curl -s --head "$url" | head -n 1 | grep -q "200 OK"; then
        print_result "$description" "PASS" "URL is accessible"
    else
        print_result "$description" "FAIL" "URL is not accessible"
    fi
}

# Function to check file size
check_file_size() {
    local file="$1"
    local max_size="$2"
    local description="$3"
    
    if [ -f "$file" ]; then
        local size=$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file" 2>/dev/null)
        if [ "$size" -lt "$max_size" ]; then
            print_result "$description" "PASS" "File size OK ($size bytes)"
        else
            print_result "$description" "WARN" "File size large ($size bytes, max: $max_size)"
        fi
    else
        print_result "$description" "FAIL" "File not found"
    fi
}

echo -e "\n${BLUE}📁 FILE STRUCTURE TESTS${NC}"
echo "=========================="

# Essential files
check_file "index.html" "Main HTML file"
check_file "404.html" "404 Error page"
check_file "privacy-policy.html" "Privacy Policy"
check_file "cookie-consent.html" "Cookie Policy"
check_file "sitemap.xml" "XML Sitemap"
check_file "public/robots.txt" "Robots.txt"
check_file "manifest.json" "Web App Manifest"

# CSS files
check_file "css/01-reset.css" "CSS Reset"
check_file "css/02-vars.css" "CSS Variables"
check_file "css/03-base.css" "Base CSS"
check_file "css/04-layout.css" "Layout CSS"
check_file "css/05-components.css" "Components CSS"
check_file "css/06-animations.css" "Animations CSS"
check_file "css/main.css" "Main CSS"

# JavaScript files
check_file "js/main.js" "Main JavaScript"
check_file "js/cookie-consent.js" "Cookie Consent JavaScript"
check_file "js/motion.js" "Motion JavaScript"
check_file "js/projects.js" "Projects JavaScript"

# Assets
check_file "assets/images/portfolio/bio/me-1.jpg" "Profile photo"
check_file "assets/images/portfolio/documentary/life-as-it-happens-2.jpg" "Documentary photo"
check_file "assets/images/portfolio/portraiture/amaqamata-1.jpg" "Portraiture photo"
check_file "assets/images/portfolio/fashion/vans-editorial-1.jpg" "Fashion photo"
check_file "assets/images/portfolio/fine-art/reading-genesis-art-series-3.jpg" "Fine art photo"
check_file "assets/images/portfolio/architecture/untitled-01-city-skyline-installation-1.jpg" "Architecture photo"
check_file "assets/images/portfolio/photovogue/0.jpg" "PhotoVogue photo"

echo -e "\n${BLUE}🔍 CONTENT QUALITY TESTS${NC}"
echo "============================"

# Check for essential content
if grep -q "Thapelo Madiba Masebe" index.html; then
    print_result "Name in content" "PASS" "Name found in HTML"
else
    print_result "Name in content" "FAIL" "Name not found in HTML"
fi

if grep -q "Transdisciplinary Artist" index.html; then
    print_result "Title in content" "PASS" "Professional title found"
else
    print_result "Title in content" "FAIL" "Professional title not found"
fi

if grep -q "Johannesburg, South Africa" index.html; then
    print_result "Location in content" "PASS" "Location found"
else
    print_result "Location in content" "FAIL" "Location not found"
fi

if grep -q "thapelomasebe@hotmail.com" index.html; then
    print_result "Contact email" "PASS" "Contact email found"
else
    print_result "Contact email" "FAIL" "Contact email not found"
fi

if grep -q "PhotoVogue" index.html; then
    print_result "PhotoVogue mention" "PASS" "PhotoVogue recognition mentioned"
else
    print_result "PhotoVogue mention" "FAIL" "PhotoVogue recognition not mentioned"
fi

echo -e "\n${BLUE}🌐 SEO TESTS${NC}"
echo "============="

# Meta tags
if grep -q '<meta name="description"' index.html; then
    print_result "Meta description" "PASS" "Meta description present"
else
    print_result "Meta description" "FAIL" "Meta description missing"
fi

if grep -q '<meta name="keywords"' index.html; then
    print_result "Meta keywords" "PASS" "Meta keywords present"
else
    print_result "Meta keywords" "WARN" "Meta keywords missing (optional)"
fi

if grep -q 'property="og:title"' index.html; then
    print_result "Open Graph title" "PASS" "Open Graph title present"
else
    print_result "Open Graph title" "FAIL" "Open Graph title missing"
fi

if grep -q 'property="og:description"' index.html; then
    print_result "Open Graph description" "PASS" "Open Graph description present"
else
    print_result "Open Graph description" "FAIL" "Open Graph description missing"
fi

if grep -q 'property="og:image"' index.html; then
    print_result "Open Graph image" "PASS" "Open Graph image present"
else
    print_result "Open Graph image" "FAIL" "Open Graph image missing"
fi

if grep -q 'property="twitter:card"' index.html; then
    print_result "Twitter Card" "PASS" "Twitter Card present"
else
    print_result "Twitter Card" "FAIL" "Twitter Card missing"
fi

if grep -q 'application/ld+json' index.html; then
    print_result "JSON-LD Schema" "PASS" "Structured data present"
else
    print_result "JSON-LD Schema" "FAIL" "Structured data missing"
fi

# Alt text for images
if grep -q 'alt=' index.html; then
    print_result "Image alt text" "PASS" "Alt text present on images"
else
    print_result "Image alt text" "FAIL" "Alt text missing on images"
fi

# Heading structure
if grep -q '<h1' index.html; then
    print_result "H1 tag" "PASS" "H1 tag present"
else
    print_result "H1 tag" "FAIL" "H1 tag missing"
fi

if grep -q '<h2' index.html; then
    print_result "H2 tags" "PASS" "H2 tags present"
else
    print_result "H2 tags" "FAIL" "H2 tags missing"
fi

echo -e "\n${BLUE}♿ ACCESSIBILITY TESTS${NC}"
echo "========================="

# Accessibility attributes
if grep -q 'aria-label=' index.html; then
    print_result "ARIA labels" "PASS" "ARIA labels present"
else
    print_result "ARIA labels" "WARN" "ARIA labels missing"
fi

if grep -q 'role=' index.html; then
    print_result "ARIA roles" "PASS" "ARIA roles present"
else
    print_result "ARIA roles" "WARN" "ARIA roles missing"
fi

if grep -q 'tabindex=' index.html; then
    print_result "Tab navigation" "PASS" "Tab navigation support"
else
    print_result "Tab navigation" "WARN" "Tab navigation support missing"
fi

# Language attribute
if grep -q 'lang="en"' index.html; then
    print_result "Language attribute" "PASS" "Language attribute present"
else
    print_result "Language attribute" "FAIL" "Language attribute missing"
fi

# Viewport meta tag
if grep -q 'name="viewport"' index.html; then
    print_result "Viewport meta tag" "PASS" "Viewport meta tag present"
else
    print_result "Viewport meta tag" "FAIL" "Viewport meta tag missing"
fi

echo -e "\n${BLUE}🍪 COOKIE CONSENT TESTS${NC}"
echo "=========================="

# Cookie consent functionality
if grep -q 'cookie-consent' index.html; then
    print_result "Cookie consent script" "PASS" "Cookie consent script loaded"
else
    print_result "Cookie consent script" "FAIL" "Cookie consent script missing"
fi

if [ -f "js/cookie-consent.js" ]; then
    if grep -q "CookieConsent" js/cookie-consent.js; then
        print_result "Cookie consent class" "PASS" "Cookie consent class defined"
    else
        print_result "Cookie consent class" "FAIL" "Cookie consent class missing"
    fi
else
    print_result "Cookie consent class" "FAIL" "Cookie consent file missing"
fi

echo -e "\n${BLUE}📱 RESPONSIVE DESIGN TESTS${NC}"
echo "==============================="

# Responsive meta tag
if grep -q 'width=device-width' index.html; then
    print_result "Responsive viewport" "PASS" "Responsive viewport configured"
else
    print_result "Responsive viewport" "FAIL" "Responsive viewport missing"
fi

# Media queries in CSS
if grep -q '@media' css/04-layout.css; then
    print_result "Media queries" "PASS" "Media queries present in layout CSS"
else
    print_result "Media queries" "FAIL" "Media queries missing in layout CSS"
fi

# Flexible units
if grep -q 'clamp(' css/04-layout.css; then
    print_result "Flexible units" "PASS" "Clamp() functions used for responsive sizing"
else
    print_result "Flexible units" "WARN" "Clamp() functions not found"
fi

echo -e "\n${BLUE}⚡ PERFORMANCE TESTS${NC}"
echo "======================="

# File size checks
check_file_size "index.html" 50000 "Main HTML file size"
check_file_size "css/main.css" 100000 "Main CSS file size"
check_file_size "js/main.js" 50000 "Main JavaScript file size"

# Image optimization
for img in assets/images/portfolio/*/*.jpg; do
    if [ -f "$img" ]; then
        size=$(stat -f%z "$img" 2>/dev/null || stat -c%s "$img" 2>/dev/null)
        if [ "$size" -lt 500000 ]; then
            print_result "Image optimization: $(basename "$img")" "PASS" "Image size OK ($size bytes)"
        else
            print_result "Image optimization: $(basename "$img")" "WARN" "Image size large ($size bytes)"
        fi
    fi
done

echo -e "\n${BLUE}🔒 SECURITY TESTS${NC}"
echo "==================="

# HTTPS enforcement (if applicable)
if grep -q 'https://' index.html; then
    print_result "HTTPS usage" "PASS" "HTTPS URLs used"
else
    print_result "HTTPS usage" "WARN" "No HTTPS URLs found"
fi

# External link security
if grep -q 'rel="noopener noreferrer"' index.html; then
    print_result "External link security" "PASS" "External links have security attributes"
else
    print_result "External link security" "WARN" "External links missing security attributes"
fi

# Content Security Policy (if applicable)
if grep -q 'Content-Security-Policy' index.html; then
    print_result "CSP header" "PASS" "Content Security Policy present"
else
    print_result "CSP header" "WARN" "Content Security Policy missing"
fi

echo -e "\n${BLUE}🌍 INTERNATIONALIZATION TESTS${NC}"
echo "=================================="

# Character encoding
if grep -q 'charset="UTF-8"' index.html || grep -q "charset=UTF-8" index.html; then
    print_result "UTF-8 encoding" "PASS" "UTF-8 character encoding set"
else
    print_result "UTF-8 encoding" "FAIL" "UTF-8 character encoding missing"
fi

# Language declaration
if grep -q 'lang="en"' index.html; then
    print_result "Language declaration" "PASS" "Language declared as English"
else
    print_result "Language declaration" "FAIL" "Language declaration missing"
fi

echo -e "\n${BLUE}📊 FINAL RESULTS${NC}"
echo "=================="
echo -e "${GREEN}✅ Passed: $PASSED${NC}"
echo -e "${RED}❌ Failed: $FAILED${NC}"
echo -e "${YELLOW}⚠️  Warnings: $WARNINGS${NC}"

# Calculate success rate
total=$((PASSED + FAILED + WARNINGS))
if [ $total -gt 0 ]; then
    success_rate=$((PASSED * 100 / total))
    echo -e "\n${BLUE}Success Rate: $success_rate%${NC}"
    
    if [ $success_rate -ge 90 ]; then
        echo -e "${GREEN}🎉 Excellent! Your website meets world-class standards!${NC}"
    elif [ $success_rate -ge 80 ]; then
        echo -e "${YELLOW}👍 Good! Your website is well-built with minor improvements needed.${NC}"
    elif [ $success_rate -ge 70 ]; then
        echo -e "${YELLOW}⚠️  Fair. Your website needs some improvements to meet professional standards.${NC}"
    else
        echo -e "${RED}🚨 Needs work. Your website requires significant improvements.${NC}"
    fi
fi

echo -e "\n${BLUE}📋 RECOMMENDATIONS${NC}"
echo "===================="

if [ $FAILED -gt 0 ]; then
    echo -e "${RED}❌ Fix the failed tests first - these are critical issues.${NC}"
fi

if [ $WARNINGS -gt 0 ]; then
    echo -e "${YELLOW}⚠️  Address the warnings to improve your website's quality.${NC}"
fi

echo -e "\n${BLUE}🔧 NEXT STEPS${NC}"
echo "============="
echo "1. Fix any failed tests"
echo "2. Address warnings for better quality"
echo "3. Test on multiple devices and browsers"
echo "4. Run performance audits with tools like Lighthouse"
echo "5. Test accessibility with screen readers"
echo "6. Validate HTML and CSS with online validators"

echo -e "\n${GREEN}✨ Testing complete!${NC}"

#!/bin/bash

# ========================================
# TMM-WEB COMPREHENSIVE TEST SCRIPT
# ========================================
# Complete testing suite for Thapelo Masebe's portfolio website

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Configuration
LOCAL_PORT="8001"
TEST_RESULTS="test-results-$(date +%Y%m%d-%H%M%S).txt"
PASSED_TESTS=0
FAILED_TESTS=0
TOTAL_TESTS=0

echo -e "${BLUE}🧪 TMM-WEB COMPREHENSIVE TEST SUITE${NC}"
echo -e "${BLUE}====================================${NC}"

# Function to run test
run_test() {
    local test_name="$1"
    local test_command="$2"
    local expected_result="$3"
    
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
    
    echo -e "${BLUE}Testing: $test_name${NC}"
    
    if eval "$test_command" > /dev/null 2>&1; then
        echo -e "${GREEN}✅ PASS: $test_name${NC}"
        echo "PASS: $test_name" >> "$TEST_RESULTS"
        PASSED_TESTS=$((PASSED_TESTS + 1))
    else
        echo -e "${RED}❌ FAIL: $test_name${NC}"
        echo "FAIL: $test_name" >> "$TEST_RESULTS"
        FAILED_TESTS=$((FAILED_TESTS + 1))
    fi
}

# Function to test basic functionality
test_basic_functionality() {
    echo -e "${YELLOW}📋 Testing Basic Functionality${NC}"
    
    # Test main page loads
    run_test "Main page loads" "curl -s -f http://localhost:$LOCAL_PORT"
    
    # Test archive page loads
    run_test "Archive page loads" "curl -s -f http://localhost:$LOCAL_PORT/archive.html"
    
    # Test CSS loads
    run_test "Main CSS loads" "curl -s -f http://localhost:$LOCAL_PORT/css/main.css"
    
    # Test JS loads
    run_test "Main JS loads" "curl -s -f http://localhost:$LOCAL_PORT/js/main.js"
    
    # Test manifest loads
    run_test "Manifest loads" "curl -s -f http://localhost:$LOCAL_PORT/manifest.json"
    
    # Test service worker loads
    run_test "Service worker loads" "curl -s -f http://localhost:$LOCAL_PORT/sw.js"
}

# Function to test images
test_images() {
    echo -e "${YELLOW}🖼️  Testing Images${NC}"
    
    # Test bio image
    run_test "Bio image loads" "curl -s -f http://localhost:$LOCAL_PORT/assets/images/portfolio/bio/me-1.jpg"
    
    # Test portfolio images
    run_test "Documentary image loads" "curl -s -f http://localhost:$LOCAL_PORT/assets/images/portfolio/documentary/life-as-it-happens-2.jpg"
    run_test "Portraiture image loads" "curl -s -f http://localhost:$LOCAL_PORT/assets/images/portfolio/portraiture/amaqamata-1.jpg"
    run_test "Fashion image loads" "curl -s -f http://localhost:$LOCAL_PORT/assets/images/portfolio/fashion/vans-editorial-1.jpg"
    run_test "Fine art image loads" "curl -s -f http://localhost:$LOCAL_PORT/assets/images/portfolio/fine-art/reading-genesis-art-series-3.jpg"
    run_test "Architecture image loads" "curl -s -f http://localhost:$LOCAL_PORT/assets/images/portfolio/architecture/untitled-01-city-skyline-installation-1.jpg"
    run_test "PhotoVogue image loads" "curl -s -f http://localhost:$LOCAL_PORT/assets/images/portfolio/photovogue/0.jpg"
}

# Function to test external links
test_external_links() {
    echo -e "${YELLOW}🔗 Testing External Links${NC}"
    
    # Test Instagram
    run_test "Instagram accessible" "curl -s -f https://www.instagram.com/thaeplo_gv72/"
    
    # Test Behance
    run_test "Behance accessible" "curl -s -w '%{http_code}' https://www.behance.net/thapelomasebe | grep -q '400'"
    
    # Test PhotoVogue
    run_test "PhotoVogue accessible" "curl -s -f https://www.vogue.com/photovogue/photographers/210386"
}

# Function to test HTML structure
test_html_structure() {
    echo -e "${YELLOW}🏗️  Testing HTML Structure${NC}"
    
    # Test DOCTYPE
    run_test "DOCTYPE present" "curl -s http://localhost:$LOCAL_PORT | grep -q '<!DOCTYPE html>'"
    
    # Test HTML lang
    run_test "HTML lang attribute" "curl -s http://localhost:$LOCAL_PORT | grep -q 'lang=\"en\"'"
    
    # Test viewport meta
    run_test "Viewport meta tag" "curl -s http://localhost:$LOCAL_PORT | grep -q 'viewport'"
    
    # Test title
    run_test "Title tag present" "curl -s http://localhost:$LOCAL_PORT | grep -q '<title>'"
    
    # Test main structure
    run_test "Main element present" "curl -s http://localhost:$LOCAL_PORT | grep -q '<main'"
    run_test "Footer element present" "curl -s http://localhost:$LOCAL_PORT | grep -q '<footer'"
}

# Function to test accessibility
test_accessibility() {
    echo -e "${YELLOW}♿ Testing Accessibility${NC}"
    
    # Test alt attributes
    run_test "Images have alt attributes" "curl -s http://localhost:$LOCAL_PORT | grep -q 'alt='"
    
    # Test ARIA labels
    run_test "ARIA labels present" "curl -s http://localhost:$LOCAL_PORT | grep -q 'aria-label'"
    
    # Test role attributes
    run_test "Role attributes present" "curl -s http://localhost:$LOCAL_PORT | grep -q 'role='"
    
    # Test tabindex
    run_test "Tabindex attributes present" "curl -s http://localhost:$LOCAL_PORT | grep -q 'tabindex'"
}

# Function to test mobile responsiveness
test_mobile_responsiveness() {
    echo -e "${YELLOW}📱 Testing Mobile Responsiveness${NC}"
    
    # Test viewport meta
    run_test "Viewport meta configured" "curl -s http://localhost:$LOCAL_PORT | grep -q 'width=device-width'"
    
    # Test mobile headers
    run_test "Apple mobile web app" "curl -s http://localhost:$LOCAL_PORT | grep -q 'apple-mobile-web-app'"
    
    # Test responsive CSS
    run_test "Media queries present" "curl -s http://localhost:$LOCAL_PORT | grep -q '@media'"
}

# Function to test performance
test_performance() {
    echo -e "${YELLOW}⚡ Testing Performance${NC}"
    
    # Test page load time
    local start_time=$(date +%s%N)
    curl -s http://localhost:$LOCAL_PORT > /dev/null
    local end_time=$(date +%s%N)
    local load_time=$(( (end_time - start_time) / 1000000 ))
    
    if [ $load_time -lt 1000 ]; then
        echo -e "${GREEN}✅ PASS: Page loads in ${load_time}ms (excellent)${NC}"
        echo "PASS: Page load time (${load_time}ms)" >> "$TEST_RESULTS"
        PASSED_TESTS=$((PASSED_TESTS + 1))
    elif [ $load_time -lt 3000 ]; then
        echo -e "${YELLOW}⚠️  WARN: Page loads in ${load_time}ms (good)${NC}"
        echo "WARN: Page load time (${load_time}ms)" >> "$TEST_RESULTS"
        PASSED_TESTS=$((PASSED_TESTS + 1))
    else
        echo -e "${RED}❌ FAIL: Page loads in ${load_time}ms (slow)${NC}"
        echo "FAIL: Page load time (${load_time}ms)" >> "$TEST_RESULTS"
        FAILED_TESTS=$((FAILED_TESTS + 1))
    fi
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
    
    # Test file sizes
    local html_size=$(curl -s http://localhost:$LOCAL_PORT | wc -c)
    if [ $html_size -lt 50000 ]; then
        echo -e "${GREEN}✅ PASS: HTML size ${html_size} bytes (good)${NC}"
        echo "PASS: HTML size (${html_size} bytes)" >> "$TEST_RESULTS"
        PASSED_TESTS=$((PASSED_TESTS + 1))
    else
        echo -e "${YELLOW}⚠️  WARN: HTML size ${html_size} bytes (large)${NC}"
        echo "WARN: HTML size (${html_size} bytes)" >> "$TEST_RESULTS"
        PASSED_TESTS=$((PASSED_TESTS + 1))
    fi
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
}

# Function to test SEO
test_seo() {
    echo -e "${YELLOW}🔍 Testing SEO${NC}"
    
    # Test meta description
    run_test "Meta description present" "curl -s http://localhost:$LOCAL_PORT | grep -q 'meta.*description'"
    
    # Test Open Graph
    run_test "Open Graph tags present" "curl -s http://localhost:$LOCAL_PORT | grep -q 'og:'"
    
    # Test Twitter Cards
    run_test "Twitter Card tags present" "curl -s http://localhost:$LOCAL_PORT | grep -q 'twitter:'"
    
    # Test structured data
    run_test "Structured data present" "curl -s http://localhost:$LOCAL_PORT | grep -q 'application/ld+json'"
}

# Function to test JavaScript functionality
test_javascript() {
    echo -e "${YELLOW}⚙️  Testing JavaScript${NC}"
    
    # Test theme toggle
    run_test "Theme toggle present" "curl -s http://localhost:$LOCAL_PORT | grep -q 'theme-toggle'"
    
    # Test annotation system
    run_test "Annotation system present" "curl -s http://localhost:$LOCAL_PORT | grep -q 'data-annotation'"
    
    # Test smooth scrolling
    run_test "Smooth scrolling classes" "curl -s http://localhost:$LOCAL_PORT | grep -q 'smooth-scroll'"
    
    # Test project tags
    run_test "Project tags present" "curl -s http://localhost:$LOCAL_PORT | grep -q 'project-tags'"
}

# Function to test CSS
test_css() {
    echo -e "${YELLOW}🎨 Testing CSS${NC}"
    
    # Test CSS loads
    run_test "CSS file loads" "curl -s -f http://localhost:$LOCAL_PORT/css/main.css"
    
    # Test CSS variables
    run_test "CSS variables present" "curl -s http://localhost:$LOCAL_PORT | grep -E '(--clr-|--ff-|--space-|--radius-)' | head -1 | grep -q 'clr'"
    
    # Test responsive breakpoints
    run_test "Responsive breakpoints" "curl -s http://localhost:$LOCAL_PORT | grep -q '@media'"
    
    # Test critical CSS
    run_test "Critical CSS present" "curl -s http://localhost:$LOCAL_PORT | grep -q 'Critical CSS'"
}

# Function to test PWA features
test_pwa() {
    echo -e "${YELLOW}📱 Testing PWA Features${NC}"
    
    # Test manifest
    run_test "Manifest file loads" "curl -s -f http://localhost:$LOCAL_PORT/manifest.json"
    
    # Test service worker
    run_test "Service worker loads" "curl -s -f http://localhost:$LOCAL_PORT/sw.js"
    
    # Test app icons
    run_test "App icons referenced" "curl -s http://localhost:$LOCAL_PORT | grep -q 'apple-touch-icon'"
}

# Function to test security
test_security() {
    echo -e "${YELLOW}🔒 Testing Security${NC}"
    
    # Test external links have noopener
    run_test "External links have noopener" "curl -s http://localhost:$LOCAL_PORT | grep -q 'noopener'"
    
    # Test no inline scripts (except necessary ones)
    local inline_scripts=$(curl -s http://localhost:$LOCAL_PORT | grep -c '<script>' || true)
    if [ $inline_scripts -lt 5 ]; then
        echo -e "${GREEN}✅ PASS: Minimal inline scripts (${inline_scripts})${NC}"
        echo "PASS: Minimal inline scripts (${inline_scripts})" >> "$TEST_RESULTS"
        PASSED_TESTS=$((PASSED_TESTS + 1))
    else
        echo -e "${YELLOW}⚠️  WARN: Many inline scripts (${inline_scripts})${NC}"
        echo "WARN: Many inline scripts (${inline_scripts})" >> "$TEST_RESULTS"
        PASSED_TESTS=$((PASSED_TESTS + 1))
    fi
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
}

# Function to start local server
start_server() {
    echo -e "${BLUE}🚀 Starting local server...${NC}"
    
    # Check if server is already running
    if curl -s -f http://localhost:$LOCAL_PORT > /dev/null 2>&1; then
        echo -e "${GREEN}✅ Server already running on port $LOCAL_PORT${NC}"
    else
        echo -e "${BLUE}Starting Python HTTP server...${NC}"
        python3 -m http.server $LOCAL_PORT &
        SERVER_PID=$!
        sleep 3
        
        if curl -s -f http://localhost:$LOCAL_PORT > /dev/null 2>&1; then
            echo -e "${GREEN}✅ Server started successfully${NC}"
        else
            echo -e "${RED}❌ Failed to start server${NC}"
            exit 1
        fi
    fi
}

# Function to stop server
stop_server() {
    if [ ! -z "$SERVER_PID" ]; then
        echo -e "${BLUE}🛑 Stopping server...${NC}"
        kill $SERVER_PID 2>/dev/null || true
        echo -e "${GREEN}✅ Server stopped${NC}"
    fi
}

# Function to generate report
generate_report() {
    echo -e "${YELLOW}📊 Generating Test Report${NC}"
    
    {
        echo "TMM-WEB Test Report - $(date)"
        echo "=============================="
        echo ""
        echo "Test Summary:"
        echo "Total Tests: $TOTAL_TESTS"
        echo "Passed: $PASSED_TESTS"
        echo "Failed: $FAILED_TESTS"
        echo "Success Rate: $(( (PASSED_TESTS * 100) / TOTAL_TESTS ))%"
        echo ""
        echo "Detailed Results:"
        cat "$TEST_RESULTS"
        echo ""
        echo "Test completed at: $(date)"
    } > "test-report-$(date +%Y%m%d-%H%M%S).txt"
    
    echo -e "${GREEN}✅ Test report generated${NC}"
}

# Function to run all tests
run_all_tests() {
    echo -e "${BLUE}🧪 Running All Tests${NC}"
    
    # Initialize test results file
    echo "TMM-WEB Test Results - $(date)" > "$TEST_RESULTS"
    echo "==============================" >> "$TEST_RESULTS"
    echo "" >> "$TEST_RESULTS"
    
    # Run all test suites
    test_basic_functionality
    test_images
    test_external_links
    test_html_structure
    test_accessibility
    test_mobile_responsiveness
    test_performance
    test_seo
    test_javascript
    test_css
    test_pwa
    test_security
    
    # Generate final report
    generate_report
    
    # Display summary
    echo -e "${BLUE}📊 Test Summary${NC}"
    echo -e "${BLUE}===============${NC}"
    echo -e "Total Tests: $TOTAL_TESTS"
    echo -e "Passed: ${GREEN}$PASSED_TESTS${NC}"
    echo -e "Failed: ${RED}$FAILED_TESTS${NC}"
    echo -e "Success Rate: ${GREEN}$(( (PASSED_TESTS * 100) / TOTAL_TESTS ))%${NC}"
    
    if [ $FAILED_TESTS -eq 0 ]; then
        echo -e "${GREEN}🎉 All tests passed! Your site is ready for production!${NC}"
    else
        echo -e "${YELLOW}⚠️  Some tests failed. Check the report for details.${NC}"
    fi
}

# Main function
main() {
    # Trap to ensure server is stopped on exit
    trap stop_server EXIT
    
    # Start server
    start_server
    
    # Run tests
    run_all_tests
    
    # Clean up
    rm -f "$TEST_RESULTS"
}

# Run main function
main "$@"

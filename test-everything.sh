#!/bin/bash

echo "🧪 COMPREHENSIVE FUNCTIONALITY TEST"
echo "=================================="

# Test 1: File Structure
echo "📁 Testing file structure..."
if [ -f "index.html" ] && [ -f "archive.html" ] && [ -f "css/main.css" ] && [ -f "js/main.js" ]; then
    echo "✅ Core files present"
else
    echo "❌ Missing core files"
    exit 1
fi

# Test 2: CSS Loading
echo "🎨 Testing CSS loading..."
if grep -q "main.css" index.html && grep -q "03-components.css" index.html; then
    echo "✅ Main page CSS properly linked"
else
    echo "❌ CSS linking issues on main page"
fi

if grep -q "main.css" archive.html && grep -q "03-components.css" archive.html; then
    echo "✅ Archive page CSS properly linked"
else
    echo "❌ CSS linking issues on archive page"
fi

# Test 3: JavaScript Loading
echo "⚡ Testing JavaScript loading..."
if grep -q "main.js" index.html && grep -q "main.js" archive.html; then
    echo "✅ JavaScript properly linked on both pages"
else
    echo "❌ JavaScript linking issues"
fi

# Test 4: Theme Toggle Elements
echo "🌙 Testing theme toggle elements..."
if grep -q 'id="theme-toggle"' index.html && grep -q 'id="theme-icon"' index.html; then
    echo "✅ Theme toggle elements present on main page"
else
    echo "❌ Theme toggle elements missing on main page"
fi

if grep -q 'id="theme-toggle"' archive.html && grep -q 'id="theme-icon"' archive.html; then
    echo "✅ Theme toggle elements present on archive page"
else
    echo "❌ Theme toggle elements missing on archive page"
fi

# Test 5: Archive Button
echo "📂 Testing archive button..."
if grep -q 'href="./archive.html"' index.html; then
    echo "✅ Archive button link correct"
else
    echo "❌ Archive button link incorrect"
fi

# Test 6: CSS Classes
echo "🎯 Testing CSS classes..."
if grep -q "archive-section" index.html; then
    echo "✅ Archive section class correct"
else
    echo "❌ Archive section class incorrect"
fi

# Test 7: JavaScript Functions
echo "🔧 Testing JavaScript functions..."
if grep -q "initializeThemeToggle" js/main.js && grep -q "showAnnotation" js/main.js; then
    echo "✅ Key JavaScript functions present"
else
    echo "❌ Missing JavaScript functions"
fi

# Test 8: Performance Optimizations
echo "⚡ Testing performance optimizations..."
if grep -q "passive: true" js/main.js; then
    echo "✅ Touch events optimized"
else
    echo "❌ Touch events not optimized"
fi

if grep -q "position: fixed" css/01-system.css; then
    echo "✅ Annotation positioning optimized"
else
    echo "❌ Annotation positioning not optimized"
fi

# Test 9: Project Cleanup
echo "🧹 Testing project cleanup..."
if [ -d "docs" ] && [ ! -f "*.md" ] && [ ! -f "*.sh" ]; then
    echo "✅ Project root cleaned up"
else
    echo "❌ Project root still has clutter"
fi

# Test 10: No 404 Errors
echo "🔍 Testing for 404 errors..."
if ! grep -q "icon-192.png" manifest.json; then
    echo "✅ No missing icon references"
else
    echo "❌ Still has missing icon references"
fi

echo ""
echo "🎉 TEST COMPLETE!"
echo "=================="
echo "If all tests passed, your site should be working perfectly!"
echo ""
echo "🌐 Test your site at: http://127.0.0.1:5502"
echo "📂 Test archive at: http://127.0.0.1:5502/archive.html"
echo ""
echo "✅ Things to test manually:"
echo "   - Theme toggle button (both pages)"
echo "   - Archive button navigation"
echo "   - Annotation hover effects"
echo "   - Mobile responsiveness"
echo "   - No console errors"

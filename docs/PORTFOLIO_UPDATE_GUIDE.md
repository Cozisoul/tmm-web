# Portfolio Update Guide
## How to Add Your Current Work and Images

### 🎯 **Quick Updates You Can Make Right Now:**

#### 1. **Update Your Projects Data** (`js/projects.js`)
Edit the `projectsData` object to include your current work:

```javascript
const projectsData = {
    photography: {
        title: "Commercial Photography",
        description: "Major brand campaigns for Vans, Sportscene, Cotton On, and Viktor & Rolf",
        link: "https://www.instagram.com/thaeplo_gv72/",
        images: [
            // Add your Instagram image URLs here
            "https://instagram.com/p/your-image-id-1/",
            "https://instagram.com/p/your-image-id-2/",
        ],
        featured: true
    },
    // Add more projects...
};
```

#### 2. **Add Your Social Media Links**
Update the links in `index.html` with your actual profiles:
- Instagram: @thaeplo_gv72
- GitHub: Cozisoul
- Behance: [Your Behance URL]
- Vogue: [Any Vogue features]

#### 3. **Add Your Images**
Create an `assets/images/` folder and add:
- Your best photography work
- Data visualization screenshots
- Project mockups
- Behind-the-scenes photos

### 📸 **Instagram Integration:**

#### Option 1: Manual Image Addition
1. Download your best Instagram images
2. Add them to `assets/images/`
3. Update the HTML to reference them

#### Option 2: Instagram Embed
1. Go to your Instagram post
2. Click the three dots → "Embed"
3. Copy the embed code
4. Add it to your HTML

### 💻 **GitHub Integration:**

#### Show Your Best Repositories:
1. Go to your GitHub profile
2. Copy repository URLs
3. Add them to the projects data
4. Include descriptions of what each project does

### 🎨 **Behance Integration:**

#### If you have a Behance profile:
1. Go to your Behance project
2. Click "Share" → "Embed"
3. Copy the embed code
4. Add it to your portfolio section

### 📰 **Vogue Features:**

#### If you've been featured in Vogue:
1. Get the article URL
2. Take a screenshot of the feature
3. Add it to your portfolio with proper attribution

### 🚀 **Quick Start Checklist:**

- [ ] Update `js/projects.js` with your current projects
- [ ] Add your best images to `assets/images/`
- [ ] Update social media links in `index.html`
- [ ] Add any Vogue features or press mentions
- [ ] Include your GitHub repositories
- [ ] Add Behance projects if you have them
- [ ] Test the website on mobile and desktop

### 📱 **Mobile Testing:**
1. Open http://localhost:8000 on your phone
2. Test all the links and interactions
3. Make sure images load properly
4. Check that the layout looks good

### 🎯 **Pro Tips:**
- Keep image file sizes under 500KB for fast loading
- Use descriptive alt text for accessibility
- Update your work regularly to keep it current
- Ask friends to test your portfolio and give feedback

---

**Need Help?** 
- Check the browser console (F12) for any errors
- Make sure all file paths are correct
- Test each link to ensure it works

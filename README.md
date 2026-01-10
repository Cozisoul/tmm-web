# Thapelo Madiba Masebe | Transdisciplinary Practitioner

A digital CV and professional portfolio website.

## Overview

This is a static website built with HTML, CSS, and vanilla JavaScript. It features a responsive grid layout that adapts from a multi-column desktop view to a single-column mobile view.

## Structure

- `index.html`: Main entry point.
- `css/style.css`: All styling, including the grid layout and responsive media queries.
- `js/`: JavaScript modules.
    - `main.js`: Main entry point for scripts.
    - `annotations.js`: Logic for the interactive "annotation" hover system.
- `assets/`: Static assets like the PDF CV.
- `public/`: Public assets like the favicon.

## Development

No build step is required. Simply open `index.html` in a browser or serve with a local static server.

## Features

- **Responsive Layout**: 3-column grid on desktop, 1-column on mobile.
- **Interactive Annotations**: Hovering over highlighted terms displays context in the right sidebar (desktop only).
- **Sticky Sidebar**: The annotation panel sticks to the top while scrolling.

## Recent Changes

- Fixed mobile scrolling issue by removing fixed height constraint on mobile views.
- Updated favicon implementation.

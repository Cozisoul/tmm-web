# HTML Tags Guide

This document provides a quick reference for common HTML tags and their usage, to help with understanding the structure of the digital portfolio.

## Structural Tags

*   `<html>`: The root element of an HTML page.
*   `<head>`: Contains meta-information about the document (title, scripts, styles, meta tags).
*   `<body>`: Contains the visible content of the document.
*   `<header>`: Defines a header for a document or section (often contains introductory content or navigational links).
*   `<main>`: Specifies the main content of a document. There should only be one `<main>` element per page.
*   `<section>`: Defines a section in a document (e.g., chapters, headers, footers, or any other sections).
*   `<aside>`: Defines content aside from the content it is placed in (like a sidebar).

## Typography and Text

*   `<h1>` to `<h6>`: Headings, where `<h1>` is the most important and `<h6>` is the least.
*   `<p>`: Defines a paragraph.
*   `<strong>`: Defines important text (typically rendered as bold).
*   `<em>`: Defines emphasized text (typically rendered as italic).
*   `<ul>`: Defines an unordered (bulleted) list.
*   `<li>`: Defines a list item.

## Links and Media

*   `<a>`: Defines a hyperlink, used to link from one page to another.
    *   Attribute `href`: Indicates the destination of the link.
    *   Attribute `target="_blank"`: Opens the linked document in a new window or tab.
*   `<img>`: Defines an image.
    *   Attribute `src`: Specifies the path to the image.
    *   Attribute `alt`: Specifies an alternate text for the image if it cannot be displayed.

## Custom Data Attributes

HTML allows authors to specify custom data attributes using the `data-*` prefix. In this portfolio, we use `data-annotation` to trigger interactive hover effects using JavaScript.

Example:
```html
<strong data-annotation="python">Python</strong>
```
When hovered over, JavaScript reads the value (`python`), looks up the corresponding information in `js/annotations.js`, and displays it in the side panel.

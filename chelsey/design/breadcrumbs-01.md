---
altLangPage: "#"
breadcrumbs:
  - title: Breadcrumbs pattern
    link: "https://design.canada.ca/common-design-patterns/breadcrumb-trail.html"
css:
- https://design.canada.ca/css/split-h1.css
- https://design.canada.ca/css/custom.css
- https://use.fontawesome.com/releases/v5.15.4/css/all.css
date: 2023-02-23
dateModified: 2023-02-23
description: "Standard page with breadcrumbs"
lang: en
layout: without-h1
title: "Breadcrumb trail"
---
<h1 property="name" id="wb-cont" dir="ltr"><span class="stacked"><span>Breadcrumb trail</span>: <span>Canada.ca design</span></span></h1>
<span class="label label-danger">Mandatory on standard and campaign pages</span>
<p>This is a mockup of the future state of the Breadcrumb trail pattern.</p>
<p>The breadcrumb trail is a horizontal series of links that gives people a sense of where they are in relation to Canada.ca’s navigation model.  It represents the location of a page in relation to its parent and provides a clear way to navigate to higher levels in the site structure.</p>
<figure>
  <figcaption class="caption"><b>Breadcrumb trail</b></figcaption>
  <img src="https://design.canada.ca/images/breadcrumb-en.png" alt="Breadcrumb trail appears on the lower left of the Canada.ca header"></figure>
<h2>On this page</h2>
<ul>
  <li>When to use</li>
  <li>What to avoid</li>
  <li>Content and design</li>
  <li>How to implement</li>
  <li>Latest changes</li>
  <li>Discussion</li>
</ul>
<h2>When to use</h2>
<p>The breadcrumb trail is mandatory on all pages except transactional pages.</p>
<h2>What to avoid</h2>
<p>Don’t program the breadcrumb trail to be generated dynamically based on a visitor’s journey to a page. It should represent the location of a page as it stands in relation to the site’s navigation model.</p>
<p>Avoid long link labels. Use a shortened version of the page title if necessary.</p>
<p>Don’t display the current page at the end of the breadcrumb trail (linked or unlinked). It increases the length of the breadcrumb unnecessarily, especially on mobile. The heading of the page is enough to let people know where they are.</p>
<h2>Content and design</h2>
<p>Find content and design specifications and visual examples.</p>
<h3>Content specifications</h3>
<ul>
  <li>Align the breadcrumb trail to the left directly below the menu button (or the divider line if there is no menu button)</li>
  <li>Use “Canada.ca” as the text of the first breadcrumb link on standard and campaign pages</li>
  <li>Link to the Canada.ca home page in the language of the current page</li>
  <li>You can use either “Home” or the name of the process or application as the text of the first breadcrumb link on transactional pages that use a breadcrumb trail</li>
  <li>Link to the starting page of the process or the landing page of the application</li>
  <li>Breadcrumb links should reflect the title of the page</li>
  <li>Shorten the page title if necessary to reduce the space required to display the breadcrumb trail</li>
  <li>Use a single greater-than sign (&#8250;) to separate each breadcrumb link</li>
</ul>
<h4>Accessibility</h4>
<ul>
  <li>Include “You are here:” as invisible help text</li>
</ul>
<h3>Design specifications</h3>
<ul>
  <li>Type: link</li>
  <li>Position: top left</li>
  <li>Font: Noto sans</li>
  <li>Size: 16px</li>
  <li>Text colour:</li>
  <ul>
    <li>default link: #284162</li>
    <li>selected link (on hover or focus): #0535d2</li>
    <li>visited link: #7834bc</li>
  </ul>
  <li>Spacing: padding: 0 5px</li>
  <li>Icon:  \f054 (Font awesome)</li>
</ul>
<h4>Accessibility</h4>
<ul>
  <li>Code breadcrumbs as an ordered list</li>
</ul>
<h4>Examples</h4>
<p>Usage for different locations on Canada.ca is as follows:</p>
<h5>Services and information content</h5>
<p><strong>Theme pages, institutional and organizational pages</strong></p>
<p>Canada.ca</p>
<p><strong>First-level topic pages</strong></p>
<p>Canada.ca   &#8250;   [Parent theme]</p>
<br>
<p><strong>Second-level topic pages</strong></p>
<p>Canada.ca    &#8250;   [Parent theme]    &#8250;   [Parent topic]</p>
<p><strong>Destination content pages</strong></p>
<p>Canada.ca    &#8250;   [Parent theme]    &#8250;   [Parent topic]   &#8250;  [Parent sub-topic]   &#8250;   [etc.]</p>
<p>For example, when on the “Planning a business” page in the Business and industry theme, the breadcrumb trail will be:
  Canada.ca   &#8250;   Business   &#8250;   Starting a business</p>
<ul class="list-unstyled">
  <li>
    <details>
      <summary>Corporate, program and policy content</summary>
      <p><strong>Corporate, program or policy content pages</strong></p>
      <p>Canada.ca   &#8250;   [Institutional profile page]</p>
      <p><strong>Partnering and collaborative arrangement profile pages</strong></p>
      <p>Canada.ca</p>
    </details>
  </li>
  <li>
    <details>
      <summary>Search results pages</summary>
      <p><strong>Basic search pages</strong></p>
      <p>Canada.ca</p>
      <p><strong>Advanced search pages</strong></p>
      <p>Canada.ca   &#8250;   [Basic search]</p>
    </details>
  </li>
  <li>
    <details>
      <summary>Campaigns and promotions</summary>
      <p>Promotion campaigns don't need a breadcrumb trail. If you add one, it can lead back to the topic tree, the Institutional/Organizational profile, or to the Home page of Canada.ca.</p>
    </details>
  </li>
  <li>
    <details>
      <summary>News</summary>
      <p>Canada.ca   &#8250;   [Institutional profile page]</p>
    </details>
  </li>
</ul>
<h3>Visual examples</h3>
<figure>
  <figcaption class="caption"><b>Global header with breadcrumb trail  - large screen</b></figcaption>
  <img src="https://design.canada.ca/images/breadcrumb-en.png" alt="Breadcrumb trail appears on the lower left of the Canada.ca header"></figure>

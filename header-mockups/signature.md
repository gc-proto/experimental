---
altLangPage: "/resumes-recherche/design-conversationnel"
author: Treasury Board Secretariat of Canada
breadcrumbs:
  - title: "About Canada.ca"
    link:  "https://www.canada.ca/en/government/about.html"
  - title: Canada.ca design system
    link: "https://www.canada.ca/en/government/about/design-system.html"
  - title: Template and pattern library
    link: "https://www.canada.ca/en/government/about/design-system/pattern-library.html"    
  - title: Global header
    link: "https://design.canada.ca/common-design-patterns/global-header.html"    
css:
- https://design.canada.ca/css/split-h1.css
- https://design.canada.ca/css/custom.css
- https://use.fontawesome.com/releases/v5.15.4/css/all.css
date: 2022-08-17
dateModified: 2023-03-21
description: "Guidance about using the Government of Canada signature on Canada.ca. The signature is an official symbol of the Government of Canada. It always appears in the global header across Canada.ca."
lang: en
layout: without-h1
share: true
pageclass: cnt-wdth-lmtd
title: "Government of Canada signature"
---
<h1 property="name" id="wb-cont" dir="ltr"><span class="stacked"><span>Government of Canada signature</span>: <span>Canada.ca design system</span></span></h1>
<div class="row">
  <div class="col-md-12 pull-left">
    <ul class="list-inline small mrgn-bttm-sm" id="list-inline-desktop-only">
      <li class="mrgn-rght-lg"> Last updated: YYYY-MM-DD</li>
    </ul>
  </div>
</div>
<p><span class="label label-danger">Mandatory on all pages</span></p>
<p>The Government of Canada signature is a mandatory element of the global header. The signature is an official symbol of the Government of Canada. It combines the flag symbol and “Government of Canada” in both official languages.</p>
<p>The Government of Canada signature helps users identify that the page they are on belongs to the Government of Canada.</p>
<div class="pattern-demo mrgn-tp-lg">
  <figure class="mrgn-bttm-sm"><img src="./images/sig-en.png" class="img-responsive" alt=""></figure>
</div>
<section>
  <h2>On this page</h2>
  <ul>
    <li><a href="#when">When to use</a></li>
    <li><a href="#avoid">What to avoid</a></li>
    <li><a href="#content">Content and design</a></li>
    <li><a href="#implementation">How to implement</a></li>
    <li><a href="#research">Research and rationale</a></li>
    <li><a href="#changes">Latest changes</a></li>
    <li><a href="#discussion">Discussion</a></li>
  </ul>
</section>
<h2 id="when">When to use</h2>
<p>The Government of Canada signature is mandatory on all pages.</p>
<h2 id="avoid">What to avoid</h2>
<p>Don’t modify the signature.</p>
<p>Don’t change the colour of the flag. It must appear in colour (red), not in black and white.</p>
<p>Don’t modify the text (Government of Canada Gouvernement du Canada) or the font.</p>
<h2 id="content">Content and design</h2>
<p>Find content and design specifications and visual examples.</p>
<h3>Content specifications</h3>
<ul>
  <li>The Government of Canada signature appears in the top-left corner of the page</li>
  <li>The signature is composed of the flag symbol in Federal Identity Policy red, followed by the words Government of Canada in English and Gouvernement du Canada in French, both in black text</li>
  <li>The signature must appear as English first on English pages and French first on French pages</li>
</ul>
<h4>Accessibility</h4>
<p>Include Government of Canada as alt text on the English side, Gouvernement du Canada as alt text on the French side.</p>
<h4>Interactions</h4>
<p>When selected, the signature brings the user to the homepage of Canada.ca.</p>
<h3>Design specifications</h3>
<p>Design specifications for the signature are:</p>
<ul>
  <li>Type: image</li>
  <li>Position: top left</li>
  <li>Flag symbol colour: FIP red (#eb4837)</li>
  <li>Text colour: black (#000000)</li>
  <li>Alt text: Government of Canada</li>
</ul>
<p>The signature is a Scalable Vector Graphics (SVG) file, configured to scale automatically according to screen size.</p>
<p>The signature is an image file that must be formatted according to Federal Identity Program design specifications.</p>
<h3>Visual examples</h3>
<div class="pattern-demo mrgn-tp-lg">
  <figure>
    <figcaption><b>Government of Canada signature - large screen</b></figcaption>
    <img src="./images/sig-en.png" class="img-responsive" alt="Global header with signature. Text version below:">
    <details>
      <summary class="wb-toggle small" data-toggle="{&quot;print&quot;:&quot;on&quot;}">Text version</summary>
      <p class="mrgn-tp-lg">The Government of Canada signature is in the top-left corner of the website. It is composed of the flag symbol in red, followed by the words <strong>Government of Canada</strong> in English and <strong>Gouvernement du Canada</strong> in French, both in black text.</p>
      </ol>
    </details>
  </figure>
</div>
<div class="pattern-demo mrgn-tp-lg">
  <figure>
    <figcaption><b>Global header – small screen</b></figcaption>
    <img src="./images/sig-sm-en.png" class="img-responsive" alt="The breadcrumbs appear under the menu button. Text version below:">
    <details>
      <summary class="wb-toggle small" data-toggle="{&quot;print&quot;:&quot;on&quot;}">Text version</summary>
      <p class="mrgn-tp-lg">The Government of Canada signature is in the top-left corner of the website. It is composed of the flag symbol in red, followed by the words Government of Canada in English and Gouvernement du Canada in French, both in black text.</p>
    </details>
  </figure>
</div>
<h2 id="implementation">How to implement</h2>
<p>Find working examples for implementing the GC signature, an element of the global header.</p>
<h3>GCweb (WET) theme implementation reference</h3>
<p>The implementation reference includes how to configure each element of the header.</p>
<ul>
  <li><a href="https://wet-boew.github.io/GCWeb/sites/header/header-docs-en.html">GCWeb (WET) header documentation</a></li>
  <li><a href="https://wet-boew.github.io/GCWeb/docs/implementing-en.html">Quick implementation guide - GCWeb theme</a></li>
</ul>
<h3>Implementations</h3>
<p>Determine what best suits the type of page you're creating. Refer to your implementation's guidance if you want to exclude breadcrumbs.</p>
<div class="row">
  <div class="col-md-8">
    <div class="wb-tabs mrgn-tp-lg">
      <div class="tabpanels">
        <details id="004" open="open">
          <summary><strong>GC-AEM</strong></summary>
          <p class="mrgn-tp-lg">For the Government of Canada Adobe Experience Manager (AEM):</p>
          <ul>
            <li><a href="https://www.gcpedia.gc.ca/gcwiki/images/9/9a/AEM-6.5-Documentation-Unit-3-7-Changing-the-Default-Breadcrumb.pdf">Changing the default breadcrumb (PDF - GCPedia link - only available on the Government of Canada network)</a></li>
            <li><a href="https://www.gcpedia.gc.ca/wiki/AEM_GC-specific_Documentation_6.5">AEM/Managed Web Service documentation (GCPedia link - only available on the Government of Canada network)</a></li>
          </ul>
        </details>
        <details id="005">
          <summary><strong>CDTS</strong></summary>
          <p class="mrgn-tp-lg">For the Centrally Deployed Templates Solution (CDTS):</p>
          <ul>
            <li><a href="https://cdts.service.canada.ca/app/cls/WET/gcweb/v4_0_47/cdts/samples/breadcrumbs-en.html">Breadcrumbs - CDTS documentation </a></li>
            <li><a href="https://cenw-wscoe.github.io/sgdc-cdts/docs/index-en.html">CDTS documentation</a></li>
          </ul>
        </details>
        <details id="006">
          <summary><strong>Drupal WxT</strong></summary>
          <p class="mrgn-tp-lg">For Drupal WxT:</p>
          <ul>
            <li><a href="https://drupalwxt.github.io/en/">Drupal WxT documentation</a></li>
          </ul>
        </details>
      </div>
    </div>
  </div>
</div>
<h2 id="research">Research and rationale</h2>
<p>Consult research findings and policy rationale.</p>
<h3>Research findings</h3>
<p>Trust and consistency are essential. Our Canada.ca Trust Study and prior research show that a consistent header is necessary to maintaining a trusted brand.</p>
<p>For example, people trust the page more when the flag in the Government of Canada signature is red.</p>
<h3>Policy rationale</h3>
<p>As part of the global header, the breadcrumb is a mandatory element under the Content and Information Architecture Specification.</p>
<p>If you want to know more about this research, contact the Digital Transformation Office at <a href="mailto:dto.btn@tbs-sct.gc.ca">dto.btn@tbs-sct.gc.ca</a>.</p>
<h3>Policy rationale</h3>
<p>The Government of Canada signature is defined by the Federal Identity Program. As a part of the global header, it is a mandatory element under the Content and Information Architecture Specification.</p>
<ul>
  <li><a href="https://www.canada.ca/en/treasury-board-secretariat/services/government-communications/design-standard/colour-design-standard-fip.html">Design Standard for the Federal Identity Program</a></li>
  <li><a href="https://www.canada.ca/en/treasury-board-secretariat/services/government-communications/canada-content-information-architecture-specification/mandatory-elements.html">Mandatory elements of the design system</a></li>
</ul>
<h2 id="changes">Latest changes</h2>
<dl class="dl-horizontal">
  <dt>
    <time datetime="2023-MM-DD" class="link-muted">2023-MM-DD</time>
  </dt>
  <dd>Updated the guidance to include content and design specifications, visual examples and implementation guidance</dd>
</dl>
<h2 id="discussion">Discussion</h2>
<ul>
  <li><a href="https://github.com/canada-ca/design-system/issues">Discuss the pattern in GitHub Issues</a></li>
  <li><a href="http://design-GC-conception.slack.com">Join the conversation on Slack</a></li>
</ul>

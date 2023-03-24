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
dateModified: 2023-03-24
description: "Guidance about using the language toggle on Canada.ca. Government of Canada content is available in both official languages. A language toggle in the global header provides access to the corresponding page in the other official language."
lang: en
layout: without-h1
share: true
pageclass: cnt-wdth-lmtd
title: "Language toggle"
---
<h1 property="name" id="wb-cont" dir="ltr"><span class="stacked"><span>Site search box</span>: <span>Canada.ca design system</span></span></h1>
<div class="row">
  <div class="col-md-12 pull-left">
    <ul class="list-inline small mrgn-bttm-sm" style="line-height:1.65em" id="list-inline-desktop-only">
      <li class="mrgn-rght-lg"> Last updated: YYYY-MM-DD</li>
    </ul>
  </div>
</div>
<p><span class="label label-danger">Mandatory</span></p>
<p>All public-facing Government of Canada content is available in both official languages. A language toggle in the global header provides access to the corresponding page in the other official language.</p>
<div class="pattern-demo mrgn-tp-lg">
  <figure class="mrgn-bttm-sm"><img src="./images/site-search-en.png" class="img-responsive" alt=""></figure>
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
<p>The language toggle is mandatory on all pages.</p>
<p>New transactional pages for web applications must allow people to toggle between official languages. Legacy web applications that don’t support toggling should be updated or replaced. Until then, you can omit the language toggle if its use results in a loss of data.</p>
<h2 id="avoid">What to avoid</h2>
<p>Don’t put other language options in the language toggle. It is only for English and French. Links to content in other languages should appear in the content area of the page.</p>
<p>Don’t use the language toggle to point to anything other than the corresponding page in the equivalent language.</p>
<h2 id="content">Content and design</h2>
<p>Find content and design specifications and visual examples.</p>
<h3>Content specifications</h3>
<p>Ensure that the language toggle links to the corresponding page in the alternate language.</p>
<h4>Large screens</h4>
<ul>
  <li>On English pages, the link label text is “Français”</li>
  <li>On French pages, the link label text is “English”</li>
</ul>
<h4>Small screens</h4>
<p>For small screens, the language toggle uses a 2-letter abbreviation for each language:</p>
<ul>
  <li>On English pages, the link label text is “FR” in uppercase</li>
  <li>On French pages, the link label text is “EN” in uppercase</li>
</ul>
<h4>Accessibility</h4>
<ul>
  <li>Add the full name of the language in the title attribute for the abbreviated language toggle
    <ul>
      <li>the abbreviation title for EN is “English” 
        the abbreviation title for FR is “Français”</li>
    </ul>
  </li>
</ul>
<h4>Interactions</h4>
<ul>
  <li>When selected, the language toggle brings the user to the alternate language version of the page they were on</li>
</ul>
<h3>Design specifications</h3>
<ul>
  <li>Type: link</li>
  <li>Position: top-right corner</li>
  <li>Font: Lato</li>
  <li>Size: 1.2 em</li>
  <li>Text colour:
    <ul>
      <li>default link: #284162</li>
      <li>selected link (on hover or focus): #0535d2</li>
      <li>visited link: #284162</li>
    </ul>
  </li>
</ul>
<h4>Accessibility</h4>
<ul>
  <li>Label the language toggle code so that it’s spoken in the correct language if read aloud by assistive technologies</li>
  <li>Ensure that the text label for the language toggle won’t be translated by browser translation tools</li>
</ul>
<h3>Visual examples</h3>
<div class="pattern-demo mrgn-tp-lg">
  <figure>
    <figcaption><b>Global header with breadcrumb trail  - large screen</b></figcaption>
    <img src="./images/glogal-header-breadcrumb-en.png" class="img-responsive" alt="The breadcrumbs appear under the menu button in a horizontal line. Text version below:">
    <details>
      <summary class="wb-toggle small" data-toggle="{&quot;print&quot;:&quot;on&quot;}">Text version</summary>
      <p class="mrgn-tp-lg">On large screens, the global header has 4 rows:</p>
      <ol>
        <li>Language toggle in the top-right corner</li>
        <li>Government of Canada signature in the left corner, site search box on the right</li>
        <li>Below a divider line, the theme and topic menu is on the left, the optional Sign in button is on the right</li>
        <li>Breadcrumb on the left</li>
      </ol>
    </details>
  </figure>
</div>
<div class="pattern-demo mrgn-tp-lg">
  <figure>
    <figcaption><b>Global header – small screen</b></figcaption>
    <img src="./images/glogal-header-breadcrumb-small-screen-en.png" class="img-responsive" alt="The breadcrumbs appear under the menu button. Text version below:">
    <details>
      <summary class="wb-toggle small" data-toggle="{&quot;print&quot;:&quot;on&quot;}">Text version</summary>
      <p class="mrgn-tp-lg">On small screens, the global header on a standard page has 4 rows:</p>
      <ol>
        <li>Government of Canada signature in the top-left corner, language toggle in the top-right corner</li>
        <li>Site search box directly below, it spans the entire row</li>
        <li>Below a divider line, the theme and topic menu is on the left, the optional Sign in button is</li>
      </ol>
    </details>
  </figure>
</div>
<h2 id="implementation">How to implement</h2>
<p>Find working examples for implementing the breadcrumbs.</p>
<h3>GCweb (WET) theme implementation reference</h3>
<p>The implementation reference includes how to configure each element of the header.</p>
<ul>
  <li><a href="https://wet-boew.github.io/GCWeb/sites/breadcrumbs/breadcrumbs-en.html">Breadcrumbs - GCWeb (WET) documentation</a></li>
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
<div class="cnt-wdth-lmtd">
  <h2 id="research">Research and rationale</h2>
  <p>Consult research findings and policy rationale.</p>
  <h3>Research findings</h3>
  <p><a href="https://blog.canada.ca/2020/08/10/CanadaDotCa-trusted-source.html">Canada.ca is a trusted source</a><br>
    Explains the decision to use “Canada.ca” as the label for the first link in the breadcrumb.</p>
  <p><a href="https://blog.canada.ca/research-summaries/wayfinding-on-canada-ca.html">Wayfinding on Canada.ca research summary</a><br>
    Research shows that people navigating on the site use breadcrumb links nearly twice as often as they use the Theme and topic menu.</p>
  <p>Further design and research work to optimize the breadcrumb for mobile is planned.</p>
  <h3>Policy rationale</h3>
  <p>As part of the global header, the breadcrumb is a mandatory element under the Content and Information Architecture Specification.</p>
  <ul>
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
</div>

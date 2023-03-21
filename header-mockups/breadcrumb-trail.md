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
description: "Guidance about using breadcrumbs on Canada.ca. The breadcrumb trail provides a series of navigational links that gives people a sense of where they are in relation to the site structure."
lang: en
layout: without-h1
share: true
pageclass: cnt-wdth-lmtd
title: "Breadcrumb trail"
---
<h1 property="name" id="wb-cont" dir="ltr"><span class="stacked"><span>Breadcrumb trail</span>: <span>Canada.ca design system</span></span></h1>
<div class="row">
  <div class="col-md-12 pull-left">
    <ul class="list-inline small mrgn-bttm-sm" style="line-height:1.65em" id="list-inline-desktop-only">
      <li class="mrgn-rght-lg"> Last updated: YYYY-MM-DD</li>
    </ul>
  </div>
</div>
<p><span class="label label-danger">Mandatory on standard and campaign pages</span></p>
<p>The breadcrumb trail is a horizontal series of links that gives people a sense of where they are in relation to Canada.ca’s navigation model.  It represents the location of a page in relation to its parent and provides a clear way to navigate to higher levels in the site structure.</p>
<div class="pattern-demo mrgn-tp-lg">
  <figure class="mrgn-bttm-sm"><img src="./images/breadcrumb-en.png" class="img-responsive" alt=""></figure>
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
<p>The breadcrumb trail is mandatory on all pages, except transactional pages.</p>
<h2 id="avoid">What to avoid</h2>
<p>Don’t program the breadcrumb trail to be generated dynamically based on a visitor’s journey to a page. It should represent the location of a page as it stands in relation to the site’s navigation model.</p>
<p>Avoid long link labels. Use a shortened version of the page title if necessary.</p>
<p>Don’t display the current page at the end of the breadcrumb trail (linked or unlinked). It increases the length of the breadcrumb unnecessarily, especially on mobile. The heading of the page is enough to let people know where they are.</p>
<h2 id="content">Content and design</h2>
<p>Find content and design specifications and visual examples.</p>
<h3>Content specifications</h3>
<ul>
  <li>Align the breadcrumb trail to the left directly below the menu button (or the divider line if there is no menu button)</li>
  <li>Use “Canada.ca” as the text of the first breadcrumb link on standard and campaign pages
    <ul>
      <li>Link to the Canada.ca home page in the language of the current page</li>
    </ul>
  </li>
  <li>You can use either “Home” or the name of the process or application as the text of the first breadcrumb link on transactional pages that use a breadcrumb trail
    <ul>
      <li>Link to the starting page of the process or the landing page of the application</li>
    </ul>
  </li>
  <li>Use a single right chevron glyphicon to separate each breadcrumb link</li>
  <li>Reflect the title of the page in the breadcrumb label
    <ul>
      <li>Shorten breadcrumb labels where possible to improve readability and reduce space</li>
    </ul>
  </li>
</ul>
<p>For example, these breadcrumbs:</p>
<p>Canada.ca &#8250; Immigration and citizenship &#8250; Canadian citizenship &#8250; Apply for Canadian citizenship &#8250; Prepare for the Canadian citizenship test and interview</p>
<p>Can be shortened to this:</p>
<p>Canada.ca &#8250; Immigration and citizenship &#8250; Canadian citizenship &#8250; Apply &#8250; Prepare for the test and interview</p>
<h4>Accessibility</h4>
<ul>
  <li>Include “You are here:” as invisible help text</li>
</ul>
<h4>Interactions</h4>
<ul>
  <li>When selected, each breadcrumb should bring the user to a unique page</li>
</ul>
<h3>Design specifications</h3>
<p>Design specifications for the breadcrumbs are:</p>
<ul>
  <li>Type: link</li>
  <li>Position: top left</li>
  <li>Font: Noto sans</li>
  <li>Size: 16px</li>
  <li>Text colour:
    <ul>
      <li>default link: #284162</li>
      <li>selected link (on hover or focus): #0535d2</li>
      <li>visited link: #7834bc</li>
    </ul>
  </li>
  <li>Spacing: padding: 0 5px</li>
  <li>Icon: glyphicon-chevron-right</li>
</ul>
<h4>Accessibility</h4>
<p>Code breadcrumbs as an ordered list</p>
<h4>Examples</h4>
<p>Here are some examples of breadcrumbs for different locations on Canada.ca</p>
<h5>Services and information content<br>
  Theme pages, institutional and organizational pages</h5>
<p>Canada.ca</p>
<h5>First-level topic pages</h5>
<p>Canada.ca   &#8250;   [Parent theme]</p>
<h5>Second-level topic pages</h5>
<p>Canada.ca    &#8250;   [Parent theme]    &#8250;   [Parent topic]</p>
<h5>Destination content pages</h5>
<p>Canada.ca    &#8250;   [Parent theme]    &#8250;   [Parent topic]   &#8250;  [Parent sub-topic]   &#8250;   [etc.]</p>
<h5>Corporate, program and policy content<br>
  Corporate, program or policy content pages</h5>
<p>Canada.ca   &#8250;   [Institutional profile page]</p>
<h5>Partnering and collaborative arrangement profile pages</h5>
<p>Canada.ca</p>
<h5>Search results pages<br>
  Basic search pages</h5>
<p>Canada.ca</p>
<h5>Advanced search pages</h5>
<p>Canada.ca   &#8250;   [Basic search]</p>
<h5>Campaigns and promotions</h5>
<p>Promotion campaigns don't need a breadcrumb trail. If you add one, it can lead back to the topic tree, the Institutional/Organizational profile, or to the Home page of Canada.ca.</p>
<h5>News</h5>
<p>Canada.ca   &#8250;   [Institutional profile page]</p>
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
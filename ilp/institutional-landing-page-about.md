---
altLangPage: "pages-profil-institutionne-a-propos.html"
breadcrumbs:
  - title: About Canada.ca
    link: "https://www.canada.ca/en/government/about.html"
  - title: Canada.ca design system
    link: "https://www.canada.ca/en/government/about/design-system.html"
  - title: Template and pattern library for Canada.ca
    link: "https://www.canada.ca/en/government/about/design-system/pattern-library.html"
  - title: Institutional landing page
    link: "https://design.canada.ca/mandatory-templates/institutional-profile-pages.html"    
css:
- https://design.canada.ca/css/split-h1.css
- https://design.canada.ca/css/custom.css
- https://use.fontawesome.com/releases/v5.15.4/css/all.css
date: 2023-05-08
dateModified: 2023-05-11
description: "About [institution]"
language: en
layout: without-h1
pageclass: cnt-wdth-lmtd
title: "About [institution]"
---
<h1 property="name" id="wb-cont" dir="ltr"><span class="stacked"><span>About [institution name]</span>: <span>Canada.ca design</span></span></h1>
<p class="small"> Last updated: 2023-MM-DD</p>
<p><span class="label label-danger">Mandatory on an institutional landing page</span></p>
<p>The About [institution name] pattern is a section on an institutional landing page that provides links to corporate, program and policy information.</p>
<p>Mandatory links:</p>
<ul>
  <li>Mandate</li>
  <li>Transparency</li>
</ul>
<p>Optional links:</p>
<ul>
  <li>Programs</li>
  <li>Consultations</li>
  <li>Organizational structure</li>
  <li>Reports</li>
  <li>Job opportunities</li>
  <li>any link to content that falls under Corporate information or Program and policy development</li>
</ul>
<div class="pattern-demo mrgn-tp-lg">
  <figure> <img src="./images/ilp-about-lg-en.png" class="img-responsive" alt=""></figure>
</div>
<h2>On this page</h2>
<ul>
  <li><a href="#when">When to use</a></li>
  <!-- <li><a href="#what">What to avoid</a></li>  -->
  <li><a href="#content">Content and design</a></li>
  <li><a href="#how">How to implement</a></li>
  <li><a href="#research">Research and rationale</a></li>
  <li><a href="#changes">Latest changes</a></li>
</ul>
<h2 id="when">When to use</h2>
<p>The About the [institution] section is a mandatory pattern on an Institutional landing page.  It must include Mandate and Transparency links.</p>
<h2 id="content">Content and design</h2>
<p>Find content and design specifications and visual examples.</p>
<h3>Content specifications</h3>
<ul>
  <li>The heading is “About” followed by the name of the institution</li>
  <li>The heading appears above the links on all screen sizes</li>
  <li>Links can include <strong>corporate information</strong> and <strong>business lines</strong>, such as
    <ul>
      <li>institutional mandate and organizational structure</li>
      <li>performance reporting and transparency</li>
      <li>job opportunities</li>
    </ul>
  </li>
  <li>Links can include <strong>program and policy development information</strong>, such as
    <ul>
      <li>information about programs and policies, and activities related to their development</li>
      <li>background information about what is presented on a topic page</li>
      <li>program descriptions, policies, research papers, consultations, statistics, legislation, etc.</li>
    </ul>
  </li>
  <li>Organize the links in a bulleted list</li>
  <li>Make bullets visible so links are easy to scan</li>
  <li>Recommended maximum of 10 links</li>
  <li>Use task-oriented, plain language link labels (avoid program names or titles that may be unfamiliar to people)</li>
  <li>The list of links appears in:
    <ul>
      <li>2 columns on large screens</li>
      <li>1 column on small screens</li>
    </ul>
  </li>
</ul>
<h3>Design specifications</h3>
<ul>
  <li>Background color: #f5f5f5</li>
  <li>Text size: Noto sans: 19px ?</li>
  <li>Heading:  H2, Lato: 1.2em</li>
  <li>Font-weight: Bold?</li>
  <li>Line-height of li: 2em</li>
  <li>Layout: 2 columns of bullets in large and medium viewport, single column in small viewports</li>
</ul>
<h2 id="how">How to implement</h2>
<h3>Visual examples</h3>
<div class="pattern-demo mrgn-tp-md">
  <figure class="mrgn-bttm-md">
    <figcaption><b>About [institution name] – large screen</b></figcaption>
    <img src="./images/ilp-about-lg-en.png" class="img-responsive" alt="">
    <details>
      <summary class="wb-toggle small" data-toggle="{&quot;print&quot;:&quot;on&quot;}">Image description: About [institution name] – large screen</summary>
      <p class="mrgn-tp-lg">About [institution name] links appear in a section with the heading “About [institution name]”.  Links are organized in a bulleted list:</p>
      <ul>
        <li>Mandate</li>
        <li>Organizational structure</li>
        <li>Transparency</li>
        <li>Job opportunities</li>
        <li>Reports</li>
        <li>Compliance</li>
        <li>Enforcements notifications</li>
        <li>[institutional link]</li>
        <li>[institutional link]</li>
        <li>More: About the institution</li>
      </ul>
    </details>
  </figure>
</div>
<div class="pattern-demo mrgn-tp-md">
  <figure class="mrgn-bttm-md">
    <figcaption><b>About [institution name] – small screen</b></figcaption>
    <img src="./images/ilp-about-sm-en.png" class="img-responsive" alt="">
    <details>
      <summary class="wb-toggle small" data-toggle="{&quot;print&quot;:&quot;on&quot;}">Image description: About [institution name] – small screen</summary>
      <p class="mrgn-tp-lg">About [institution name] links appear in a section with the heading “About [institution name]”.  Links are organized in a bulleted list:</p>
      <ul>
        <li>Mandate</li>
        <li>Organizational structure</li>
        <li>Transparency</li>
        <li>Job opportunities</li>
        <li>Reports</li>
        <li>Compliance</li>
        <li>Enforcements notifications</li>
        <li>[institutional link]</li>
        <li>[institutional link]</li>
        <li>More: About the institution</li>
      </ul>
    </details>
  </figure>
</div>
<h3>GCweb (WET) theme implementation reference</h3>
<p>The implementation reference includes how to configure each element of the header.</p>
<ul>
  <li><a href="https://wet-boew.github.io/GCWeb/docs/implementing-en.html">Quick implementation guide - GCWeb theme</a></li>
</ul>
<h3>Implementations</h3>
<p>Refer to your implementation's guidance to code links.</p>
<div class="row">
  <div class="col-md-8">
    <div class="wb-tabs mrgn-tp-lg">
      <div class="tabpanels">
        <details id="004" open="open">
          <summary><strong>GC-AEM</strong></summary>
          <p class="mrgn-tp-lg">For the Government of Canada Adobe Experience Manager (AEM):</p>
          <ul>
            <li><a href="https://www.gcpedia.gc.ca/wiki/AEM_GC-specific_Documentation_6.5">AEM/Managed Web Service documentation (GCPedia link - only available on the Government of Canada network)</a></li>
          </ul>
        </details>
        <details id="005">
          <summary><strong>CDTS</strong></summary>
          <p class="mrgn-tp-lg">For the Centrally Deployed Templates Solution (CDTS):</p>
          <ul>
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
<!--<h3>Research findings</h3>-->
<h3>Policy rationale</h3>
<p>The About [institution name] section is a mandatory section on Institution landing pages under the Content and Information Architecture Specification.</p>
<p>The About [institution name] links include:</p>
<ul>
  <li><a href="https://www.canada.ca/en/treasury-board-secretariat/services/government-communications/canada-content-information-architecture-specification/organizing-content.html#corporate">Corporate information</a></li>
  <li><a href="https://www.canada.ca/en/treasury-board-secretariat/services/government-communications/canada-content-information-architecture-specification/organizing-content.html#program">Program and policy development</a></li>
</ul>
<h2 id="changes">Latest changes</h2>
<dl class="dl-horizontal">
  <dt>
    <time datetime="2023-MM-DD" class="link-muted">2023-MM-DD</time>
  </dt>
  <dd>Added About [institution name] guidance to support updates to the Institutional landing page</dd>
</dl>

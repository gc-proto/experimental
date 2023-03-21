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
title: "Global header"
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
  <figure class="mrgn-bttm-sm"><img src="https://design.canada.ca/images/breadcrumb-en.png" class="img-responsive" alt=""></figure>
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
Canada.ca &#8250; Immigration and citizenship &#8250; Canadian citizenship &#8250; Apply for Canadian citizenship &#8250; Prepare for the Canadian citizenship test and interview

Can be shortened to this: 

Canada.ca &#8250; Immigration and citizenship &#8250; Canadian citizenship &#8250; Apply &#8250; Prepare for the test and interview
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
<details>
  <summary class="bg-info">Standard pages</summary>
  <div class="pattern-demo mrgn-tp-lg">
    <figure>
      <figcaption><b>Global header – large screen</b></figcaption>
      <img src="https://design.canada.ca/images/sign-in-desktop-en.jpg" class="img-responsive" alt="Diagram of global header for large screens. Text version below:">
      <details>
        <summary class="wb-toggle small" data-toggle="{&quot;print&quot;:&quot;on&quot;}">Text version</summary>
        <p class="mrgn-tp-lg">On large screens, the global header on a standard page has 4 rows:</p>
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
      <img src="https://design.canada.ca/images/sign-in-mobile-en.jpg" class="img-responsive" alt="Diagram of global header for small screens. Text version below:">
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
</details>
<details>
  <summary class="bg-info">Transactional pages</summary>
  <div class="pattern-demo mrgn-tp-lg">
    <figure>
      <figcaption><b>Minimum global header - large screen</b></figcaption>
      <img src="https://test.canada.ca/experimental/design-system/images/global-header-transactional-desktop-en.png" class="img-responsive" alt="Diagram of global header for large screens. Text version below:">
      <details>
        <summary class="wb-toggle small" data-toggle="{&quot;print&quot;:&quot;on&quot;}">Text version</summary>
        <p class="mrgn-tp-lg">On large screens, the minimum global header on a transactional page has 2 rows:</p>
        <ol>
          <li>Language toggle in the top-right corner</li>
          <li>Government of Canada signature in the top-left corner with a divider line underneath</li>
        </ol>
      </details>
    </figure>
  </div>
  <div class="pattern-demo mrgn-tp-lg">
    <figure>
      <figcaption><b>Minimum global header - small screen</b></figcaption>
      <img src="https://test.canada.ca/experimental/design-system/images/global-header-transactional-small-en.png" class="img-responsive" alt="Diagram of global header for small screens. Text version below:">
      <details>
        <summary class="wb-toggle small" data-toggle="{&quot;print&quot;:&quot;on&quot;}">Text version</summary>
        <p class="mrgn-tp-lg">On small screens, the minimum global header on a transactional page has a single row:</p>
        <ol>
          <li>Government of Canada signature in the top-left corner, language toggle in the top-right corner, with a divider line underneath</li>
        </ol>
      </details>
    </figure>
  </div>
</details>
<details>
  <summary class="bg-info">Campaign pages</summary>
  <div class="pattern-demo mrgn-tp-lg">
    <figure>
      <figcaption><b>Minimum global header - large screen</b></figcaption>
      <img src="https://test.canada.ca/experimental/design-system/images/global-header-campaign-desktop-en.png" class="img-responsive" alt="Diagram of global header for large screens. Text version below:">
      <details>
        <summary class="wb-toggle small" data-toggle="{&quot;print&quot;:&quot;on&quot;}">Text version</summary>
        <p class="mrgn-tp-lg">On large screens, the minimum global header on a campaign page has 3 rows:</p>
        <ol>
          <li>Language toggle in the top-right corner</li>
          <li>Government of Canada signature in the top-left corner, site search box on the right</li>
          <li>Below a divider line, the breadcrumb on the left</li>
        </ol>
      </details>
    </figure>
  </div>
  <div class="pattern-demo mrgn-tp-lg">
    <figure>
      <figcaption><b>Minimum global header - small screen</b></figcaption>
      <img src="https://test.canada.ca/experimental/design-system/images/global-header-campaign-small-en.png" class="img-responsive" alt="Diagram of global header for small screens. Text version below:">
      <details>
        <summary class="wb-toggle small" data-toggle="{&quot;print&quot;:&quot;on&quot;}">Text version</summary>
        <p class="mrgn-tp-lg">On small screens, the minimum global header on a campaign page has 3 rows:</p>
        <ol>
          <li>Government of Canada signature in the top-left corner, language toggle on the far right</li>
          <li>Site search box directly below, it spans the entire row</li>
          <li>Below a divider line, the breadcrumb on the left</li>
        </ol>
      </details>
    </figure>
  </div>
</details>
<h2 id="implementation">How to implement</h2>
<p>Find working examples and code for implementing the header.</p>
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
<div class="cnt-wdth-lmtd">
  <h2 id="research">Research and rationale</h2>
  <p>Consult research findings and policy rationale.</p>
  <h3>Research findings</h3>
  <p>Two research projects informed the latest updates to the header guidance.</p>
  <h4>Trust Signals for Canada.ca study</h4>
  <p>Our Canada.ca trust study and prior research show that a consistent header is necessary to maintaining a trusted brand.</p>
  <p>For example, people trust:</p>
  <ul>
    <li>the flag in the Government of Canada signature more when it’s red</li>
    <li>a white background more than dark mode</li>
  </ul>
  <p>If you want to know more about this research, contact the Digital Transformation Office at <a href="mailto:dto.btn@tbs-sct.gc.ca">dto.btn@tbs-sct.gc.ca</a>.</p>
  <h4>Wayfinding on Canada.ca project</h4>
  <p>We updated the global header for Canada.ca to align with a new overall navigation strategy that came out of the Wayfinding research project.</p>
  <ul>
    <li><a href="https://blog.canada.ca/research-summaries/wayfinding-on-canada-ca">Wayfinding on Canada.ca research summary</a><br>
      Explains the context of the research and the insights that drove the design updates.</li>
    <li><a href="https://blog.canada.ca/2022/12/21/wayfinding-research-project">Wayfinding research project improves our approach to navigation on Canada.ca</a><br>
      This blog post explains the changes that are being made to the Canada.ca design, and how they are being implemented.</li>
  </ul>
  <h3>Policy rationale</h3>
  <p>This pattern is a mandatory element of the Content and Information Architecture Specification.</p>
  <ul>
    <li><a href="https://www.canada.ca/en/treasury-board-secretariat/services/government-communications/canada-content-information-architecture-specification/mandatory-elements.html">Mandatory elements of the design system</a></li>
  </ul>
  <h2 id="changes">Latest changes</h2>
  <dl class="dl-horizontal">
    <dt>
      <time datetime="YYYY-MM-DD" class="link-muted">YYYY-MM-DD</time>
    </dt>
    <dd>Updated pattern to reflect design changes from the trust study and wayfinding project, added visual examples for the different types of pages, included links to research projects that inform header guidance</dd>
    <dt>
      <time datetime="2022-08-17" class="link-muted">2022-08-17</time>
    </dt>
    <dd>Updated content design for clarity, added contextual Sign in button, added implementation resources to the global header</dd>
    <dt>
      <time datetime="2020-06-25" class="link-muted">2020-06-25</time>
    </dt>
    <dd>The small screen version was modified to a slimmer version</dd>
  </dl>
  <h2 id="discussion">Discussion</h2>
  <ul>
    <li><a href="https://github.com/canada-ca/design-system/issues">Discuss the pattern in GitHub Issues</a></li>
    <li><a href="http://design-GC-conception.slack.com">Join the conversation on Slack</a></li>
  </ul>
</div>

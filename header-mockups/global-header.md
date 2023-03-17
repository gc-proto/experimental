---
altLangPage: "/resumes-recherche/design-conversationnel"
author: Treasury Board Secretariat of Canada
breadcrumbs:
  - title: "About Canada.ca"
    link:  "https://www.canada.ca/en/government/about.html"
  - title: Canada.ca design system
    link: "https://www.canada.ca/en/government/about/design-system.html"
css:
- https://design.canada.ca/css/split-h1.css
- https://design.canada.ca/css/custom.css
- https://use.fontawesome.com/releases/v5.15.4/css/all.css
date: 2022-08-17
dateModified: 2023-03-17
description: "Guidance about using the global header on Canada.ca. The global header is at the top of each Government of Canada web page."
lang: en
layout: without-h1
share: true
pageclass: cnt-wdth-lmtd1
title: "Global header"
---
<h1 property="name" id="wb-cont" dir="ltr"><span class="stacked"><span>Global header</span>: <span>Canada.ca design system</span></span></h1>
<div class="cnt-wdth-lmtd">
  <div class="row">
    <div class="col-md-12 pull-left">
      <ul class="list-inline small mrgn-bttm-sm" style="line-height:1.65em" id="list-inline-desktop-only">
        <li class="mrgn-rght-lg"> Last updated: YYYY-MM-DD</li>
      </ul>
    </div>
  </div>
  <p><span class="label label-danger">Mandatory on standard pages</span></p>
  <p>The global header is at the top of each web page from the Government of Canada.</p>
  <p>Having the same global header on all pages:</p>
  <ul>
    <li>strengthens the Canada.ca brand</li>
    <li>promotes trust</li>
    <li>provides a unified experience on the Government of Canada web presence</li>
    <li>allows navigation across the broad range of services and information offered</li>
  </ul>
  <p><strong>2023 design update</strong>: We’ve recently updated this pattern as part of a new navigation strategy coming out of the Wayfinding research project. To find out more about this project, visit Research and rationale.</p>
  <div class="pattern-demo mrgn-tp-lg">
    <figure class="mrgn-bttm-sm"><img src="https://design.canada.ca/images/sign-in-desktop-en.jpg" class="img-responsive" alt=""></figure>
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
  <p>The global header is mandatory on all Government of Canada web pages. Determine which header elements to use based on the type of page you’re creating.</p>
  <!--<ul>
  <li><a href="global-header.html#001">Standard pages</a></li>
  <li><a href="global-header.html#002">Transactional pages</a></li>
  <li><a href="global-header.html#003">Campaign pages</a></li>
</ul>--> 
</div>
<div class="row">
  <div class="col-md-8">
    <div class="wb-tabs mrgn-tp-lg">
      <div class="tabpanels">
        <details id="001" open="open">
          <summary><strong>Standard pages</strong></summary>
          <p class="mrgn-tp-lg"><strong>Standard pages</strong> are pages where people can navigate away without losing data, triggering errors or terminating their session.</p>
          <h3>Global header requirements for a standard page</h3>
          <div class="panel panel-default mrgn-tp-md">
            <table class="table table-striped" id="mandatory-01" aria-live="polite">
              <caption class="wb-inv">
              Global header requirements
              </caption>
              <thead>
                <tr>
                  <th class="col-md-8">Header element</th>
                  <th class="col-md-4">Mandatory</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td><a href="signature.html">Government of Canada signature (linked to Canada.ca home)</a></td>
                  <td><span class="far fa-check-circle text-success"></span><span class="wb-inv"> Mandatory</span></td>
                </tr>
                <tr>
                  <td><a href="https://design.canada.ca/common-design-patterns/language-toggle.html">Language toggle</a></td>
                  <td><span class="far fa-check-circle text-success"></span><span class="wb-inv"> Mandatory</span></td>
                </tr>
                <tr>
                  <td><a href="https://design.canada.ca/common-design-patterns/search-box.html">Site search box</a></td>
                  <td><span class="far fa-check-circle text-success"></span><span class="wb-inv"> Mandatory</span></td>
                </tr>
                <tr>
                  <td>Divider line</td>
                  <td><span class="far fa-check-circle text-success"></span><span class="wb-inv"> Mandatory</span></td>
                </tr>
                <tr>
                  <td><a href="https://design.canada.ca/common-design-patterns/site-menu.html">Theme and topic menu</a></td>
                  <td><span class="far fa-check-circle text-success"></span><span class="wb-inv"> Mandatory</span> <span class="small">(<a href="#smenu-note" id="smenu">Note</a>)</span></td>
                </tr>
                <tr>
                  <td><a href="https://design.canada.ca/common-design-patterns/breadcrumb-trail.html">Breadcrumb trail</a></td>
                  <td><span class="far fa-check-circle text-success"></span><span class="wb-inv"> Mandatory</span></td>
                </tr>
                <tr>
                  <td><a href="https://design.canada.ca/common-design-patterns/sign-in.html">Sign in button</a></td>
                  <td>Optional</td>
                </tr>
                <tr>
                  <td>Background colour (white)</td>
                  <td><span class="far fa-check-circle text-success"></span><span class="wb-inv"> Mandatory</span></td>
                </tr>
              </tbody>
              <tfoot>
                <tr>
                  <td colspan="2"><div class="fn-rtn small mrgn-tp-md" id="smenu-note">
                      <p><a href="#smenu-note"><span class="wb-inv">Return to footnote </span>Note<span class="wb-inv"> referrer</span></a>: The menu must be applied to theme and topic pages. It can be removed from a standard page or group of pages when analytics show that the menu is used in less than 1% of visits.</p>
                    </div></td>
                </tr>
              </tfoot>
            </table>
          </div>
        </details>
        <details id="002">
          <summary><strong>Transactional pages</strong></summary>
          <p class="mrgn-tp-lg"><strong>Transactional web pages</strong> are pages with an interaction task where people might lose data, trigger errors, or terminate their session if they navigate away from the page.</p>
          <h3>Global header requirements for transactional pages</h3>
          <div class="panel panel-default mrgn-tp-md">
            <table class="table table-striped" id="mandatory-02" aria-live="polite">
              <caption class="wb-inv">
              Global header requirements
              </caption>
              <thead>
                <tr>
                  <th class="col-md-8">Header element</th>
                  <th class="col-md-4">Mandatory</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td><a href="signature.html">Government of Canada signature (linked to Canada.ca home)</a></td>
                  <td><span class="far fa-check-circle text-success"></span><span class="wb-inv"> Mandatory</span> <span class="small">(Link to Canada.ca home page is optional)</span></td>
                </tr>
                <tr>
                  <td><a href="https://design.canada.ca/common-design-patterns/language-toggle.html">Language toggle</a></td>
                  <td><span class="far fa-check-circle text-success"></span><span class="wb-inv"> Mandatory</span> <span class="small">(<a href="#lt-note" id="lt">Note</a>)</span></td>
                </tr>
                <tr>
                  <td><a href="https://design.canada.ca/common-design-patterns/search-box.html">Site search box</a></td>
                  <td>Optional</td>
                </tr>
                <tr>
                  <td><a href="https://design.canada.ca/common-design-patterns/sign-in.html">Sign in button</a></td>
                  <td>Optional</td>
                </tr>
                <tr>
                  <td>Divider line</td>
                  <td><span class="far fa-check-circle text-success"></span><span class="wb-inv"> Mandatory</span></td>
                </tr>
                <tr>
                  <td><a href="https://design.canada.ca/common-design-patterns/site-menu.html">Theme and topic menu</a></td>
                  <td>Optional</td>
                </tr>
                <tr>
                  <td><a href="https://design.canada.ca/common-design-patterns/breadcrumb-trail.html">Breadcrumb trail</a></td>
                  <td>Optional</td>
                </tr>
                <tr>
                  <td>Background colour (white)</td>
                  <td><span class="far fa-check-circle text-success"></span><span class="wb-inv"> Mandatory</span></td>
                </tr>
              </tbody>
              <tfoot>
                <tr>
                  <td colspan="2"><div class="fn-rtn small mrgn-tp-md" id="lt-note">
                      <p><a href="#lt"><span class="wb-inv">Return to footnote </span>Note<span class="wb-inv"> referrer</span></a>: New transactional pages for web applications must allow people to toggle between official languages. Legacy web applications that don’t support toggling should be updated or replaced. Until then, you can omit the language toggle if its use results in a loss of data.</p>
                    </div></td>
                </tr>
              </tfoot>
            </table>
          </div>
        </details>
        <details id="003">
          <summary><strong>Campaign pages</strong></summary>
          <p class="mrgn-tp-lg"><strong>Campaign pages</strong> are landing pages for external marketing or advertising campaigns. The flexibility in layout allows institutions to match elements of their external campaign with the landing page.</p>
          <h3>Global header requirements for a campaign page</h3>
          <div class="panel panel-default mrgn-tp-md">
            <table class="table table-striped" id="mandatory-03" aria-live="polite">
              <caption class="wb-inv">
              Global header requirements
              </caption>
              <thead>
                <tr>
                  <th class="col-md-8">Header element</th>
                  <th class="col-md-4">Mandatory</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td><a href="signature.html">Government of Canada signature (linked to Canada.ca home)</a></td>
                  <td><span class="far fa-check-circle text-success"></span><span class="wb-inv"> Mandatory</span></td>
                </tr>
                <tr>
                  <td><a href="https://design.canada.ca/common-design-patterns/language-toggle.html">Language toggle</a></td>
                  <td><span class="far fa-check-circle text-success"></span><span class="wb-inv"> Mandatory</span></td>
                </tr>
                <tr>
                  <td><a href="https://design.canada.ca/common-design-patterns/search-box.html">Site search box</a></td>
                  <td><span class="far fa-check-circle text-success"></span><span class="wb-inv"> Mandatory</span></td>
                </tr>
                <tr>
                  <td><a href="https://design.canada.ca/common-design-patterns/sign-in.html">Sign in button</a></td>
                  <td>Optional</td>
                </tr>
                <tr>
                  <td>Divider line</td>
                  <td><span class="far fa-check-circle text-success"></span><span class="wb-inv"> Mandatory</span></td>
                </tr>
                <tr>
                  <td><a href="https://design.canada.ca/common-design-patterns/site-menu.html">Theme and topic menu</a></td>
                  <td>Optional</td>
                </tr>
                <tr>
                  <td><a href="https://design.canada.ca/common-design-patterns/breadcrumb-trail.html">Breadcrumb trail</a></td>
                  <td><span class="far fa-check-circle text-success"></span><span class="wb-inv"> Mandatory</span></td>
                </tr>
                <tr>
                  <td>Background colour (white)</td>
                  <td><span class="far fa-check-circle text-success"></span><span class="wb-inv"> Mandatory</span></td>
                </tr>
              </tbody>
            </table>
          </div>
        </details>
      </div>
    </div>
  </div>
</div>
<div class="cnt-wdth-lmtd">
  <h2 id="avoid">What to avoid</h2>
  <p>Don’t customize the mandatory elements of the global header, beyond what is recommended in the guidance for each. Consistency in this space is essential for building brand awareness and user trust.</p>
  <p>For example, the flag symbol in the Government of Canada signature should always be the proper red and the first breadcrumb link should always be labeled “Canada.ca” and point to the Canada.ca home page.</p>
  <h2 id="content">Content and design</h2>
  <p>Find content and design specifications and visual examples.</p>
  <ul>
    <li>Government of Canada signature</li>
    <li>Language toggle</li>
    <li>Site search box</li>
    <li>Sign in button</li>
    <li>Theme and topic menu</li>
    <li>Breadcrumb trail</li>
  </ul>
  <h3>Visual examples</h3>
  <h4>Standard pages</h4>
  <div class="pattern-demo mrgn-tp-lg">
    <figure>
      <figcaption><b>Global header – large screen</b></figcaption>
      <img src="https://design.canada.ca/images/sign-in-desktop-en.jpg" class="img-responsive" alt="Diagram of global header for large screens. Text version below:">
      <details>
        <summary class="wb-toggle small" data-toggle="{&quot;print&quot;:&quot;on&quot;}">Text version</summary>
        <p class="mrgn-tp-lg">The global header has the Government of Canada signature in the top left. Under the signature is the theme and topic menu, and under the menu is the breadcrumb trail. The language toggle link is at the rop right. Under the language toggle is the site search box. </p>
      </details>
    </figure>
  </div>
  <div class="pattern-demo mrgn-tp-lg">
    <figure>
      <figcaption><b>Global header – small screen</b></figcaption>
      <img src="https://design.canada.ca/images/sign-in-mobile-en.jpg" class="img-responsive" alt="Diagram of global header for small screens. Text version below:">
      <details>
        <summary class="wb-toggle small" data-toggle="{&quot;print&quot;:&quot;on&quot;}">Text version</summary>
        <p class="mrgn-tp-lg">The global header has the Government of Canada signature in the top left.  The language toggle link is at the rop right. Under the signature and the language toggle is the site search box. Under the search box is the theme and topic menu. Under the theme and topic menu is the breadcrumb trail.</p>
      </details>
    </figure>
  </div>
  <h2 id="implementation">Implementation resources</h2>
  <ul>
    <li><a href="https://cenw-wscoe.github.io/sgdc-cdts/docs/index-en.html">Centrally Deployed Templates Solution (CDTS)</a>
      <ul>
        <li><a href="https://cdts.service.canada.ca/app/cls/WET/gcweb/v4_0_47/cdts/samples/">CDTS Samples</a> - provides links to sample pages that demonstrate how to implement various CDTS features </li>
      </ul>
    </li>
    <li><a href="https://wet-boew.github.io/GCWeb/docs/implementing-en.html">GCWeb (WET)</a></li>
    <li><a href="https://drupalwxt.github.io/en/docs/environment/">Drupal WxT</a></li>
    <li>AEM/Managed Web Service - documentation for AEM is available on GCpedia</li>
  </ul>
  <h2 id="changes">Latest changes</h2>
  <dl class="dl-horizontal">
    <dt>
      <time datetime="2022-08-17" class="link-muted">2022-08-17</time>
    </dt>
    <dd>Updated content design for clarity, added contextual Sign in button, added implementation resources to the global header </dd>
    <dt>
      <time datetime="2020-06-25" class="link-muted">2020-06-25</time>
    </dt>
    <dd>The small screen version was modified to a slimmer version</dd>
  </dl>
</div>

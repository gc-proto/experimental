---
altLangPage: false
breadcrumbs: false
css:
- https://design.canada.ca/css/split-h1.css
- https://design.canada.ca/css/custom.css
- https://use.fontawesome.com/releases/v5.15.4/css/all.css
- https://prycrane.github.io/experimental/prycrane/datatables/css/datatables-fun.css
date: 2023-03-15
dateModified: 2023-03-28
description: "Continuous improvement of web content"
lang: en
layout: form
share: false
nositesearch: true
showFeedback: false
noReportProblem: true
nomenu: true
pageclass: cnt-wdth-lmtz
title: "Global header documentation"
---
<h1 property="name" id="wb-cont" dir="ltr"><span class="stacked"><span>Global header documentation</span>: <span>Principal Publisher documentation</span></span></h1>
<div class="row">
  <div class="col-md-7">
    <p>Our goal is to make the Principal Publisher’s header documentation work (dance) well with the design guidance. The primary focus is to make using and configuring the new header easy.</p>
    <h2 class="mrgn-tp-lg">Problems we’re trying to solve</h2>
    <ul>
      <li>Create more obvious link with Canada.ca design system so users can easily navigate between guidance and technical implementation instructions</li>
      <li>Make it easier to find the correct code, especially for anyone with a non-AEM implementation</li>
      <li>How to proceed if our approach is:
        <ul>
          <li>Understand how it works: DTO documentation provides design specs, visual examples + what the configurations options are</li>
          <li>Do it: GCWeb documentation captures technical details of how to do the configuration </li>
        </ul>
      </li>
    </ul>
    <h2 class="mrgn-tp-lg">Current live page</h2>
    <ul>
      <li><a href="https://wet-boew.github.io/GCWeb/sites/header/header-docs-en.html">Header (WET BOEW)</a></li>
    </ul>
    <h2>Working document</h2>
    <ul class="list-unstyled fa-ul">
      <li><span class="fa-li"><span class="fab fa-google-drive"></span></span><a href="https://docs.google.com/document/d/1YY6JkiJ3nRywwalKJfCxSbqHn2z0SlfvFC8y4eBOrhU">Global header working document to propose changes (Google doc)</a></li>
    </ul>
    <h2>Mockups</h2>
    <p>Each of these mockups presents a possible approach to updating the GCWeb documentation. These are draft ideas to spark discussion as to what is realistic right away, so we can land on an approach together and then work through the details of the prototype to create final content.</p>
    <p>What is realistic but also impactful enough to:</p>
    <ul>
      <li>Improve task success (being able to use the code)
        <ul>
          <li>Provide consistent links to available documentation and technical spaces (when Github vs working example, vs something else like the Authentication page?)</li>
          <li>Help different users (AEM, CDTS, Drupal, Using Jekyll templates, Just HTML, Custom uses)</li>
        </ul>
      </li>
      <li>Understand what's mandatory depending on the type of page</li>
      <li>Understand how GCWeb (header) documentation IA works
        <ul>
          <li>Some elements of the header have their own documentation elsewhere in GCWeb - Examples: Authentication, menu, breadcrumb</li>
        </ul>
      </li>
    </ul>
    <ol class="mrgn-tp-lg">
      <li><a href="gcweb-02.html">Global header - Basic</a><br>
        Changes to the introduction and How to implement section only:
        <ul>
          <li>adding a table at the top to bring all “version statistics” together in one place (do people need this information?)</li>
          <li>adding On this page for easier navigation and scent of information</li>
          <li>expanding Purpose to include available components</li>
          <li>adding Page types to reference the different types of pages and point back to the Design system guidance for details of what you can and can’t do</li>
          <li>addition of a transactional page working example as a lot of people need this</li>
        </ul>
      </li>
    </ol>
    <p>Note on working examples: lack of consistency between what each link points to, should we re-title or adjust to be either true working examples or simple visual examples?</p>
    <ol class="mrgn-tp-lg" start="2">
      <li><a href="gcweb-01.html">Global header - Medium</a><br>
        Changes include code presentation and connection to appropriate Github repository</li>
    </ol>
    <ol class="mrgn-tp-lg" start="3">
      <li><a href="/experimental/catalina/proto-header.html">Global header - Advance (Dynamic template builder)</a><br>
        The Template builder asks how we can pull code based on a person's needs
        <ul>
          <li>PP is the authoritative source of the code but DTO pulls it into the guidance documentation dynamically</li>
          <li>Instead of having multiple pages as the footer, have all the code on one page</li>
          <li>This is JUST a proof of concept. Code is not correct. We need PP to provide the correct code for each variation (8 in total without including the breadcrumb trail component)</li>
          <li>The breadcrumb option is missing</li>
        </ul>
      </li>
    </ol>
  </div>
  <div class="col-md-5">
    <div><img src="./images/dance1.png" alt="" class="img-responsive"></div>
  </div>
</div>

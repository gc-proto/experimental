---
altLangPage: false
breadcrumbs:
  - title: Peter's warrren
    link: "https://test.canada.ca/experimental/prycrane/"
css:
- https://design.canada.ca/css/split-h1.css
- https://design.canada.ca/css/custom.css
- https://use.fontawesome.com/releases/v5.15.4/css/all.css
- https://test.canada.ca/experimental/prycrane/datatables/css/datatables-fun.css
date: 2023-05-25
dateModified: 2023-05-25
description: "Instructions to update the datatable for the Find Guidance table on the design system's landing page and the all templates and patterns table on the Template and pattern library page."
language: en
layout: form
share: false
nositesearch: true
showFeedback: false
nomenu: true
noReportProblem: true
title: "How to update the Find Guidance and All templates and patterns DataTables"
---
<div class="row">
  <div class="col-md-8">
    <h1 property="name" id="wb-cont" dir="ltr"><span class="stacked"><span>How to update the "Find Guidance" and "All templates and patterns" DataTables</span>: <span>Canada.ca design system</span></span></h1>
    <p>So, you want to update the tables on:</p>
    <ul>
      <li><a href="https://www.canada.ca/en/government/about/design-system.html">Canada.ca design system (landing page)</a></li>
      <li><a href="https://www.canada.ca/en/government/about/design-system/pattern-library.html">Template and pattern library for Canada.ca</a></li>
    </ul>
    <p>Let's slay the DataTable dragon!</p>
    <h2 class="h3">DataTables and JSON data</h2>
    <p>The tables on these pages use the DataTables plugin and a JSON file.   It’s cooked into WET and GCWeb:</p>
    <ul>
      <li><a href="https://wet-boew.github.io/v4.0-ci/docs/ref/tables/tables-en.html">WET table documentation</a></li>
      <li><a href="https://design.canada.ca/common-design-patterns/tables.html">GCWEB tables documentation</a></li>
    </ul>
    <h2 class="h3">Location of the JSON files</h2>
    <h3 class="h4">design-system</h3>
    <ul>
      <li>File: <a href="https://design.canada.ca/ajax/patterns-01-en.json">https://design.canada.ca/ajax/patterns-01-en.json</a></li>
      <li>Github: <a href="https://github.com/canada-ca/design-system/blob/master/ajax/patterns-01-en.json">https://github.com/canada-ca/design-system/blob/master/ajax/patterns-01-en.json</a></li>
    </ul>
    <h3 class="h4">systeme-conception</h3>
    <ul>
      <li>File: <a href="https://conception.canada.ca/ajax/patterns-01-fr.json">https://conception.canada.ca/ajax/patterns-01-fr.json</a></li>
      <li>Github: <a href="https://github.com/canada-ca/systeme-conception/blob/master/ajax/patterns-01-fr.json">https://github.com/canada-ca/systeme-conception/blob/master/ajax/patterns-01-fr.json</a></li>
    </ul>
    <h2 class="h3">JSON structure</h2>
    <table class="table">
  <caption class="wb-inv">
  JSON file data
  </caption>
  <thead>
    <tr>
      <th>Variable</th>
      <th>Description</th>
      <th>Display</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>NAME</td>
      <td>Description</td>
      <td>Page Display</td>
    </tr>
  </tbody>
</table>
  </div>
  <div class="col-md-4">
    <div><img src="./images/bunny28.png" alt="" class="img-responsive">
    </div>
  </div>
</div>

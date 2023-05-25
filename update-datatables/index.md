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
    <h2 class="h3">JSON data variables</h2>
    <table class="table table-bordered small">
      <caption class="wb-inv">
      JSON file data
      </caption>
      <thead>
        <tr>
          <th class="col-md-3">Variable</th>
          <th class="col-md-5">Description</th>
          <th class="col-md-4">Display</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>NAME</td>
          <td>Name of component.  Should be the same as the Metadata title</td>
          <td><ul>
              <li>DS landing page</li>
              <li>Templates and patterns</li>
            </ul></td>
        </tr>
        <tr>
          <td>SOURCE</td>
          <td>One of the following:
            <ul>
              <li>Blog post</li>
              <li>Content Style Guide</li>
              <li>Content and Information Architecture</li>
              <li>Designing content</li>
              <li>Research summary</li>
            </ul></td>
          <td><ul>
              <li>DS landing page</li>
              <li>Templates and patterns</li>
            </ul></td>
        </tr>
      </tbody>
    </table>
    <h2 class="h3">JSON structure</h2>
    <div class="wb-prettify1 all-pre1"></div>
    <pre class="small"><code> 
{
  &quot;data&quot;: [{
    &quot;NAME&quot;: &quot;&lt;a href=&quot;https://blog.canada.ca/research-summaries/wayfinding-on-canada-ca.html&quot;&gt;Wayfinding on Canada.ca&lt;/a&gt;&quot;,
    &quot;SOURCE&quot;: &quot;Research summary&quot;,
    &quot;DESCRIPTION&quot;: &quot;explains the context of the research and the insights that drove the design updates&quot;,
    &quot;WHENTOUSE&quot;: &quot;Explains the context of the research and the insights that drove the design updates&quot;,
    &quot;CATEGORY&quot;: &quot;&quot;,
    &quot;TYPE&quot;: &quot;&quot;,
    &quot;MANDATORY&quot;: &quot;&quot;,
    &quot;TANDP&quot;: &quot;0&quot;
  },{
    &quot;NAME&quot;: &quot;&lt;a href=&quot;{{ site.url }}/common-design-patterns/subway-navigation.html&quot;&gt;Subway navigation&lt;/a&gt;&quot;,
    &quot;SOURCE&quot;: &quot;Template and pattern library&quot;,
    &quot;DESCRIPTION&quot;: &quot;Break up long and complex content into sections that each focus on a step or specific answer people need before moving to the next step or section.&quot;,
    &quot;WHENTOUSE&quot;: &quot;Break up long and complex content into sections that each focus on a step or specific answer people need before moving to the next step or section.&quot;,
    &quot;CATEGORY&quot;: &quot;Design pattern&quot;,
    &quot;TYPE&quot;: &quot;Navigation&quot;,
    &quot;MANDATORY&quot;: &quot;No&quot;,
    &quot;TANDP&quot;: &quot;1&quot;
  }]
}
</code></pre>
  </div>
  <div class="col-md-4">
    <div><img src="./images/bunny28.png" alt="" class="img-responsive"> </div>
  </div>
</div>

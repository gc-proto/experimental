---
altLangPage: false
breadcrumbs:
  - title: Peter's warrren
    link: "https://test.canada.ca/experimental/prycrane/"
css:
- https://design.canada.ca/css/split-h1.css
- https://design.canada.ca/css/custom.css
- https://use.fontawesome.com/releases/v5.15.4/css/all.css
- https://test.canada.ca/experimental/update-datatables/css/cranecss.css
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
    <h2>On this page</h2>
    <ul>
      <li><a href="#a1">DataTables and JSON data</a></li>
      <li><a href="#a2">Location of the JSON files</a></li>
      <li><a href="#a3">JSON data variables</a></li>
      <li><a href="#a4">JSON structure</a></li>
      <li><a href="#a5">Show me the Dragon!</a></li>
    </ul>
    <h2 class="h3" id="a1">DataTables and JSON data</h2>
    <p>The tables on these pages use the DataTables plugin and a JSON file.   It’s cooked into WET and GCWeb:</p>
    <ul>
      <li><a href="https://wet-boew.github.io/v4.0-ci/docs/ref/tables/tables-en.html">WET table documentation</a></li>
      <li><a href="https://design.canada.ca/common-design-patterns/tables.html">GCWEB tables documentation</a></li>
    </ul>
    <h2 class="h3" id="a2">Location of the JSON files</h2>
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
    <h2 class="h3" id="a3">JSON data variables</h2>
    <p>The data in the JSON file populates both DataTables.  Only one file for each official language needs to be updated.</p>
    <table class="table table-bordered table-striped small small">
      <caption class="wb-inv">
      JSON file data
      </caption>
      <thead>
        <tr>
          <th class="col-md-3">Variable</th>
          <th class="col-md-5">Description</th>
          <th class="col-md-2">DS landing page</th>
          <th class="col-md-2">Templates and patterns</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>NAME</td>
          <td>Name of component.  Should be the same as the Metadata title</td>
          <td><i class="far fa-check-circle text-success"></i></td>
          <td><i class="far fa-check-circle text-success"></i></td>
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
          <td><i class="far fa-check-circle text-success"></i></td>
          <td><i class="far fa-check-circle text-success"></i></td>
        </tr>
        <tr>
          <td>DESCRIPTION</td>
          <td>Description should be the same as “Title” metadata (Still under consideratrion)</td>
          <td><i class="far fa-check-circle text-success"></i></td>
          <td></td>
        </tr>
        <tr>
          <td>WHENTOUSE</td>
          <td>Describes when the component is used.</td>
          <td></td>
          <td><i class="far fa-check-circle text-success"></i></td>
        </tr>
        <tr>
          <td>CATEGORY</td>
          <td>One of the following:
            <ul>
              <li>Design pattern</li>
              <li>Style</li>
              <li>Template</li>
            </ul></td>
          <td></td>
          <td><i class="far fa-check-circle text-success"></i></td>
        </tr>
        <tr>
          <td>TYPE</td>
          <td>One or more of the following:
            <ul>
              <li>Destination</li>
              <li>Government-wide</li>
              <li>Institutional</li>
              <li>Interaction</li>
              <li>Navigation</li>
              <li>Promotional</li>
              <li>Site-wide pattern</li>
              <li>Theme and topic</li>
              <li>Visual</li>
            </ul></td>
          <td><i class="far fa-check-circle text-success"></i></td>
          <td><i class="far fa-check-circle text-success"></i></td>
        </tr>
        <tr>
          <td>MANDATORY</td>
          <td>State "yes" for Mandatory elements.  If not, leave blank</td>
          <td></td>
          <td><i class="far fa-check-circle text-success"></i></td>
        </tr>
        <tr>
          <td>TANDP</td>
          <td>Does this record get displayed on the Templates and patterns table? <br>
            0 for no<br>
            1 for yes</td>
          <td></td>
          <td><i class="far fa-check-circle text-success"></i></td>
        </tr>
      </tbody>
    </table>
    <h2 class="h3" id="a4">JSON structure</h2>
    <pre><code>{% raw %}
{
   ---
   --- 
  &quot;data&quot;: [{
    &quot;NAME&quot;: &quot;&lt;a href=\&quot;https://blog.canada.ca/research-summaries/wayfinding-on-canada-ca.html\&quot;&gt;Wayfinding on Canada.ca&lt;/a&gt;&quot;,
    &quot;SOURCE&quot;: &quot;Research summary&quot;,
    &quot;DESCRIPTION&quot;: &quot;explains the context of the research and the insights that drove the design updates&quot;,
    &quot;WHENTOUSE&quot;: &quot;Explains the context of the research and the insights that drove the design updates&quot;,
    &quot;CATEGORY&quot;: &quot;&quot;,
    &quot;TYPE&quot;: &quot;&quot;,
    &quot;MANDATORY&quot;: &quot;&quot;,
    &quot;TANDP&quot;: &quot;0&quot;
  },{
    &quot;NAME&quot;: &quot;&lt;a href=\&quot;{{ site.url }}/common-design-patterns/subway-navigation.html\&quot;&gt;Subway navigation&lt;/a&gt;&quot;,
    &quot;SOURCE&quot;: &quot;Template and pattern library&quot;,
    &quot;DESCRIPTION&quot;: &quot;Break up long and complex content into sections that each focus on a step or specific answer people need before moving to the next step or section.&quot;,
    &quot;WHENTOUSE&quot;: &quot;Break up long and complex content into sections that each focus on a step or specific answer people need before moving to the next step or section.&quot;,
    &quot;CATEGORY&quot;: &quot;Design pattern&quot;,
    &quot;TYPE&quot;: &quot;Navigation&quot;,
    &quot;MANDATORY&quot;: &quot;No&quot;,
    &quot;TANDP&quot;: &quot;1&quot;
  }]
}
{% endraw %}
</code></pre>
    <h3 class="h4">Things to notice</h3>
    <ul>
      <li>The double <code>---</code> is required at the beginning of the file so Jekyll knows to process the file.
        <div class="mrgn-tp-md">
          <pre><code>{% raw %}
{
   ---
   --- 
   &quot;data&quot;: [{
{% endraw %}
</code></pre>
        </div>
      </li>
      <li>Quotations need to be escaped with \.  You can see this in the NAME variable for the link reference.  Any character can be escaped with \.
        <div class="mrgn-tp-md">
          <pre><code>{% raw %}
&quot;NAME&quot;: &quot;&lt;a href=\&quot;https://blog.canada.ca/research-summaries/wayfinding-on-canada-ca.html\&quot;&gt;Wayfinding on Canada.ca&lt;/a&gt;&quot;,
{% endraw %}
</code></pre>
        </div>
      </li>
      <li>For links in the design system, the domain is a Jekyll variable.
        <div class="mrgn-tp-md">
          <pre><code>{% raw %}
&quot;NAME&quot;: &quot;&lt;a href=\&quot;{{ site.url }}/common-design-patterns/...\&quot;&gt;Subway navigation&lt;/a&gt;&quot;,
{% endraw %}
</code></pre>
        </div>
      </li>
    </ul>
    <h2 class="h3" id="a5">Show me the Dragon!</h2>
    <ol class="lst-spcd">
      <li>Branch and make a pull request for each repository.</li>
      <li>Retrieve the files from GitHub
        <ul>
          <li><a href="https://github.com/canada-ca/design-system/blob/master/ajax/patterns-01-en.json">https://github.com/canada-ca/design-system/blob/master/ajax/patterns-01-en.json</a></li>
          <li><a href="https://github.com/canada-ca/systeme-conception/blob/master/ajax/patterns-01-fr.json">https://github.com/canada-ca/systeme-conception/blob/master/ajax/patterns-01-fr.json</a></li>
        </ul>
      </li>
      <li>You can update the existing JSON file as required.</li>
      <li>You can add new elements to the JSON file.  Use the following structure:
        <div class="mrgn-tp-md">
          <pre><code>{% raw %}
{
    &quot;data&quot;: [{
    &quot;NAME&quot;: &quot;&lt;a href=\[link]\&quot;&gt;[link name]&lt;/a&gt;&quot;,
    &quot;SOURCE&quot;: &quot; &quot;,
    &quot;DESCRIPTION&quot;: &quot; &quot;,
    &quot;WHENTOUSE&quot;: &quot; &quot;,
    &quot;CATEGORY&quot;: &quot; &quot;,
    &quot;TYPE&quot;: &quot; &quot;,
    &quot;MANDATORY&quot;: &quot; &quot;,
    &quot;TANDP&quot;: &quot; &quot;
  },
{% endraw %}
</code></pre>
        </div>
      </li>
      <li>Reminder:  if you want to item to appear on the Template and pattern library page, it must be declared in the data.
        <div class="mrgn-tp-md">
          <pre><code>{% raw %}
    &quot;TANDP&quot;: &quot;1&quot;
{% endraw %}
</code></pre>
        </div>
      </li>
      <li>Add the new elements to the top of the file.  Remember that each element is separated by a comma.</li>
      <li>Validate the JSON file at <a href="https://jsonlint.com/">JSONLint</a> (or use the validator of your choice).  You'll have to remove the "---" at ther top of the file for the file to validate.  Remember, it needs to be included when you publish the file.
        <div class="mrgn-tp-md">
          <pre><code>{% raw %}
{
   ---
   --- 
   &quot;data&quot;: [{
{% endraw %}
</code></pre>
        </div>
      </li>
      <li>Test and publish your pull request.</li>
    </ol>
  </div>
  <div class="col-md-4">
    <div><img src="./images/bunny28.png" alt="" class="img-responsive"> </div>
  </div>
</div>

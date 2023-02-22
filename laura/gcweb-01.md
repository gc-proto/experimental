---
altLangPage: "#"
breadcrumbs:
  - title: Not sure what we should do here <span class="far fa-smile-wink"></span>
  - link: "#"
css:
- https://design.canada.ca/css/split-h1.css
- https://design.canada.ca/css/custom.css
- https://use.fontawesome.com/releases/v5.15.4/css/all.css
date: 2023-02-23
dateModified: 2023-02-23
description: "Global header"
lang: en
layout: without-h1
pageclass: cnt-wdth-lmtd
title: "Global header"
---
<h1 property="name" id="wb-cont" dir="ltr"><span class="stacked"><span>Global header</span>: <span>Canada.ca design (Principle Publisher)</span></span></h1>
<div class="wb-prettify all-pre hide"></div>
<div class="row">
  <div class="col-md-8">
    <div class="panel panel-default">
      <header class="panel-heading">
        <h2 class="panel-title">Current iteration of the global header</h2>
      </header>
      <table class="table table-striped table-condensed small">
        <caption class="wb-inv">
        Current iteration of the global header
        </caption>
        <thead>
          <tr>
            <th class="col-md-4">Information</th>
            <th class="col-md-8" >Value</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td><strong>Status</strong></td>
            <td>Stable</td>
          </tr>
          <tr>
            <td><strong>Type</strong></td>
            <td>Canada.ca site functionality</td>
          </tr>
          <tr>
            <td><strong>API version</strong></td>
            <td>2.0</td>
          </tr>
          <tr>
            <td><strong>Component version</strong></td>
            <td>4.0.0</td>
          </tr>
          <tr>
            <td><strong>Template version</strong></td>
            <td>4.0</td>
          </tr>
          <tr>
            <td><strong>Visual rendering</strong></td>
            <td>1.0</td>
          </tr>
          <tr>
            <td><strong>Last review</strong></td>
            <td>2022-08-31</td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</div>
<h2>Purpose</h2>
<p>The global header serves as a container to display the various components that make up the header.</p>
<p>Available components include:</p>
<ul>
  <li>Government of Canada signature (always required)</li>
  <li>Language toggle (always required)</li>
  <li>Theme and topic menu</li>
  <li>Breadcrumb trail</li>
  <li>Site search box</li>
  <li>Sign in button</li>
</ul>
<h2>How to implement</h2>
<h3>Page types</h3>
<p>Components are used and configured for different page types.   Consult the Canada.ca Design system guidance for using these components on <strong>Standard</strong>, <strong>Transactional</strong>, and <strong>Campaign</strong> pages.</p>
<p><a href="https://design.canada.ca/common-design-patterns/global-header.html#when">When to use the global header</a></p>
<h3>Some working examples</h3>
<p>Here are some popular working examples.  It is not an exhaustive list of possible iterations.  Configure your page based on user needs and design system guidance.</p>
<ul>
  <li><a href="https://wet-boew.github.io/GCWeb/templates/content-en.html">Standard page including Header v4.0</a></li>
  <li><a href="https://wet-boew.github.io/GCWeb/sites/authentication/contextual-signin-en.html">Standard page including Header v4.0 and "Sign in" section</a></li>
  <li><a href="https://test.canada.ca/experimental/examples/layout-transactional-01-en.html">Transactional page including Header v4.0</a></li>
</ul>
<h3>Implementation notes</h3>
<p>Previous versions to Version 4.0 require <a href="https://wet-boew.github.io/GCWeb/sites/gcweb-menu/gcweb-menu-docs-en.html">gcweb-menu version 2.0</a> for some functionality (see the template section for more details).  The <code>&lt;div class="container"&gt;</code> element has been relocated to the global header.  It is no longer part of the "gcweb-menu" component.</p>
<h2>Evaluation and report</h2>
<p>There is no evaluation and report available for this component.</p>
<h2>API (Version 2.0)</h2>
<table class="table table-bordered">
  <caption class="wb-inv">
  API (Version 2.0)
  </caption>
  <tr>
    <th>Component version</th>
    <th>CSS Class</th>
    <th>Template</th>
    <th>Visual rendering</th>
    <th>Schema</th>
  </tr>
  <tr>
    <th>Version 4.0.0</th>
    <td>n.a.</td>
    <td>Version 4.0</td>
    <td>Version 1.0</td>
    <td>n.a.</td>
  </tr>
</table>
<details>
  <summary>Deprecated version (Deprecated version (What does depricated, but still supported mean?))</summary>
  <table class="table table-bordered">
    <tr>
      <th>Component version</th>
      <th>CSS Class</th>
      <th>Template</th>
      <th>Visual rendering</th>
      <th>Schema</th>
    </tr>
    <tr>
      <th>Version 3.0.0</th>
      <td>n.a.</td>
      <td>Version 3.0</td>
      <td>Version 1.0</td>
      <td>n.a.</td>
    </tr>
    <tr>
      <th>Version 2.0.0</th>
      <td>n.a.</td>
      <td>Version 2.0</td>
      <td>Version 1.0</td>
      <td>n.a.</td>
    </tr>
    <tr>
      <th>Version 1.0</th>
      <td>n.a.</td>
      <td>Version 1.0</td>
      <td>Version 1.0</td>
      <td>n.a.</td>
    </tr>
  </table>
</details>
<h2>Template</h2>
<h3>Changes between Version 4.0 and 3.0 (deprecated)</h3>
<div class="row">
  <div class="col-md-6">
    <pre><code>&lt;header&gt;
	&lt;div id=&quot;wb-bnr&quot; class=&quot;container&quot;&gt;
		&lt;div class=&quot;row&quot;&gt;
			&lt;!-- Language toggle [version 1.0] --&gt;
			&lt;!-- Branding [version 1.0] --&gt;
			&lt;!-- Search [version 1.0] --&gt;
		&lt;/div&gt;
	&lt;/div&gt;
	&lt;hr&gt;
	&lt;div class=&quot;container&quot;&gt;
		&lt;div class=&quot;row&quot;&gt;
			&lt;div class=&quot;col-md-8&quot;&gt;
				&lt;!-- Site Menu [version 2.0] --&gt;
			&lt;/div&gt;
		&lt;/div&gt;
	&lt;/div&gt;
	&lt;!-- Breadcrumbs [version 1.0] --&gt;
&lt;/header&gt;</code></pre>
    <p>There is no change between Version 4.0 and 3.0 unless the optional authentication component is used.</p>
  </div>
</div>
<h4>Including authentication section (optional)</h4>
<div class="row">
  <div class="col-md-6">
    <h4>Version 4.0</h4>
    <pre><code>&lt;header&gt;
	&lt;div id=&quot;wb-bnr&quot; class=&quot;container&quot;&gt;
		&lt;div class=&quot;row&quot;&gt;
			&lt;!-- Language toggle [version 1.0] --&gt;
			&lt;!-- Branding [version 1.0] --&gt;
			&lt;!-- Search [version 1.0] --&gt;
		&lt;/div&gt;
	&lt;/div&gt;
	&lt;hr&gt;
	&lt;div class=&quot;container&quot;&gt;
		&lt;div class=&quot;row&quot;&gt;
			&lt;div class=&quot;col-md-8&quot;&gt;
				&lt;!-- Site Menu [version 2.0] --&gt;
		&lt;/div&gt;
			&lt;div class=&quot;<strong class="h3">col-xs-<ins>6</ins> col-xs-offset-<ins>6</ins></strong> col-md-offset-0 col-md-4&quot;&gt;
				&lt;!-- Optional Authentication Section [version 1.0] --&gt;
			&lt;/div&gt;
		&lt;/div&gt;
	&lt;/div&gt;
	&lt;!-- Breadcrumbs [version 1.0] --&gt;
&lt;/header&gt;</code></pre>
    <p>The Version 4 authentication div is modified to <code>col-xs-6</code> and <code>col-xs-offset-6</code>.  This ensures that the text for the Theme and topic menu button stays on one line for every screen (xxs, xxs, sm, md, lg and xl).</p>
  </div>
  <div class="col-md-6">
    <h4>Version 3.0</h4>
    <pre><code>&lt;header&gt;
	&lt;div id=&quot;wb-bnr&quot; class=&quot;container&quot;&gt;
		&lt;div class=&quot;row&quot;&gt;
			&lt;!-- Language toggle [version 1.0] --&gt;
			&lt;!-- Branding [version 1.0] --&gt;
			&lt;!-- Search [version 1.0] --&gt;
		&lt;/div&gt;
	&lt;/div&gt;
	&lt;hr&gt;
	&lt;div class=&quot;container&quot;&gt;
		&lt;div class=&quot;row&quot;&gt;
			&lt;div class=&quot;col-md-8&quot;&gt;
				&lt;!-- Site Menu [version 2.0] --&gt;
			&lt;/div&gt;
			&lt;div class=&quot;<strong class="h3">col-xs-<del>5</del> col-xs-offset-<del>7</del></strong> col-md-offset-0 col-md-4&quot;&gt;
				&lt;!-- Optional Authentication Section [version 1.0] --&gt;
			&lt;/div&gt;
		&lt;/div&gt;
	&lt;/div&gt;
	&lt;!-- Breadcrumbs [version 1.0] --&gt;
&lt;/header&gt;</code></pre>
    <p>The Header for version 3.0 (including the authentication section) is deprecated, but still supported.  It requires the implementation of <a href="https://wet-boew.github.io/GCWeb/sites/gcweb-menu/gcweb-menu-docs-en.html">gcweb-menu version 2.0</a>.   The <code>&lt;div class="container"&gt;</code> is relocated in the header and no longer part of the "gcweb-menu" component.</p>
  </div>
</div>

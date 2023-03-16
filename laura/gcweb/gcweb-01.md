---
altLangPage: "#"
breadcrumbs:
- title: Not sure what we should do here
- link: https://test.canada.ca/experimental/laura/gcweb/gcweb-01.html
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
<h1 property="name" id="wb-cont" dir="ltr"><span class="stacked"><span>Global header</span>: <span>Canada.ca design (Principal Publisher)</span></span></h1>
<div class="wb-prettify all-pre hide"></div>
<div class="row">
  <div class="col-md-8">
    <div class="panel panel-info">
      <header class="panel-heading">
        <h2 class="panel-title">Current iteration</h2>
      </header>
      <table class="table table-bordered table-condensed small">
        <caption class="wb-inv">
        Current iteration of the global header
        </caption>
        <thead class="wb-inv">
          <tr>
            <th class="col-md-4 active h3">Information</th>
            <th class="col-md-8 active h3" >Value</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td class="col-md-4"><strong>Status</strong></td>
            <td class="col-md-8">Stable</td>
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
<h2>On this page</h2>
<ul>
  <li><a href="#purpose">Purpose</a></li>
  <li><a href="#implement">How to implement</a></li>
  <li><a href="#evaluation">Evaluation and report</a></li>
  <li><a href="#api">API (Version 2.0)</a></li>
  <li><a href="#template">Templates</a>
    <ul>
      <li><a href="#v4">Version 4.0 (current)</a></li>
      <li><a href="#v3">Version 3.0 (depricated, still supported)</a></li>
      <li><a href="#v2">Version 2.0 (depricated, still supported)</a></li>
      <li><a href="#v1">Version 1.0 (depricated, still supported)</a></li>
    </ul>
  </li>
  <li><a href="#code">wet-boew/GCWeb code and Canada.ca design guidence</a></li>
</ul>
<h2 id="purpose">Purpose</h2>
<p>The global header is a container that displays components that make up the header.</p>
<p>Available components include:</p>
<ul>
  <li>Government of Canada signature (always required)</li>
  <li>Language toggle (always required)</li>
  <li>Theme and topic menu</li>
  <li>Breadcrumb trail</li>
  <li>Site search box</li>
  <li>Sign in button</li>
</ul>
<h2 id="implement">How to implement</h2>
<h3>Page types</h3>
<p>Components are used and configured for different page types.   Consult the Canada.ca Design system guidance for using these components on <strong>Standard</strong>, <strong>Transactional</strong>, and <strong>Campaign</strong> pages.</p>
<ul class="fa-ul">
  <li><span class="fa-li"><span class="fab fa-canadian-maple-leaf"></span></span><a href="https://design.canada.ca/common-design-patterns/global-header.html#when">When to use the global header</a></li>
</ul>
<h3>Some working examples</h3>
<p>Here are some popular working examples.  It is not an exhaustive list of possible iterations.  Configure your page based on user needs and design system guidance.</p>
<ul>
  <li><a href="https://wet-boew.github.io/GCWeb/templates/content-en.html">Standard page including Header v4.0</a></li>
  <li><a href="https://wet-boew.github.io/GCWeb/sites/authentication/contextual-signin-en.html">Standard page including Header v4.0 and "Sign in" section</a></li>
  <li><a href="https://test.canada.ca/experimental/examples/layout-transactional-01-en.html">Transactional page including Header v4.0</a></li>
</ul>
<h3>Implementation notes</h3>
<p>Previous versions to Version 4.0 require <a href="https://wet-boew.github.io/GCWeb/sites/gcweb-menu/gcweb-menu-docs-en.html">gcweb-menu version 2.0</a> for some functionality (see the template section for more details).  The <code><span class="nowrap">&lt;div class="container"&gt;</span></code> element has been relocated to the global header.  It is no longer part of the "gcweb-menu" component.</p>
<h2 id="evaluation">Evaluation and report</h2>
<p>There is no evaluation and report available for this component.</p>
<h2 id="api">API (Version 2.0)</h2>
<table class="table table-bordered small">
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
  <summary>Deprecated version</summary>
  <div class="mrgn-tp-lg">
    <table class="table table-bordered small">
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
  </div>
</details>
<h3 id="v4">Version 4.0</h3>
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
  </div>
</div>
<h4>Code to include authentication section (optional)</h4>
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
			<strong class="h3">&lt;div class=&quot;col-xs-<ins>6</ins> col-xs-offset-<ins>6</ins> col-md-offset-0 col-md-4&quot;&gt;
				&lt;!-- Optional Authentication Section [version 1.0] --&gt;
			&lt;/div&gt;</strong>
		&lt;/div&gt;
	&lt;/div&gt;
	&lt;!-- Breadcrumbs [version 1.0] --&gt;
&lt;/header&gt;</code></pre>
  </div>
</div>
<h3>Updating previous template versions</h3>
<p>All versions prior to Version 4 are deprecated.  We reccommend upgrading to Version 4.0.  These versions are still supported.</p>
<h3 id="v3">Version 3.0 (depricated, still supported)</h3>
<p>No change is required when upgrading from Version 3 unless you are using the authentication section.</p>
<h4>Authentication section code (optional)</h4>
<ol>
  <li>implement <a href="https://wet-boew.github.io/GCWeb/sites/gcweb-menu/gcweb-menu-docs-en.html">gcweb-menu version 2.0</a>.  The <code><span class="nowrap">&lt;div class="container"&gt;</span></code> is relocated in the header and no longer part of the "gcweb-menu" component.</li>
  <li>modify the authentication div to <code><span class="nowrap">col-xs-6</span></code> and <code><span class="nowrap">col-xs-offset-6</span></code>.  This ensures that text for the Theme and topic menu button stays on one line on every screen (xxs, xxs, sm, md, lg and xl).</li>
</ol>
<!---<div class="row">
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
			&lt;div class=&quot;<strong class="h3">col-xs-<del>5</del> col-xs-offset-<del>7</del></strong> col-md-offset-0 col-md-4&quot;&gt;
				&lt;!-- Optional Authentication Section [version 1.0] --&gt;
			&lt;/div&gt;
		&lt;/div&gt;
	&lt;/div&gt;
	&lt;!-- Breadcrumbs [version 1.0] --&gt;
&lt;/header&gt;</code></pre>
  </div>
</div>-->
<h4>Header working examples</h4>
<details>
  <summary>Pages</summary>
  <ul>
    <li><a href="https://wet-boew.github.io/GCWeb/sites/header/deprecated/header-v3.html">Content page including Header Version 3.0</a></li>
    <li><a href="https://wet-boew.github.io/GCWeb/sites/header/deprecated/header-auth-v3.html">Content page including Header Version 3.0 and the authentication section</a></li>
    <li><a href="https://wet-boew.github.io/GCWeb/templates/home/deprecated/home-v3.html">Home page including Header Version 3.0</a></li>
    <li><a href="https://wet-boew.github.io/GCWeb/templates/home/deprecated/home-auth-v3.html">Home page including Header Version 3.0 and the authentication section</a></li>
  </ul>
</details>
<h3 id="v2">Version 2.0 (depricated, still supported)</h3>
<h3 id="v1">Version 1.0 (depricated, still supported)</h3>
<h2 id="code">wet-boew/GCWeb code and Canada.ca design guidence</h2>
<h3>Non-configurable elements (mandatory on all pages)</h3>
<ul>
  <li>
    <h4>Branding</h4>
    <ul class="fa-ul">
      <li><span class="fa-li"><span class="fas fa-code-branch"></span></span><a href="https://github.com/wet-boew/GCWeb/tree/master/sites/banner">brand</a></li>
      <li><span class="fa-li"><span class="fab fa-canadian-maple-leaf"></span></span><a href="https://design.canada.ca/common-design-patterns/signature.html">Government of Canada signature</a></li>
    </ul>
  </li>
  <li>
    <h4>Language toggle</h4>
    <ul class="fa-ul">
      <li><span class="fa-li"><span class="fas fa-code-branch"></span></span><a href="https://github.com/wet-boew/GCWeb/tree/master/sites/language">language toggle</a></li>
      <li><span class="fa-li"><span class="fab fa-canadian-maple-leaf"></span></span><a href="https://design.canada.ca/common-design-patterns/language-toggle.html">Language toggle link</a></li>
    </ul>
  </li>
</ul>
<h3>Configurable elements (depends on type of page):</h3>
<ul>
  <li>
    <h4>Site search box</h4>
    <ul class="fa-ul">
      <li><span class="fa-li"><span class="fas fa-code-branch"></span></span><a href="https://github.com/wet-boew/GCWeb/tree/master/sites/search">search</a></li>
      <li><span class="fa-li"><span class="fab fa-canadian-maple-leaf"></span></span><a href="https://design.canada.ca/common-design-patterns/search-box.html">Site search box</a></li>
    </ul>
  </li>
  <li>
    <h4>Theme and topic menu</h4>
    <ul class="fa-ul">
      <li><span class="fa-li"><span class="fas fa-code-branch"></span></span><a href="https://github.com/wet-boew/GCWeb/tree/master/sites/gcweb-menu">GCWeb menu</a></li>
      <li><span class="fa-li"><span class="fab fa-canadian-maple-leaf"></span></span><a href="https://design.canada.ca/common-design-patterns/search-box.html">Theme and topic menu</a></li>
    </ul>
  </li>
  <li>
    <h4>Breadcrumb trail</h4>
    <ul class="fa-ul">
      <li><span class="fa-li"><span class="fas fa-code-branch"></span></span><a href="https://github.com/wet-boew/GCWeb/tree/master/sites/breadcrumbs">breadcrumbs</a></li>
      <li><span class="fa-li"><span class="fab fa-canadian-maple-leaf"></span></span><a href="https://design.canada.ca/common-design-patterns/breadcrumb-trail.html">Breadcrumb trail</a></li>
    </ul>
  </li>
  <li>
    <h4>Sign-in button</h4>
    <ul class="fa-ul">
      <li><span class="fa-li"><span class="fas fa-code-branch"></span></span><a href="https://github.com/wet-boew/GCWeb/tree/master/sites/authentication">authentication</a></li>
      <li><span class="fa-li"><span class="fab fa-canadian-maple-leaf"></span></span><a href="https://design.canada.ca/common-design-patterns/contextual-signin.html">Contextual Sign in button</a></li>
    </ul>
  </li>
</ul>

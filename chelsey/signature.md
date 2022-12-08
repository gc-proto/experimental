---
css:
- https://design.canada.ca/css/split-h1.css
- https://design.canada.ca/css/custom.css
- https://use.fontawesome.com/releases/v5.15.4/css/all.css
layout: without-h1
pageclass: cnt-wdth-lmtd
lang: en
title: Government of Canada signature
share: True
breadcrumbs:
- title: Canada.ca design system
  link: https://design.canada.ca/common-design-patterns
description: The GoC signature in the new content pattern
en: GoC signature 
dateModified: 2022-12-06
--- 
<h1 property="name" id="wb-cont" dir="ltr"><span class="stacked"><span>Government of Canada signature</span>: <span>Canada.ca design system</span></span></h1>
<p><span class="label label-danger">Mandatory</span></p>
The Government of Canada signature is prominently featured in the global header on all public-facing websites.
The purpose of the Government of Canada signature is to provide an easily identifiable corporate identity. This signature also serves as a universal link back to the site’s home page in each language. 
<h2>On this page</h2>
<ul>
  <li><a href="#when-use">When to use</a></li>
  <li><a href="#what-avoid">What to avoid</a></li>
  <li><a href="#content-design">Content and design</a></li>
  <li><a href="#implement">How to implement</a></li>
  <li><a href="#research">Research and rationale</a></li>
  <li><a href="#changes">Latest changes</a></li>
</ul>
<h2 id="when-use">When to use</h2>
The Government of Canada signature is mandatory on all pages. 
<h2 id="what-avoid">What to avoid</h2>
If you have the global header applied to the page, you do not need to apply this pattern. The global header incorporates the Government of Canada signature requirements. 
<h2 id="content-design">Content and design</h2>
Find content and design specifications and visual examples.
<h3>Content specifications</h3>
<ul>
  <li>The Government of Canada signature appears in the upper-left corner of the page</li>
<li>The image is presented as an image file and must be formatted according to Federal Identity Program design specifications</li>
<li>The image is provided as a Scalable Vector Graphics (SVG) file, configured to scale automatically according to screen size</li>
  <li>The image is hyperlinked to the Canada.ca home page in the appropriate official language</li>
<li>The signature must appear as English first on English pages and French first on French pages</li>
</ul>  
<h4>Content interactions</h4>
<ul>
  <li>When clicked, the signature brings the user to the homepage of Canada.ca</li>
 </ul>
 <h3>Design specifications</h3>
Design specifications for this signature are:
<ul>
  <li>Flag symbol colour: FIP red (#eb4837)</li>
  <li>Text colour: black (#000000)</li>
 </ul>
 <h3>Visual examples</h3>
 <p><img class="img-border" src="https://canada.ca/etc/designs/canada/wet-boew/assets/sig-blk-en.svg" alt="Government of Canada signature"></p>
<p><img class="img-border" src="https://design.canada.ca/images/sig-en.png" alt="Government of Canada signature at the top left of the Canada.ca standard page design">
 <details>
      <summary class="wb-toggle" data-toggle="{&quot;print&quot;:&quot;on&quot;}">Text version</summary>
      <p>The Government of Canada signature in the top left. It is composed of the flag symbol in red, followed by the words Government of Canada in English and Gouvernment du Canada in French, both in black text.</p>
    </details>
<h2 id="implement">How to implement</h2>
<p>Use the code below in the header section of your page.</p>
<!--<span class="wb-prettify"></span>-->
  <code><pre>
&lt;div id=&quot;header&quot;&gt;
   &lt;a href=&quot;https://www.canada.ca/en.html&quot; title=&quot;Canada.ca hompepage&quot;&gt;
   &lt;img src=&quot;https://www.canada.ca/etc/designs/canada/wet-boew/assets/sig-blk-en.svg&quot; alt=&quot;Government of Canada&quot;&gt;&lt;/a&gt;
&lt;/div&gt;
</pre></code>
<h2 id="research">Research and rationale</h2>
<h3>Research findings</h3>
<p><a href="https://blog.canada.ca/2020/08/10/canadadotca-trusted-source"> Canada.ca is a trusted source:</a> The Canada.ca design allows users to easily identify Government of Canada web pages. This means users can immediately see that what they are looking at comes from a trusted source.</p>
<h3>Policy rationale</h3>
<ul>
  <li><a href='https://www.canada.ca/en/treasury-board-secretariat/services/government-communications/design-standard/colour-design-standard-fip.html'>Design Standard for the Federal Identity Program</a></li>
  <li><a href='https://www.canada.ca/en/treasury-board-secretariat/services/government-communications/canada-content-information-architecture-specification/mandatory-elements.html#header-footer'>Mandatory elements of the design system</a></li>
</ul>         
<h2 id="changes">Latest changes</h2>
<dl class="dl-horizontal">
  <dt>
    <time datetime="2022-12-06" class="link-muted">2022-12-06</time>
  </dt>
  <dd>Updated content to fit within the new design template.</dd>
</dl>

<h2>Discussion</h2>
<ul>
  <li><a href='https://github.com/canada-ca/design-system-systeme-conception/issues'>Discuss the pattern in github issues</a></li>
  <li><a href="https://design-gc-conception.slack.com/join/shared_invite/enQtODE1OTc5Mzg5NzQ4LWQ3MjZjMTdjMjk2ZTZmMTJjYWQ3ZmRiNDYwYjRmN2NjYzQyNjFlNDBlY2FkNWE1ODg2YjExY2QwZmVjN2MwMGM">Join the conversation on Slack</a></li>
  <li>Send an email to the Digital Transformation Office  <a href="mailto:dto.btn@tbs-sct.gc.ca">dto.btn@tbs-sct.gc.ca</a></li>
</ul>

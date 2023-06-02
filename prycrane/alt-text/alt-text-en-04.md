---
altLangPage: "#"
css:
- https://design.canada.ca/css/split-h1.css
- https://design.canada.ca/css/custom.css
- https://use.fontawesome.com/releases/v5.15.4/css/all.css
- https://test.canada.ca/experimental/prycrane/alt-text/css/pre.css
date: 2023-05-03
dateModified: 2023-06-02
description: "Alt text (bare-bones description)"
language: en
layout: without-h1
title: "Alt text (bare-bones description)"
---
<h1 property="name" id="wb-cont" dir="ltr"><span class="stacked"><span>Current Alt text (bare-bones description)</span>: <span>Alt text strategies</span></span></h1>
<div class="row">
  <div class="col-md-6">
    <div class="pattern-demo mrgn-tp-lg">
      <figure>
        <figcaption><b>Whiteshell provincial park</b></figcaption>
        <img src="./images/whiteshell-pp.png" class="img-responsive" alt=" " />
        <p class="mrgn-tp-md small">Promotional poster of Whiteshell provincial park</p>
        <details class="mrgn-tp-md">
          <summary class="wb-toggle small" data-toggle="{&quot;print&quot;:&quot;on&quot;}">Image description: Whiteshell provincial park</summary>
          <p class="mrgn-tp-lg">The poster shows a scenic painting of a teed rock face jutting into a lake.</p>
          <p>Text at the top:</p>
          <ul>
            <li>RUGGED PRECAMBRIAN SHIELD</li>
            <li>EST 1961</li>
            <li>PINK GRANITE RIDGES, LUSH PINE FORESTS</li>
            <li>ANCIENT PETROFORMS, RUSHING RIVERS</li>
          </ul>
          <p>Larger title text on 2 lines near the bottom:</p>
          <ul>
            <li>WHITESHELL</li>
            <li>PROVINCIAL PARK</li>
          </ul>
          <p>Slightly smaller sub-title text:</p>
          <ul>
            <li>MANITOBA PARKS</li>
          </ul>
          <p>Very small text at the edge of the bottom (left, middle, and right):</p>
          <ul>
            <li>illegible text</li>
            <li>illegible text</li>
            <li>Canada’s PARKS</li>
          </ul>
        </details>
      </figure>
    </div>
  </div>
</div>
<div class="row">
  <div class="col-md-8">
    <h2 class="h3">HTML</h2>
    <pre><code>
&nbsp;&nbsp;&nbsp;&nbsp;&lt;div&nbsp;class=&quot;pattern&#45;demo&nbsp;mrgn&#45;tp&#45;lg&quot;&gt;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;figure&gt;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;figcaption&gt;&lt;b&gt;Whiteshell&nbsp;provincial&nbsp;park&lt;/b&gt;&lt;/figcaption&gt;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;img&nbsp;src=&quot;./images/whiteshell&#45;pp.png&quot;&nbsp;class=&quot;img&#45;responsive&quot;&nbsp;alt=&quot;&nbsp;&quot;&nbsp;/&gt;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;p&nbsp;class=&quot;mrgn&#45;tp&#45;md&nbsp;small&quot;&gt;Promotional&nbsp;poster&nbsp;of&nbsp;Whiteshell&nbsp;provincial&nbsp;park&lt;/p&gt;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;details&nbsp;class=&quot;mrgn&#45;tp&#45;md&quot;&gt;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;summary&nbsp;class=&quot;wb&#45;toggle&nbsp;small&quot;&nbsp;data&#45;toggle=&quot;{&amp;quot;print&amp;quot;:&amp;quot;on&amp;quot;}&quot;&gt;Image&nbsp;description:&nbsp;Whiteshell&nbsp;provincial&nbsp;park&lt;/summary&gt;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;p&nbsp;class=&quot;mrgn&#45;tp&#45;lg&quot;&gt;The&nbsp;poster&nbsp;shows&nbsp;a&nbsp;scenic&nbsp;painting&nbsp;of&nbsp;a&nbsp;teed&nbsp;rock&nbsp;face&nbsp;jutting&nbsp;into&nbsp;a&nbsp;lake.&lt;/p&gt;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;p&gt;Text&nbsp;at&nbsp;the&nbsp;top:&lt;/p&gt;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;ul&gt;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;li&gt;RUGGED&nbsp;PRECAMBRIAN&nbsp;SHIELD&lt;/li&gt;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;li&gt;EST&nbsp;1961&lt;/li&gt;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;li&gt;PINK&nbsp;GRANITE&nbsp;RIDGES,&nbsp;LUSH&nbsp;PINE&nbsp;FORESTS&lt;/li&gt;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;li&gt;ANCIENT&nbsp;PETROFORMS,&nbsp;RUSHING&nbsp;RIVERS&lt;/li&gt;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;/ul&gt;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;p&gt;Larger&nbsp;title&nbsp;text&nbsp;on&nbsp;2&nbsp;lines&nbsp;near&nbsp;the&nbsp;bottom:&lt;/p&gt;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;ul&gt;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;li&gt;WHITESHELL&lt;/li&gt;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;li&gt;PROVINCIAL&nbsp;PARK&lt;/li&gt;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;/ul&gt;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;p&gt;Slightly&nbsp;smaller&nbsp;sub&#45;title&nbsp;text:&lt;/p&gt;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;ul&gt;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;li&gt;MANITOBA&nbsp;PARKS&lt;/li&gt;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;/ul&gt;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;p&gt;Very&nbsp;small&nbsp;text&nbsp;at&nbsp;the&nbsp;edge&nbsp;of&nbsp;the&nbsp;bottom&nbsp;(left,&nbsp;middle,&nbsp;and&nbsp;right)::&lt;/p&gt;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;ul&gt;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;li&gt;illegible&nbsp;text&lt;/li&gt;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;li&gt;illegible&nbsp;text&lt;/li&gt;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;li&gt;Canada’s&nbsp;PARKS&lt;/li&gt;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;/ul&gt;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;/details&gt;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;/figure&gt;
&nbsp;&nbsp;&nbsp;&nbsp;&lt;/div&gt;
	
</code></pre>
  </div>
</div>

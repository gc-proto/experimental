---
css:
- https://design.canada.ca/css/split-h1.css
- https://design.canada.ca/css/custom.css
- https://use.fontawesome.com/releases/v5.15.4/css/all.css
layout: default
lang: en
title: Testing out GitHub
share: True
breadcrumbs:
- title: Trees on the web
  link: https://prycrane.github.io/experimental/prycrane/accessibility/
description: A place for me to try out code
en: Index of mockups for accessibility requirements. 
dateModified: 2022-11-15
---
# Chelsey’s test
<div class="row">
	<div class="col-xs-12">
		<div>
			<img class="img-responsive full-width" src="https://pcweb.azureedge.net/-/media/pn-np/on/rouge/WET4/activ/1920x480-tallgrass.jpg" alt="trees">
			<div class="well header-rwd pstn-tp-sm mrgn-tp-lg mrgn-bttm-md">
				<h4 class="mrgn-tp-md">All the trees you could ever code</h4>
				<p>A place to design a beautiful world</p>
			</div>
		</div>
	</div>
</div>
<style>
.scroll-left {
 height: 50px;	
 overflow: hidden;
 position: relative;
 background: green;
 color: white;
 border: 1px solid orange;
}
.scroll-left p {
 position: absolute;
 width: 100%;
 height: 100%;
 margin: 0;
 line-height: 50px;
 text-align: center;
 /* Starting position */
 transform:translateX(100%);
 /* Apply animation to this element */
 animation: scroll-left 15s linear infinite;
}
/* Move it (define the animation) */
@keyframes scroll-left {
 0%   {
 transform: translateX(100%); 		
 }
 100% {
 transform: translateX(-100%); 
 }
}
</style>

<div class="scroll-left">
<p>Don't you just love retro banners like this... not!</p>
</div>


## Beautiful

Yes that is very neat.

<marquee behavior="alternate" scrollamount="1">This...</marquee>
<marquee behavior="alternate" scrollamount="12">is...</marquee>
<marquee behavior="alternate" scrollamount="25">Even...</marquee>
<marquee behavior="alternate" scrollamount="55">BETTER!</marquee>


## This is so cool

Yes, yes it is.

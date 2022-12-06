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
- title: Accessibility
  link: https://prycrane.github.io/experimental/prycrane/accessibility/
description: 
en: Index of mockups for accessibility requirements. 
dateModified: 2022-11-15
---
<p>Hello world!</p>
# Chelsey’s test

<style>
.scroll-left {
 height: 50px;	
 overflow: hidden;
 position: relative;
 background: pink;
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

## This is so cool

Yes, yes it is.

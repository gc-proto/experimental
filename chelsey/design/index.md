---
altLangPage: "#"
breadcrumbs:
  - title: Breadcrumbs pattern
    link: "https://design.canada.ca/common-design-patterns/breadcrumb-trail.html"
css:
- https://design.canada.ca/css/split-h1.css
- https://design.canada.ca/css/custom.css
- https://use.fontawesome.com/releases/v5.15.4/css/all.css
date: 2023-02-23
dateModified: 2023-02-23
description: "Standard page with breadcrumbs"
lang: en
layout: without-h1
title: "Breadcrumb trail - Canada.ca design pattern"
---
<h1 property="name" id="wb-cont" dir="ltr"><span class="stacked"><span>Breadcrumb trail - Canada.ca design pattern</span>: <span>Canada.ca design</span></span></h1>
<p>This is a mockup of the future state of the Breadcrumb trail pattern.</p>
<h2>Iteration 1 - Feb. 23</h2>
<ul>
  <li><a href="breadcrumbs-01.html">Breadcrumb 01</a></li>
  </ul>


# GCWP - September 13, 2023

## Update on alternate language department names showing up on search engine results 

We've dug into this issue some more and the problem might be the splash pages.
When Google lists a page in search results, it shows the name of the site the page comes from. 

It takes into account content from the site's home page when determining the site name.
In each of the examples provided, the splash page has both the English and French title specified (because it's a bilingual page).
It seems the search engines are confused as to what the title of the site actually is.

- [Agriculture Canada](https://agriculture.canada.ca/)
- [DFO MPO](https://www.dfo-mpo.gc.ca/)
- [TC Canada](https://tc.canada.ca/)
- [TSB](https://tsb.gc.ca/)

Google provides steps on how to provide your site name preference [here](https://developers.google.com/search/docs/appearance/site-names).
If you follow the steps to specify a site name, you'll want to be mindful of the fact that the search engines are using your splash page to determine the site name for all your English and all your French pages, so you'll want to choose something that works in both languages.
Google states that it only allows one name per site and you can't specify a site name for a subdirectory (i.e., www.sitename/en). So you might want to consider using something like your URL as the site name (for example, pages on the Managed Web Service (MWS) simply list canada.ca as the site name).
Of course, how search engines index content is always a bit of a mystery, so this may not solve the problem, but it is certainly worth exploring.

## Roundtable

### Subway navigation

**Presentation:** Subway pattern - Chad Farquharson – Canada Revenue Agency

Subway navigation predates COVID. We worked with the Digital Transformation Office to develop the Subway Navigation. 
We wanted to take the Service Initiation Page and make it more flexible and also better on mobile. 
We are working to harmonize labels across departments. This is so that the user experience is similar no matter which department they are visiting. 

**Some key points:**
- No need to use pagination
- The design is research-based
- Designers are using it in different ways

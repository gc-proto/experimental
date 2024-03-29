---
altLangPage: "/resumes-recherche/design-conversationnel"
breadcrumbs:
  - title: "About Canada.ca"
    link:  "https://www.canada.ca/en/government/about.html"
  - title: Canada.ca design system
    link: "https://www.canada.ca/en/government/about/design-system.html"
css:
- https://design.canada.ca/css/split-h1.css
- https://design.canada.ca/css/custom.css
- https://use.fontawesome.com/releases/v5.15.4/css/all.css
date: 2023-01-17
dateModified: 2023-01-17
description: "The Canada.ca design system provides a usable, consistent and trustworthy online experience for people who access Government of Canada digital services."
lang: en
layout: without-h1
share: true
pageclass: cnt-wdth-lmtd
title: "Template and pattern library for Canada.ca"
---
<h1 property="name" id="wb-cont" dir="ltr">Template and pattern library for Canada.ca</h1>

<h2>Templates and patterns</h2>
<div class="row mrgn-tp-md">
<div class="col-md-3 small">
   <details open="open">
      <summary class="bg-primary text-center">Filter options</summary>
      <p class="mrgn-tp-md">Use these filters to find templates and patterns.</p>
      <form class="wb-tables-filter mrgn-lft-md mrgn-rght-md" data-bind-to="design">
         <div class="row">
            <div class="form-group">
               <label for="dt_cat">Pattern, template or style</label>
               <select class="form-control maxwidth" id="dt_cat" name="dt_cat" data-column="4">
                  <option value="">All</option>
                  <option value="Design pattern">Design patterns</option>
                  <option value="Template">Template</option>
                  <option value="Style">Style</option>
               </select>
            </div>
            <div class="form-group">
               <label for="dt_type">Types</label>
               <select class="form-control maxwidth" id="dt_type" name="dt_type" data-column="5">
                  <option value="">All</option>
                  <option value="Destination">Destination</option>
                  <option value="Government-wide template">Government-wide</option>
                  <option value="Institutional">Institutional</option>
                  <option value="Interaction">Interaction</option>
                  <option value="Navigation">Navigation</option>
                  <option value="Promotion">Promotional</option>
                  <option value="Site">Site-wide</option>
                  <option value="Theme template">Theme and topic</option>
                  <option value="Visual">Visual</option>
               </select>
            </div>
            <div class="form-group">
               <label for="dt_mand">Mandatory or suggested</label>
               <select class="form-control maxwidth" id="dt_mand" name="dt_mand" data-column="6">
                  <option value="">All</option>
                  <option value="Mandatory">Mandatory</option>
                  <option value="No">Suggested</option>
               </select>
            </div>
            <div class="col-md-6">
               <button type="submit" class="btn btn-primary" aria-controls="dataset-filter">Filter</button>
            </div>
            <div class="col-md-6">
               <a href="datatables-05-en.html" class="btn btn-default">Clear</a>
            </div>
         </div>
      </form>
   </details>
</div>
<div class="col-md-9">
   <div class="panel panel-default">
      <div class="mrgn-tp-md mrgn-bttm-md">
         <table class="wb-tables table table-striped small" aria-live="polite" id="design" data-page-length="100" data-wb-tables='{
            "bDeferRender": true,
            "ajaxSource": "https://design.canada.ca/ajax/patterns-01-en.json",
            "order": [0, "asc"],
            "paging": false,
            "info": false,
            "columns": [
            { "data": "NAME", "className": "" },
            { "data": "SOURCE",  "visible": false },
            { "data": "DESCRIPTION",  "visible": false },
            { "data": "WHENTOUSE", "className": "", "orderable": false },
            { "data": "CATEGORY", "className": "" },
            { "data": "TYPE", "className": "" },
            { "data": "MANDATORY",  "visible": false },
            { "data": "TANDP",  "visible": false, "Search": "1" }
            ], 
            "searchCols": [
            null,
            null,
            null,
            null,
            null,
            null, 
            null,
            { "sSearch": &quot;1&quot; }]
            }'>
            <thead>
               <tr>
                  <th class="col-md-03">Name</th>
                  <th>Source</th>
                  <th>Description</th>
                  <th class="col-md-05">When to use this pattern</th>
                  <th class="col-md-02">Category</th>
                  <th class="col-md-02">Type</th>
                  <th>Mandatory</th>
                  <th>Tempalates and patterns</th>
               </tr>
            </thead>
         </table>
      </div>
   </div>
</div>

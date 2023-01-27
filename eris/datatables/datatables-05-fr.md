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
date: 2023-01-24
dateModified: 2023-01-24
description: "Bibliothèque de modèles et de configurations de conception"
lang: fr
layout: without-h1
share: true
pageclass: cnt-wdth-lmtd
title: "Bibliothèque de modèles et de configurations de conception"
---
<h1 property="name" id="wb-cont" dir="ltr">Bibliothèque de modèles et de configurations de conception</h1>

<h2>Templates and patterns</h2>
<div class="row mrgn-tp-md">
<div class="col-md-3 small">
   <details open="open">
      <summary class="bg-primary text-center">Options de filtrage</summary>
      <form class="wb-tables-filter mrgn-lft-md mrgn-rght-md" data-bind-to="design">
         <div class="row mrgn-tp-lg mrgn-bttm-lg">
            <div class="form-group">
               <label for="dt_cat">Configurations, modèles ou styles</label>
               <select class="form-control maxwidth" id="dt_cat" name="dt_cat" data-column="4">
                <option value="">Tout afficher</option>
                <option value="Configuration de conception">Configurations de conception</option>
                <option value="Modèle de page">Modèles de page</option>
				        <option value="Style">Styles</option>
               </select>
            </div>
            <div class="form-group">
               <label for="dt_type">Types</label>
               <select class="form-control maxwidth" id="dt_type" name="dt_type" data-column="5">
                  <option value="">Tout afficher</option>
                  <option value="Destination">Destination</option>
                  <option value="Modèle à l'échelle du gouvernement">À l'échelle du gouvernement</option>
                  <option value="Institutionnel">Institution</option>
                  <option value="Configuration à l'échelle du site">À l'échelle du site</option>
                  <option value="Interaction">Interaction</option>
                  <option value="Navigation">Navigation</option>
                  <option value="Promotion">Promotion</option>
                  <option value="Modèle de thème">Thème et sujet</option>
                  <option value="Visuel">Visuel</option>
               </select>
            </div>
            <div class="form-group">
               <label for="dt_mand">Obligatoire ou suggéré</label>
               <select class="form-control maxwidth" id="dt_mand" name="dt_mand" data-column="6">
                <option value="">Tout afficher</option>
                <option value="Obligatoire">Obligatoire</option>
                <option value="Non">Suggéré</option>
               </select>
            </div>
            <div class="col-md-12 mrgn-tp-lg">
               <button type="submit" class="btn btn-primary full-width" aria-controls="dataset-filter">Filtrer</button>
            </div>
            <div class="col-md-12 mrgn-tp-md">
                <a href="datatables-05-en.html" class="btn btn-default full-width">Réinitialiser aux valeurs par défaut</a>
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
            "ajaxSource": "https://design.canada.ca/ajax/patterns-01-fr.json",
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
                  <th class="col-md-03">Nom</th>
                  <th>Source</th>
                  <th>Description</th>
                  <th class="col-md-05">Quand utiliser ce modèle</th>
                  <th class="col-md-02">Catégorie</th>
                  <th class="col-md-02">Type</th>
                  <th>Obligatoire</th>
                  <th>Modèles et configurations</th>
               </tr>
            </thead>
         </table>
      </div>
   </div>
</div>

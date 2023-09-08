---
altLangPage: false
breadcrumbs: false
css:
- https://design.canada.ca/css/split-h1.css
- https://design.canada.ca/css/custom.css
- https://use.fontawesome.com/releases/v5.15.4/css/all.css
date: 2023-09-06
dateModified: 2023-09-06
description: "Style guide repository"
lang: en
layout: form
share: false
nositesearch: true
showFeedback: false
nomenu: true
noReportProblem: true
pageclass: cnt-wdth-lmtd
title: "Style guide repository"
---
<h1 property="name" id="wb-cont" dir="ltr"><span class="stacked"><span>Github Repository</span>: <span>Canada.ca Content Style Guide</span></span></h1>
<p>The Style Guide section snippets.</p>
<div class="panel panel-default mrgn-tp-lg">
  <div class="mrgn-tp-md">
    <ul class="list-unstyled list-inline">
      <li>
        <form class="wb-tables-filter mrgn-lft-md mrgn-rght-md" data-bind-to="styleguide">
          <input type="hidden" id="dt_eng" name="dt_eng" value="en"  data-column="1">
          <button type="submit" class="btn btn-primary"  aria-controls="dataset-filter"><span class="fas fa-filter mrgn-rght-sm"></span> English</button>
        </form>
      </li>
      <li>
        <form class="wb-tables-filter mrgn-lft-md mrgn-rght-md" data-bind-to="styleguide">
          <input type="hidden" id="dt_fra" name="dt_fra" value="fr"  data-column="1">
          <button type="submit" class="btn btn-primary"  aria-controls="dataset-filter"><span class="fas fa-filter mrgn-rght-sm"></span> Français</button>
        </form>
      </li>
      <li> <a href="sg-breakdown.html" class="btn btn-default">Reset</a> </li>
    </ul>
    <table class="wb-tables table table-striped small brdr-tp" aria-live="polite" id="styleguide" data-page-length="100" data-wb-tables='{  
	    "bDeferRender": true,														 
            "order": [[0, "asc"],[1, "asc"]],
            "paging": true,
            "info": true,
            "columns": [
            { "data": "SORT", "className": "",  "visible": false },
            { "data": "LANGUAGE", "className": "",  "visible": false },																									
            { "data": "SECTIONNAME", "className": "" },
	        { "data": "ID", "className": "" },
            { "data": "RREPOSITORY", "className": "", "orderable": false }
            ]
            }'>
      <thead>
        <tr>
          <th>Sort</th>
          <th>Language</th>
          <th class="col-md-6">Section name</th>
          <th class="col-md-3">ID</th>
          <th class="col-md-4"><span class="fab fa-github"></span> Repository</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>0.1</td>
          <td>en</td>
          <td>Table of contents</td>
          <td>toc</td>
          <td><a href="https://github.com/canada-ca/design-system/blob/CCCSG-158-recode-style-guide/_includes/style-guide/01-intro.html">01-intro.html</a></td>
        </tr>
        <tr>
          <td>0.1</td>
          <td>fr</td>
          <td>Table des matières</td>
          <td>toc</td>
          <td></td>
        </tr>
        <tr>
          <td>0.2</td>
          <td>en</td>
          <td>Summary of changes</td>
          <td>toc1</td>
          <td><a href="https://github.com/canada-ca/design-system/blob/CCCSG-158-recode-style-guide/_includes/style-guide/02-toc1.html">02-toc1.html</a></td>
        </tr>
        <tr>
          <td>0.2</td>
          <td>fr</td>
          <td>Sommaire des changements</td>
          <td>toc1</td>
          <td></td>
        </tr>
        <tr>
          <td>0.3</td>
          <td>en</td>
          <td>Purpose</td>
          <td>toc2</td>
          <td><a href="https://github.com/canada-ca/design-system/blob/CCCSG-158-recode-style-guide/_includes/style-guide/03-toc2.html">03-toc2.html</a></td>
        </tr>
        <tr>
          <td>0.3</td>
          <td>fr</td>
          <td>But du document</td>
          <td>toc2</td>
          <td></td>
        </tr>
        <tr>
          <td>0.4</td>
          <td>en</td>
          <td>Use of the style guide</td>
          <td>toc3</td>
          <td><a href="https://github.com/canada-ca/design-system/blob/CCCSG-158-recode-style-guide/_includes/style-guide/04-toc3.html">04-toc3.html</a></td>
        </tr>
        <tr>
          <td>0.4</td>
          <td>fr</td>
          <td>Application</td>
          <td>toc3</td>
          <td></td>
        </tr>
        <tr>
          <td>0.5</td>
          <td>en</td>
          <td>Related policies, standards and procedures</td>
          <td>toc4</td>
          <td><a href="https://github.com/canada-ca/design-system/blob/CCCSG-158-recode-style-guide/_includes/style-guide/06-toc5.html">05-toc4.html</a></td>
        </tr>
        <tr>
          <td>0.5</td>
          <td>fr</td>
          <td>Politiques, normes et procédures connexes</td>
          <td>toc4</td>
          <td></td>
        </tr>
        <tr>
          <td>1.0</td>
          <td>en</td>
          <td>1.0 Writing principles for web content</td>
          <td>toc5</td>
          <td><a href="https://github.com/canada-ca/design-system/blob/CCCSG-158-recode-style-guide/_includes/style-guide/06-toc5.html">06-toc5.htm5</a></td>
        </tr>
        <tr>
          <td>1.0</td>
          <td>fr</td>
          <td>1.0 Principes de rédaction pour le contenu Web</td>
          <td>toc5</td>
          <td></td>
        </tr>
        <tr>
          <td>2.0</td>
          <td>en</td>
          <td>2.0 Plain language</td>
          <td>toc6</td>
          <td><a href="https://github.com/canada-ca/design-system/blob/CCCSG-158-recode-style-guide/_includes/style-guide/07-toc6.html">07-toc6.html</a></td>
        </tr>
        <tr>
          <td>2.0</td>
          <td>fr</td>
          <td>2.0 Langage clair et simple</td>
          <td>toc6</td>
          <td></td>
        </tr>
        <tr>
          <td>3.0</td>
          <td>en</td>
          <td>3.0 Tone</td>
          <td>toc7</td>
          <td><a href="https://github.com/canada-ca/design-system/blob/CCCSG-158-recode-style-guide/_includes/style-guide/08-toc7.html">08-toc7.html</a></td>
        </tr>
        <tr>
          <td>3.0</td>
          <td>fr</td>
          <td>3.0 Ton</td>
          <td>toc7</td>
          <td></td>
        </tr>
        <tr>
          <td>4.0</td>
          <td>en</td>
          <td>4.0 Style</td>
          <td>toc8</td>
          <td><a href="https://github.com/canada-ca/design-system/blob/CCCSG-158-recode-style-guide/_includes/style-guide/09-toc8.html">09-toc8.html</a></td>
        </tr>
        <tr>
          <td>4.0</td>
          <td>fr</td>
          <td>4.0 Style de présentation</td>
          <td>toc8</td>
          <td></td>
        </tr>
        <tr>
          <td>4.1</td>
          <td>en</td>
          <td>4.1 Capitalization and punctuation</td>
          <td>toc8</td>
          <td><a href="https://github.com/canada-ca/design-system/blob/CCCSG-158-recode-style-guide/_includes/style-guide/09-toc8-wp4-1.html">09-toc8-wp4-1.html</a></td>
        </tr>
        <tr>
          <td>4.1</td>
          <td>fr</td>
          <td>4.1 Majuscules et ponctuation</td>
          <td>toc8</td>
          <td></td>
        </tr>
        <tr>
          <td>4.1.1</td>
          <td>en</td>
          <td>4.1.1 Titles, headings and subheadings</td>
          <td>wp4-1-1</td>
          <td><a href="https://github.com/canada-ca/design-system/blob/CCCSG-158-recode-style-guide/_includes/style-guide/09-toc8-wp4-1-1.html">09-toc8-wp4-1-1.html</a></td>
        </tr>
        <tr>
          <td>4.1.1</td>
          <td>fr</td>
          <td>4.1.1 Titres et sous-titres</td>
          <td>wp4-1-1</td>
          <td></td>
        </tr>
        <tr>
          <td>4.1.2</td>
          <td>en</td>
          <td>4.1.2 Lists</td>
          <td>wp4-1-2</td>
          <td><a href="https://github.com/canada-ca/design-system/blob/CCCSG-158-recode-style-guide/_includes/style-guide/09-toc8-wp4-1-2.html">09-toc8-wp4-1-2.html</a></td>
        </tr>
        <tr>
          <td>4.1.2</td>
          <td>fr</td>
          <td>4.1.2 Listes d'éléments</td>
          <td>wp4-1-2</td>
          <td></td>
        </tr>
        <tr>
          <td>4.1.3</td>
          <td>en</td>
          <td>4.1.3 Links</td>
          <td>wp4-1-3</td>
          <td><a href="https://github.com/canada-ca/design-system/blob/CCCSG-158-recode-style-guide/_includes/style-guide/09-toc8-wp4-1-3.html">09-toc8-wp4-1-3.html</a></td>
        </tr>
        <tr>
          <td>4.1.3</td>
          <td>fr</td>
          <td>4.1.3 Links</td>
          <td>wp4-1-3</td>
          <td></td>
        </tr>
        <tr>
          <td>4.1.4</td>
          <td>en</td>
          <td>4.1.4 Commas</td>
          <td>wp4-1-4</td>
          <td><a href="https://github.com/canada-ca/design-system/blob/CCCSG-158-recode-style-guide/_includes/style-guide/09-toc8-wp4-1-4.html">09-toc8-wp4-1-4.html</a></td>
        </tr>
        <tr>
          <td>4.1.4</td>
          <td>fr</td>
          <td>4.1.4 Commas</td>
          <td>wp4-1-4</td>
          <td></td>
        </tr>
        <tr>
          <td>4.1.5</td>
          <td>en</td>
          <td>4.1.5 Hyphen and dashes</td>
          <td>wp4-1-5</td>
          <td><a href="https://github.com/canada-ca/design-system/blob/CCCSG-158-recode-style-guide/_includes/style-guide/09-toc8-wp4-1-5.html">09-toc8-wp4-1-5.html</a></td>
        </tr>
        <tr>
          <td>4.1.5</td>
          <td>fr</td>
          <td>4.1.5 Hyphen and dashes</td>
          <td>wp4-1-5</td>
          <td></td>
        </tr>
        <tr>
          <td>4.2</td>
          <td>en</td>
          <td>4.2 Underlining, bold and italics</td>
          <td>wp4-2</td>
          <td><a href="https://github.com/canada-ca/design-system/blob/CCCSG-158-recode-style-guide/_includes/style-guide/09-toc8-wp4-2.html">09-toc8-wp4-2.html</a></td>
        </tr>
        <tr>
          <td>4.2</td>
          <td>fr</td>
          <td>4.2 Soulignement, caractères gras et italique</td>
          <td>wp4-2</td>
          <td></td>
        </tr>
        <tr>
          <td>4.3</td>
          <td>en</td>
          <td>4.3 Symbols</td>
          <td>wp4-3</td>
          <td><a href="https://github.com/canada-ca/design-system/blob/CCCSG-158-recode-style-guide/_includes/style-guide/09-toc8-wp4-3.html">09-toc8-wp4-3.html</a></td>
        </tr>
        <tr>
          <td>4.3</td>
          <td>fr</td>
          <td>4.3 Symboles</td>
          <td>wp4-3</td>
          <td></td>
        </tr>
        <tr>
          <td>4.4</td>
          <td>en</td>
          <td>4.4 Abbreviations and acronyms</td>
          <td>wp4-4</td>
          <td><a href="https://github.com/canada-ca/design-system/blob/CCCSG-158-recode-style-guide/_includes/style-guide/09-toc8-wp4-4.html">09-toc8-wp4-4.html</a></td>
        </tr>
        <tr>
          <td>4.4</td>
          <td>fr</td>
          <td>4.4 Abréviations, acronymes et référence</td>
          <td>wp4-4</td>
          <td></td>
        </tr>
        <tr>
          <td>4.4.1</td>
          <td>en</td>
          <td>4.4.1 Latin abbreviations</td>
          <td>wp4-4-1</td>
          <td><a href="https://github.com/canada-ca/design-system/blob/CCCSG-158-recode-style-guide/_includes/style-guide/09-toc8-wp4-10.html">09-toc8-wp4-10.html</a></td>
        </tr>
        <tr>
          <td>4.4.1</td>
          <td>fr</td>
          <td>4.4.1 Latin abbreviations</td>
          <td>wp4-4-1</td>
          <td></td>
        </tr>
        <tr>
          <td>4.5</td>
          <td>en</td>
          <td>4.5 Contractions</td>
          <td>wp4-5</td>
          <td><a href="https://github.com/canada-ca/design-system/blob/CCCSG-158-recode-style-guide/_includes/style-guide/09-toc8-wp4-5.html">09-toc8-wp4-5.html</a></td>
        </tr>
        <tr>
          <td>4.5</td>
          <td>fr</td>
          <td>4.5 Forme contractée</td>
          <td>wp4-5</td>
          <td></td>
        </tr>
        <tr>
          <td>4.6</td>
          <td>en</td>
          <td>4.6 Numbers</td>
          <td>wp4-6</td>
          <td><a href="https://github.com/canada-ca/design-system/blob/CCCSG-158-recode-style-guide/_includes/style-guide/09-toc8-wp4-6.html">09-toc8-wp4-6.html</a></td>
        </tr>
        <tr>
          <td>4.6</td>
          <td>fr</td>
          <td>4.6 Nombres</td>
          <td>wp4-6</td>
          <td></td>
        </tr>
        <tr>
          <td>4.7</td>
          <td>en</td>
          <td>4.7 Dates</td>
          <td>wp4-7</td>
          <td><a href="https://github.com/canada-ca/design-system/blob/CCCSG-158-recode-style-guide/_includes/style-guide/09-toc8-wp4-7.html">09-toc8-wp4-7.html</a></td>
        </tr>
        <tr>
          <td>4.7</td>
          <td>fr</td>
          <td>4.7 Dates</td>
          <td>wp4-7</td>
          <td></td>
        </tr>
        <tr>
          <td>4.8</td>
          <td>en</td>
          <td>4.8 Times</td>
          <td>wp4-8</td>
          <td><a href="https://github.com/canada-ca/design-system/blob/CCCSG-158-recode-style-guide/_includes/style-guide/09-toc8-wp4-8.html">09-toc8-wp4-8.html</a></td>
        </tr>
        <tr>
          <td>4.8</td>
          <td>fr</td>
          <td>4.8 Heures</td>
          <td>wp4-8</td>
          <td></td>
        </tr>
        <tr>
          <td>4.9</td>
          <td>en</td>
          <td>4.9 Phone numbers</td>
          <td>wp4-9</td>
          <td><a href="https://github.com/canada-ca/design-system/blob/CCCSG-158-recode-style-guide/_includes/style-guide/09-toc8-wp4-9.html">09-toc8-wp4-9.html</a></td>
        </tr>
        <tr>
          <td>4.9</td>
          <td>fr</td>
          <td>4.9 Numéros de téléphone</td>
          <td>wp4-9</td>
          <td></td>
        </tr>
        <tr>
          <td>4.10</td>
          <td>en</td>
          <td>4.10 Addresses</td>
          <td>wp4-10</td>
          <td><a href="https://github.com/canada-ca/design-system/blob/CCCSG-158-recode-style-guide/_includes/style-guide/09-toc8-wp4-10.html">09-toc8-wp4-10.html</a></td>
        </tr>
        <tr>
          <td>4.10</td>
          <td>fr</td>
          <td>4.10 Adresses</td>
          <td>wp4-10</td>
          <td></td>
        </tr>
        <tr>
          <td>4.10.1</td>
          <td>en</td>
          <td>4.10.1 Mailing addresses</td>
          <td>wp4-10-1</td>
          <td><a href="https://github.com/canada-ca/design-system/blob/CCCSG-158-recode-style-guide/_includes/style-guide/09-toc8-wp4-10-1.html">09-toc8-wp4-10-1.html</a></td>
        </tr>
        <tr>
          <td>4.10.1</td>
          <td>fr</td>
          <td>4.10.1 Adresses postales</td>
          <td>wp4-10-1</td>
          <td></td>
        </tr>
        <tr>
          <td>4.10.2</td>
          <td>en</td>
          <td>4.10.2 Email addresses</td>
          <td>wp4-10-2</td>
          <td><a href="https://github.com/canada-ca/design-system/blob/CCCSG-158-recode-style-guide/_includes/style-guide/09-toc8-wp4-10-2.html">09-toc8-wp4-10-2.html</a></td>
        </tr>
        <tr>
          <td>4.10.2</td>
          <td>fr</td>
          <td>4.10.2 Adresses de courriel</td>
          <td>wp4-10-2</td>
          <td></td>
        </tr>
        <tr>
          <td>4.11</td>
          <td>en</td>
          <td>4.11 Words and expressions in transition</td>
          <td>wp4-11</td>
          <td><a href="https://github.com/canada-ca/design-system/blob/CCCSG-158-recode-style-guide/_includes/style-guide/09-toc8-wp4-11.html">09-toc8-wp4-10.html</a></td>
        </tr>
        <tr>
          <td>4.11</td>
          <td>fr</td>
          <td>4.11 Words and expressions in transition</td>
          <td>wp4-11</td>
          <td></td>
        </tr>
        <tr>
          <td>5.0</td>
          <td>en</td>
          <td>5.0 Content structure</td>
          <td>toc9</td>
          <td><a href="https://github.com/canada-ca/design-system/blob/CCCSG-158-recode-style-guide/_includes/style-guide/10-toc9.html">10-toc9.html</a></td>
        </tr>
        <tr>
          <td>5.0</td>
          <td>fr</td>
          <td>5.0 Structure du contenu</td>
          <td>toc9</td>
          <td></td>
        </tr>
        <tr>
          <td>6.0</td>
          <td>en</td>
          <td>6.0 Images and videos</td>
          <td>toc10</td>
          <td><a href="https://github.com/canada-ca/design-system/blob/CCCSG-158-recode-style-guide/_includes/style-guide/11-toc10.html">11-toc10.html</a></td>
        </tr>
        <tr>
          <td>6.0</td>
          <td>fr</td>
          <td>6.0 Images et vidéos</td>
          <td>toc10</td>
          <td></td>
        </tr>
        <tr>
          <td>7.0</td>
          <td>en</td>
          <td>7.0 Links</td>
          <td>toc11</td>
          <td><a href="https://github.com/canada-ca/design-system/blob/CCCSG-158-recode-style-guide/_includes/style-guide/12-toc11.html">12-toc11.html</a></td>
        </tr>
        <tr>
          <td>7.0</td>
          <td>fr</td>
          <td>7.0 Liens</td>
          <td>toc11</td>
          <td></td>
        </tr>
        <tr>
          <td>8.0</td>
          <td>en</td>
          <td>8.0 Web content makeovers</td>
          <td>toc12</td>
          <td><a href="https://github.com/canada-ca/design-system/blob/CCCSG-158-recode-style-guide/_includes/style-guide/13-toc12.html">13-toc12.html</a></td>
        </tr>
        <tr>
          <td>8.0</td>
          <td>fr</td>
          <td>8.0 Refonte de contenu Web</td>
          <td>toc12</td>
          <td></td>
        </tr>
        <tr>
          <td>9.0</td>
          <td>en</td>
          <td>9.0 Resources</td>
          <td>toc13</td>
          <td><a href="https://github.com/canada-ca/design-system/blob/CCCSG-158-recode-style-guide/_includes/style-guide/14-toc13.html">14-toc13.html</a></td>
        </tr>
        <tr>
          <td>9.0</td>
          <td>fr</td>
          <td>9.0 Ressources</td>
          <td>toc13</td>
          <td></td>
        </tr>
      </tbody>
    </table>
  </div>
</div>

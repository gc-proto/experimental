---
altLangPage: false
breadcrumbs:
  - title: DTO asset migration
    link: "https://test.canada.ca/experimental/migration/"
css:
- https://design.canada.ca/css/split-h1.css
- https://design.canada.ca/css/custom.css
- https://use.fontawesome.com/releases/v5.15.4/css/all.css
- https://prycrane.github.io/experimental/prycrane/datatables/css/datatables-fun.css
date: 2023-03-08
dateModified: 2023-06-01
description: "Migration of DTO assets from AEM to GitHub"
language: en
layout: form
share: false
nositesearch: true
showFeedback: false
nomenu: true
noReportProblem: true
title: "Moving from AEM to GitHub"
---
<div class="row">
  <div class="col-md-8">
    <h1 property="name" id="wb-cont" dir="ltr"><span class="stacked"><span>Moving from AEM to GitHub</span>: <span>DTO asset migration</span></span></h1>
    <p>We're moving DTO assets from AEM to our GitHub repositories.</p>
    <h2 class="h3 mrgn-tp-lg">Current GitHub repositories</h2>
    <ul class="fa-ul">
      <li><span class="fa-li"><span class="fas fa-code-branch"></span></span><a href="https://github.com/canada-ca/design-system">design-system (English design sytem repository)</a></li>
      <li><span class="fa-li"><span class="fas fa-code-branch"></span></span><a href="https://github.com/canada-ca/systeme-conception">systeme-conception (French design sytem repository)</a></li>
    </ul>
    <h2 class="h3 mrgn-tp-lg">AEM inventory</h2>
    <ul class="fa-ul">
      <li><span class="fa-li"><span class="fab fa-google-drive"></span></span><a href="https://docs.google.com/spreadsheets/d/1xbBwK4ximVygzuqV0Ie-cbQjEDvyVQLfZExcbLsupkw">AEM inventory</a></li>
    </ul>
    <h2 class="h3 mrgn-tp-lg">Migration plan</h2>
    <ul class="list-unstyled">
      <li>
        <details>
          <summary class="bg-success">Phase 1 - Content and architecture specification <span class="pull-right"><strong>Done</strong></span></summary>
          <section class="panel panel-default mrgn-tp-lg mrgn-bttm-lg">
            <table class="table small table-striped table-bordered table-responsive">
              <caption class="wb-inv">
              Phase 1 - Content and architecture Specification
              </caption>
              <thead>
                <tr>
                  <th class="text-center col-md-1">Phase</th>
                  <th class="col-md-9">Page</th>
                  <th class="text-center col-md-2">Language</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td class="text-center">1</td>
                  <td><a href="https://www.canada.ca/en/treasury-board-secretariat/services/government-communications/canada-content-information-architecture-specification.html">Canada.ca Content and Information Architecture Specification</a></td>
                  <td class="text-center">En</td>
                </tr>
                <tr>
                  <td class="text-center">1</td>
                  <td><a href="https://www.canada.ca/en/treasury-board-secretariat/services/government-communications/canada-content-information-architecture-specification/usage-canadaca-design.html">Who has to use the Canada.ca design system</a></td>
                  <td class="text-center">En</td>
                </tr>
                <tr>
                  <td class="text-center">1</td>
                  <td><a href="https://www.canada.ca/en/treasury-board-secretariat/services/government-communications/canada-content-information-architecture-specification/mandatory-elements.html">Mandatory elements of the Canada.ca design system</a></td>
                  <td class="text-center">En</td>
                </tr>
                <tr>
                  <td class="text-center">1</td>
                  <td><a href="https://www.canada.ca/en/treasury-board-secretariat/services/government-communications/canada-content-information-architecture-specification/organizing-content.html">Organizing content on Canada.ca</a></td>
                  <td class="text-center">En</td>
                </tr>
                <tr>
                  <td class="text-center">1</td>
                  <td><a href="https://www.canada.ca/en/treasury-board-secretariat/services/government-communications/canada-content-information-architecture-specification/templates.html">Designing content on Canada.ca</a></td>
                  <td class="text-center">En</td>
                </tr>
                <tr>
                  <td class="text-center">1</td>
                  <td><a href="https://www.canada.ca/fr/secretariat-conseil-tresor/services/communications-gouvernementales/specifications-contenu-architecture-information-canada.html">Spécifications du contenu et de l’architecture de l'information pour Canada.ca</a></td>
                  <td class="text-center">Fr</td>
                </tr>
                <tr>
                  <td class="text-center">1</td>
                  <td><a href="https://www.canada.ca/fr/secretariat-conseil-tresor/services/communications-gouvernementales/specifications-contenu-architecture-information-canada/utilisation-concept-canadaca.html">Canada.ca : Qui doit utiliser le sysème de conception de Canada.ca</a></td>
                  <td class="text-center">Fr</td>
                </tr>
                <tr>
                  <td class="text-center">1</td>
                  <td><a href="https://www.canada.ca/fr/secretariat-conseil-tresor/services/communications-gouvernementales/specifications-contenu-architecture-information-canada/elements-obligatoires.html">Canada.ca : Éléments obligatoires du système de conception de Canada.ca</a></td>
                  <td class="text-center">Fr</td>
                </tr>
                <tr>
                  <td class="text-center">1</td>
                  <td><a href="https://www.canada.ca/fr/secretariat-conseil-tresor/services/communications-gouvernementales/specifications-contenu-architecture-information-canada/organiser-contenu.html">Canada.ca : Organiser le contenu dans Canada.ca</a></td>
                  <td class="text-center">Fr</td>
                </tr>
                <tr>
                  <td class="text-center">1</td>
                  <td><a href="https://www.canada.ca/fr/secretariat-conseil-tresor/services/communications-gouvernementales/specifications-contenu-architecture-information-canada/modeles.html">Canada.ca : Concevoir le contenu pour Canada.ca</a></td>
                  <td class="text-center">Fr</td>
                </tr>
              </tbody>
            </table>
            <footer class="panel-footer small">
              <h4 class="h5 mrgn-tp-lg">AEM redirects - file for AEM (Phase 1)</h4>
              <ul class="fa-ul">
                <li><span class="fa-li"><span class="fas fa-directions"></span></span><a href="https://docs.google.com/spreadsheets/d/1DL6_TF12ddaT2dzX-Zvulp8G-nviOxkP40h0fNzL14g/edit#gid=0">AEM redirects - Architecture Specification</a></li>
                <li>\Principle Publisher Reference #20230518-101635-000-A</li>
              </ul>
              <h4 class="h5 mrgn-tp-lg">English (Phase 1)</h4>
              <ul class="fa-ul">
                <li><span class="fa-li"><span class="fas fa-code-branch"></span></span><a href="https://github.com/canada-ca/design-system/pull/200">Pull request #200: Content and Information Architecture Specification</a></li>
                <li><span class="fa-li"><span class="fas fas fa-code"></span></span><a href="https://deploy-preview-200--design-system-canada-ca.netlify.app/architecture/canada-content-information-architecture-specification.html">Preview: Canada.ca Content and Information Architecture Specification</a></li>
              </ul>
              <h4 class="h5 mrgn-tp-lg">French (Phase 1)</h4>
              <ul class="fa-ul">
                <li><span class="fa-li"><span class="fas fa-code-branch"></span></span><a href="https://github.com/canada-ca/systeme-conception/pull/126">Pull request #126: Migration specifications du contenu</a></li>
                <li><span class="fa-li"><span class="fas fas fa-code"></span></span><a href="https://deploy-preview-126--systeme-conception-canada-ca.netlify.app/architecture/specifications-contenu-architecture-information-canada.html">Preview: Spécifications du contenu et de l’architecture de l'information pour Canada.ca</a></li>
              </ul>
            </footer>
          </section>
        </details>
      </li>
      <li>
        <details open="open">
          <summary class="bg-info">Phase 2 - Content style guide, top tasks, about..... <span class="pull-right"><strong>Current</strong></span></summary>
          <section class="panel panel-default mrgn-tp-lg">
            <table class="table small table-striped table-bordered table-responsive">
              <caption class="wb-inv">
              Phase 2 - Content style guide, top tasks, about.....
              </caption>
              <thead>
                <tr>
                  <th class="text-center col-md-1">Phase</th>
                  <th class="col-md-9">Page</th>
                  <th class="text-center col-md-2">Language</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td class="text-center">2</td>
                  <td><a href="https://www.canada.ca/en/government/about.html">About Canada.ca</a></td>
                  <td class="text-center">En</td>
                </tr>
                <tr>
                  <td class="text-center">2</td>
                  <td><a href="https://www.canada.ca/en/government/about/about-digital-transformation-office.html">About the Digital Transformation Office</a></td>
                  <td class="text-center">En</td>
                </tr>
                <tr>
                  <td class="text-center">2</td>
                  <td><a href="https://www.canada.ca/en/treasury-board-secretariat/services/government-communications/canada-content-style-guide.html">Canada.ca Content Style Guide</a></td>
                  <td class="text-center">En</td>
                </tr>
                <tr>
                  <td class="text-center">2</td>
                  <td><a href="https://www.canada.ca/en/government/about/design-system/latest-changes.html">Latest changes to the Canada.ca design system</a></td>
                  <td class="text-center">En</td>
                </tr>
                <tr>
                  <td class="text-center">2</td>
                  <td><a href="https://www.canada.ca/en/government/about/top-tasks-for-canada-ca.html">Top tasks for Canada.ca</a></td>
                  <td class="text-center">En</td>
                </tr>
                <tr>
                  <td class="text-center">2</td>
                  <td><a href="https://www.canada.ca/fr/gouvernement/a-propos.html">À propos de Canada.ca</a></td>
                  <td class="text-center">Fr</td>
                </tr>
                <tr>
                  <td class="text-center">2</td>
                  <td><a href="https://www.canada.ca/fr/gouvernement/a-propos/a-propos-bureau-transformation-numerique.html">À propos du Bureau de la transformation numérique</a></td>
                  <td class="text-center">Fr</td>
                </tr>
                <tr>
                  <td class="text-center">2</td>
                  <td><a href="https://www.canada.ca/fr/gouvernement/a-propos/taches-principales-pour-canada-ca.html">Tâches principales pour Canada.ca</a></td>
                  <td class="text-center">Fr</td>
                </tr>
                <tr>
                  <td class="text-center">2</td>
                  <td><a href="https://www.canada.ca/fr/secretariat-conseil-tresor/services/communications-gouvernementales/guide-redaction-contenu-canada.html">Guide de rédaction du contenu du site Canada.ca</a></td>
                  <td class="text-center">Fr</td>
                </tr>
                <tr>
                  <td class="text-center">2</td>
                  <td><a href="https://www.canada.ca/fr/gouvernement/a-propos/systeme-conception/derniers-changements.html">Derniers changements apportés au système de conception de Canada.ca</a></td>
                  <td class="text-center">Fr</td>
                </tr>
              </tbody>
            </table>
            <footer class="panel-footer small">
              <h4 class="h5 mrgn-tp-lg">AEM redirects - file for AEM (Phase 2)</h4>
              <ul class="fa-ul">
                <li><span class="fa-li"><span class="fas fa-directions"></span></span><a href="https://docs.google.com/spreadsheets/d/1DL6_TF12ddaT2dzX-Zvulp8G-nviOxkP40h0fNzL14g/edit#gid=0">AEM redirects - Architecture Specification</a></li>
                <li></li>
              </ul>
              <h4 class="h5 mrgn-tp-lg">English (Phase 2)</h4>
              <ul class="fa-ul">
                <li><span class="fa-li"><span class="fas fa-code-branch"></span></span><a href="https://github.com/canada-ca/design-system/pull/253">Pull request: AEM Migration Phase 2 #253</a></li>
                <li><span class="fa-li"><span class="fas fas fa-code"></span></span><a href="https://deploy-preview-253--design-system-canada-ca.netlify.app/about/about.html">Preview: About Canada.ca</a></li>
              </ul>
              <h4 class="h5 mrgn-tp-lg">French (Phase 2)</h4>
              <ul class="fa-ul">
                <li><span class="fa-li"><span class="fas fa-code-branch"></span></span><a href="https://github.com/canada-ca/systeme-conception/pull/150">Pull request: AEM Migration Phase 2 #150</a></li>
                <li><span class="fa-li"><span class="fas fas fa-code"></span></span><a href="https://deploy-preview-150--systeme-conception-canada-ca.netlify.app/a-propos/a-propos.html">Preview: À propos de Canada.ca</a></li>
              </ul>
            </footer>
          </section>
        </details>
      </li>
      <li>
        <details>
          <summary class="bg-info">Phase 3 - landing page and template and pattern library <span class="pull-right"><strong>To do</strong></span></summary>
          <section class="panel panel-default mrgn-tp-lg">
            <table class="table small table-striped table-bordered table-responsive">
              <caption class="wb-inv">
              Phase 3 - landing page and template and pattern library
              </caption>
              <thead>
                <tr>
                  <th class="text-center col-md-1">Phase</th>
                  <th class="col-md-9">Page</th>
                  <th class="text-center col-md-2">Language</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td class="text-center">3</td>
                  <td><a href="https://www.canada.ca/en/government/about/design-system/pattern-library.html">Template and pattern library for Canada.ca</a></td>
                  <td class="text-center">En</td>
                </tr>
                <tr>
                  <td class="text-center">3</td>
                  <td><a href="https://www.canada.ca/en/government/about/design-system.html">Canada.ca design system</a></td>
                  <td class="text-center">En</td>
                </tr>
                <tr>
                  <td class="text-center">3</td>
                  <td><a href="https://www.canada.ca/fr/gouvernement/a-propos/systeme-conception/bibliotheque-modeles.html">Bibliothèque de modèles et de configurations de conception</a></td>
                  <td class="text-center">Fr</td>
                </tr>
                <tr>
                  <td class="text-center">3</td>
                  <td><a href="https://www.canada.ca/fr/gouvernement/a-propos/systeme-conception.html">Système de conception de Canada.ca</a></td>
                  <td class="text-center">Fr</td>
                </tr>
              </tbody>
            </table>
          </section>
        </details>
      </li>
    </ul>
  </div>
  <div class="col-md-4">
    <div><img src="./images/bunny20.png" alt="" class="img-responsive"></div>
  </div>
</div>

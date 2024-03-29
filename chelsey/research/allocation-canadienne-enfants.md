---
altLangPage: "/research-summaries/canada-child-benefits"
breadcrumbs:
  - title: "À propos de Canada.ca"
    link:  "https://www.canada.ca/fr/gouvernement/a-propos.html"
  - title: Improving content on Canada.ca
    link: "https://blogue.canada.ca/pages/apercu-projet.html" 
css:
- ../css/blog.css
- https://use.fontawesome.com/releases/v5.15.4/css/all.css
date: 2023-08-09
description: "Ce résumé de recherche définit le contexte du projet de recherche dans le cadre duquel le modèle de navigation de style métro a été créé et décrit tous les points qui ont été pris en considération"
language: fr
layout: default
pageclass: cnt-wdth-lmtd
share: true
section-title: "Résumé de recherche"
title: "Allocation canadienne pour enfants"
---

L’allocation canadienne pour enfants (ACE) contribue à réduire la pauvreté infantile au Canada. Au début de 2019, le Bureau de la transformation numérique (BTN) a travaillé en partenariat avec l’Agence du revenu du Canada (ARC) en vue de remodeler les pages consacrées à l’allocation canadienne pour enfants sur Canada.ca. L’objectif de l’équipe était de réduire le nombre d’appels reçu par l’entremise du centre d’appels pour certaines questions fondamentales. Après le lancement des pages remaniées en 2020, le centre d’appels de l’ARC a confirmé que le volume d’appels avait en effet diminué.

Afin de répondre aux besoins des parents qui utilisent un téléphone cellulaire, l’équipe a cocréé un nouveau modèle que nous appelons la navigation de style métro. La conception existante était divisée en différentes étapes, ce qui ne s’avérait pas convivial sur les écrans de téléphones. La représentation visuelle des liens de la nouvelle conception ressemble aux stations d’un plan de métro.

Ce résumé de recherche définit le contexte du projet de recherche dans le cadre duquel le modèle de navigation de style métro a été créé et décrit tous les points qui ont été pris en considération. Il souligne également les autres innovations qui ont écoulé de ce projet.

La navigation de style métro s’est avérée un modèle efficace pour guider les utilisateurs à travers un service qui comporte plusieurs étapes. Les analyses et les tests d’utilisabilité ont montré que ce modèle permet d’aider les utilisateurs à suivre « la bonne voie&nbsp;» et qu’il présente de meilleurs taux de repérage et de réussite. L’ARC a par la suite adopté le modèle et l’a utilisé avec succès pour les pages de la Prestation canadienne d’urgence (PCU) et de la Prestation canadienne de la relance économique (PCRE).

Comprendre quand et comment utiliser la navigation de style métro vous permettra de faire emploi de ce puissant modèle correctement.

## Établir une base de référence
En 2019, l’Agence du revenu du Canada (ARC) cherchait à réduire le nombre d’appels de Canadiens qui n’arrivaient pas à trouver ni à comprendre le contenu Web qui explique comment obtenir ou continuer à recevoir leur allocation pour enfants. Le Bureau de la transformation numérique (BTN) s’est associé à l’ARC pour mener à bien cette tâche principale.

La première étape consistait à organiser des ateliers avec divers intervenants, y compris des membres du personnel du centre d’appels. Les ateliers avaient pour but de comprendre quels étaient les principaux facteurs d’appel.

L’équipe a utilisé les données du centre d’appels pour caractériser les problèmes communs. Elle a ensuite généré une série exhaustive de scénarios en situation réelle reflétant les problèmes et les contextes qui étaient à l’origine du volume d’appels le plus important. Elle a utilisé ces données pour créer des scénarios de test en vue d’effectuer des tests de référence et de comparaison.

Parmi les principaux facteurs d’appel, on retrouvait les sujets suivants&nbsp;:

-  Pourquoi les gens ne reçoivent pas leurs versements (25&nbsp;%)
-  Quel sera le montant de mes versements (12&nbsp;%)
-  Faire une demande d’ACE (10,5&nbsp;%)
-  Dette et somme due (4,3&nbsp;%)

L’équipe a sélectionné une série de ces scénarios pour définir une mesure de référence. Vingt parents canadiens utilisant des téléphones cellulaires ont mis à l’essai ces scénarios dans le cadre d’une étude de rendement liée aux tests d’utilisabilité avec modérateur. Le taux de réussite global était de 28&nbsp;% pour l’ensemble des sept scénarios de tâches. Cinq scénarios supplémentaires ont fait l’objet d’une mise à l’essai, mais moins de seize participants les ont réussi; ces scénarios n’ont donc pas été pris en considération dans le taux de réussite global.

<div class="row">
<div class="mrgn-tp-lg mrgn-bttm-md col-md-12">
    <figure class="gc-complex-img" role="group">
      <figcaption>
        <details close="">
          <summary>Scénarios de tâches de la base de référence</summary>
          <p class="mrgn-tp-lg">
          <div class="row mrgn-tp-lg">
  <div class="col-md-12">
    <div class="table-responsive">
      <table class="table">
       <caption class="wb-inv">
        Scénarios de tâches de la base de référence
        </caption>
        <thead>
          <tr>
            <th class="col-md-4">Tâche</th>
            <th class="col-md-8">Scénario</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>Versements suspendus</td>
            <td><p>Vous n’avez pas reçu votre versement habituel pour l’ACE en mai ni en juillet. Lesquelles des raisons ci-dessous pourraient faire en sorte que les versements soient suspendus?</p>
             </td>
          </tr>
          <tr>
            <td>Calculer le montant de l’allocation</td>
            <td><p>Le deuxième enfant de Mart vient de naître. Quel sera le montant du versement de l’allocation canadienne pour enfants que Mart recevra chaque mois? – Mart habite au Québec, elle est célibataire et a la garde exclusive de ses enfants. Le premier enfant a 2 ans.  Son revenu de l’an dernier était de 60 000&nbsp;$.  Elle sera en congé pour les 12 prochains mois, donc elle gagnera seulement 30 000&nbsp;$.</p>
              </td>
          </tr>
          <tr>
            <td>Date du versement</td>
            <td><p>Référence : Quel jour de juillet, précisément, votre versement de l’allocation canadienne pour enfants sera-t-il effectué?</p>
            <p>Optimisation : Quel jour de décembre, précisément, votre versement de l’allocation canadienne pour enfants sera-t-il effectué?</p>
              </td>
          </tr>
          <tr>
            <td>Pourcentage de garde partagée</td>
            <td><p>Les enfants de Peter vivent avec son ex-conjointe. Ils vont commencer à venir habiter chez Peter deux fins de semaine par mois. Doit-il demander l’allocation canadienne pour enfants?
</p>
              </td>
          </tr>
          <tr>
            <td>Pourcentage de garde partagée</td>
            <td><p>Si vous êtes séparés et que vous partagez la garde de vos enfants, pourriez-vous décider ensemble du pourcentage de l’allocation canadienne pour enfants que chacun de vous recevra?
</p>
              </td>
          </tr>
          <tr>
            <td>Versement moins élevé en juillet</td>
            <td><p>Le versement de juillet de l’allocation canadienne pour enfants de Petra a été effectué et il est beaucoup moins élevé que celui qu’elle a reçu en juin. Quelle est la raison la plus probable de ce changement?</p>
              </td>
          </tr>
          <tr>
            <td>Changement à votre compte pour le dépôt direct en cours de mois</td>
            <td>Est-il prudent de fermer votre ancien compte bancaire avant d’avoir reçu votre versement de l’allocation canadienne pour enfants du 20 juin? Vous avez changé de numéro de compte bancaire pour le dépôt direct le 5 juin.</td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</div>  
          </p>
        </details>
      </figcaption>
    </figure>
  </div>
</div>

Les problèmes les plus fréquemment rencontrés par les participants étaient les suivants&nbsp;: ne pas trouver la page sur laquelle se trouvait la réponse à leur question (32 % des participants ont rencontré ce problème) ou ne pas être en mesure de déterminer la bonne réponse à l’aide des renseignements qui se trouvaient sur la page (p.&nbsp;ex., confondre l’admissibilité à l’allocation et le droit à celle-ci).

## Solutions de conception
L’équipe s’est concentrée sur la création d’un prototype de conception qui permettrait de résoudre les problèmes cernés lors du test de référence. Les pages existantes utilisaient le modèle de page de lancement d’un service avec la configuration relative à la navigation dans plusieurs pages ordonnées. Les parents qui accédaient à ces pages au moyen d’un téléphone n’étaient pas en mesure d’utiliser la navigation dans plusieurs pages de manière efficace.

La navigation prenait trop de place dans l’écran et ne reflétait pas la nature groupée des pages.  Certains parents croyaient que les ensembles de pages étaient des options de la section « Sur cette page&nbsp;». Ils avaient aussi tendance à sauter la page « Aperçu&nbsp;».

L’équipe a donc remplacé la configuration relative à la navigation dans plusieurs pages ordonnées par le nouveau modèle de navigation de style métro. Le modèle de navigation de style métro différencie les sections dans un espace plus restreint et affiche les liens entre celles-ci. 

<div class="row">
<div class="mrgn-tp-lg mrgn-bttm-md col-md-8">
    <figure class="gc-complex-img" role="group"> <img alt="Capture d'écran de l'ancien modèle de navigation dans plusieurs pages ordonnées de l'allocation canadienne pour enfants" src="https://test.canada.ca/experimental/chelsey/research/images/CCB_apercu_fr.png" class="img-responsive">
      <figcaption>
        <details close="">
          <summary>Description de l'image : ancien modèle de navigation dans plusieurs pages ordonnées de l'allocation canadienne pour enfants</summary>
          <p class="mrgn-tp-lg">L’ancien modèle de lancement d’un service avec navigation dans plusieurs pages ordonnées comportait des liens vers d’autres pages, qui étaient énumérés dans des boîtes individuelles dans la partie supérieure de la page. Le contenu de la page sélectionnée apparaissait en dessous, ce qui donnait l’impression que les liens étaient des liens « Sur cette page&nbsp;» et non des liens vers des pages connexes contenant des renseignements supplémentaires.</p>
        </details>
      </figcaption>
    </figure>
  </div>
</div>

### Le modèle de navigation de style métro
Le modèle de navigation de style métro comprend ce qui suit&nbsp;:

-  une page d’index permettant d’accéder à chacune des étapes; 
-  les pages des étapes, qui comprennent des liens vers les autres étapes;
-  des titres descriptifs axés sur les réponses.

La page d’index et les pages des étapes utilisent toutes une représentation visuelle des liens entre les étapes qui ressemble à un plan de métro.

#### Nouvelle page d'index
Dans le modèle de navigation de style métro, une page d’index remplace la page « Aperçu&nbsp;». Elle comporte un titre, une brève description et un graphique des étapes qui correspond au menu des étapes (les stations de métro). Elle constitue une page d’accueil facile à survoler décrivant chacune des étapes du service. Non seulement les pages d’accueil favorisent le référencement naturel, mais elles soutiennent également l’architecture de l’information. Les utilisateurs peuvent revenir à la page d’index à l’aide du fil d’Ariane.

#### Pages des étapes
Dans le modèle original de page de lancement d’un service avec la configuration relative à la navigation dans plusieurs pages, les gens éprouvaient des problèmes à naviguer d’une page à l’autre et cliquaient souvent sur le bouton de la page sur laquelle ils se trouvaient déjà.  La configuration de navigation de style métro rend les étapes plus claires sans répéter le titre et place la configuration « Sur cette page&nbsp;» après les liens de navigation de style métro. Sur un ordinateur de bureau, les liens de navigation de style métro apparaissent du côté droit de l’écran.

<div class="row">
<div class="mrgn-tp-lg mrgn-bttm-md col-md-8">
    <figure class="gc-complex-img" role="group"> <img alt="Capture d'écran de l'ancien modèle de navigation dans plusieurs pages ordonnées et du nouveau modèle de navigation de style métro de l'allocation canadienne pour enfants" src="https://test.canada.ca/experimental/chelsey/research/images/CCB_nav_metro_fr.png" class="img-responsive">
      <figcaption>
        <details close="">
          <summary>Description de l'image&nbsp;: l'ancien et le nouveau modèle de navigation de l'allocation canadienne pour enfants</summary>
          <p class="mrgn-tp-lg">(Première image) Ancienne navigation dans plusieurs pages. (Deuxième image) La navigation de style métro permet de bien distinguer les liens des pages des étapes de la présentation « Sur cette page&nbsp;». Le titre « Continuer à recevoir vos versements&nbsp;» apparaît sous les liens de navigation de style métro. </p>
        </details>
      </figcaption>
    </figure>
  </div>
</div>

#### Nouveaux titres descriptifs axés sur les réponses
Dans le modèle de page de lancement d’un service avec la navigation dans plusieurs pages, les titres des pages s’affichent sous la forme de boutons sans espace pour la description. Le renvoi à la ligne brise l’alignement, donc les concepteurs de contenu limitent souvent les mots pour contrôler la taille des boutons. Dans l’étude de référence, il était donc plus difficile pour les gens de choisir le bon bouton, car les libellés n’étaient pas suffisamment clairs.

<div class="row">
<div class="mrgn-tp-lg mrgn-bttm-md col-md-8">
    <figure class="gc-complex-img" role="group"> <img alt="Capture d'écran du menu de navigation de l'allocation canadienne pour enfants" src="https://test.canada.ca/experimental/chelsey/research/images/CCB_nav_menu_fr.png" class="img-responsive">
      <figcaption>
        <details close="">
          <summary>Description de l'image : capture d’écran du menu de navigation de l'allocation canadienne pour enfants</summary> 
            <p class="mrgn-tp-lg">Capture d’écran d’un menu de navigation. L’en-tête est Allocation canadienne pour enfants&nbsp;: Aperçu. Les options de navigation sont Aperçu, Admissibilité, Faire une demande, Savoir combien vous pourriez recevoir, Dates de versement.</p>
        </details>
      </figcaption>
    </figure>
  </div>
</div>

Dans le modèle de navigation de style métro, le texte des liens peut être plus long. La page d’index comporte un espace pour afficher une description sous chaque lien.

<div class="row">
<div class="mrgn-tp-lg mrgn-bttm-md col-md-8">
    <figure class="gc-complex-img" role="group"> <img alt="Capture d'écran du modèle de navigation de style métro de l'allocation canadienne pour enfants" src="https://test.canada.ca/experimental/chelsey/research/images/CCB_nav_metro_fr.png" class="img-responsive">
      <figcaption>
        <details close="">
          <summary>Description de l'image : modèle de navigation de style métro de l'allocation canadienne pour enfants</summary>
          <p class="mrgn-tp-lg">Vue sur ordinateur de bureau de la page d’index de l’ACE, où chaque page d’étape est énumérée. Les titres de chaque page d’étape abordent les questions couramment reçues au centre d’appels. Elles sont&nbsp;: Qui peut faire une demande, Faire une demande, Savoir combien vous pourriez recevoir, Dates de versement, Continuer à recevoir vos versements, Communiquer avec l’ARC. Sous chaque titre se trouve une courte description de ce que les utilisateurs peuvent trouver sur la page.</p>
        </details>
      </figcaption>
    </figure>
  </div>
</div>

### Solutions de conception de contenu
Le projet d’optimisation comprenait de nombreuses autres modifications positives axées sur les réponses plutôt que sur les questions. En plus du passage à la navigation de style métro, l’équipe a apporté les modifications suivantes&nbsp;: 

-  elle a retiré des publications; 
-  elle a reformulé les titres dans un langage clair et simple à l’aide de mots-clés liés aux réponses;
-  elle a ajouté des choix afin de réduire la complexité;
-  elle a retiré  l’avis de non-responsabilité qui bloquait l’accès;
-  elle a supprimé le contenu qui apparaissait en double.

#### Retrait de publications
Les réponses que les utilisateurs cherchent à trouver doivent être intégrées au contenu des pages groupées. Dans le test de référence, certaines réponses concernant la garde figuraient dans un « carnet&nbsp;» en format PDF que certains participants refusaient d’ouvrir à partir de leur téléphone. Dans l’étude comparative, nous avons intégré les réponses du carnet directement dans les pages des étapes utilisées dans la navigation de style métro. Cette intégration a permis de faire en sorte que toutes les tâches liées à la garde affichaient un taux de réussite de 100&nbsp;%, alors que les taux de référence affichaient des taux de réussite de moins de 50&nbsp;%.

#### Reformulation des titres dans un langage clair et simple à l’aide de mots-clés liés aux réponses
Nous avons reformulé les titres des pages et les en-têtes pour répondre aux principales questions des utilisateurs. Par exemple, les participants à l’étude de référence ont effectué une recherche au moyen du terme « Faire une demande&nbsp;» pour savoir « qui peut faire une demande&nbsp;» ainsi que pour savoir « comment demeurer admissible&nbsp;». Le modèle de navigation de style métro comportait des titres de pages distincts pour chacune des réponses.

<div class="row">
<div class="mrgn-tp-lg mrgn-bttm-md col-md-8">
    <figure class="gc-complex-img" role="group"> <img alt="Capture d'écran de l'ancien et du nouveau modèle de conception avec les titres de pages adaptés" src="https://test.canada.ca/experimental/chelsey/research/images/CCB_admissibilite_fr.png" class="img-responsive">
      <figcaption>
        <details close="">
          <summary>Description de l'image : ancien et nouveau modèle de conception avec les titres de pages adaptés</summary>
          <p class="mrgn-tp-lg">L’ancienne conception comprenait les pages suivantes&nbsp;: Aperçu, Admissibilité, Faire une demande, Savoir combien vous pourriez recevoir et Dates de versement. Dans la nouvelle conception, les titres de page ont été adaptés pour correspondre à ce que les gens recherchent&nbsp;: Déterminer qui peut faire une demande, Faire une demande, Savoir combien vous pourriez recevoir, Dates de versement, Continuer à recevoir vos versements, Communiquer avec l’ARC.</p>
        </details>
      </figcaption>
    </figure>
  </div>
</div>

#### Réduire la complexité à l'aide du choix 
Les pages originales contenaient peu d’en-têtes qui étaient enfouis dans de longs blocs de texte expliquant chaque situation. Les gens avaient de la difficulté à trouver les réponses à partir de leur téléphone. 

Dans l’étude comparative, l’équipe a utilisé <a href="https://conception.canada.ca/configurations-conception-communes/contenu-reductible.html">le modèle afficher/masquer</a> pour masquer les réponses s’adressant à des groupes de personnes particuliers. Cette approche a été très concluante pour réduire la longueur des pages et pour aider les gens à choisir la réponse appropriée à leur situation. 

#### Retrait de l'avise de non-responsabilité bloquant l'accès 
Sur le site Web en ligne, un long avis de non-responsabilité bloquait l’accès à un important outil de calcul des prestations, et il fallait cliquer sur le bouton « J’accepte&nbsp;» qui se trouvait sous la mise en garde pour être en mesure de le lancer. Les participants ne faisaient pas défiler l’avis de non-responsabilité pour atteindre le bouton, et certaines personnes qui trouvaient ce bouton hésitaient à cliquer sur « J’accepte&nbsp;».  L’équipe a déplacé l’avis de non-responsabilité à la phase de réponse de l’outil, où il était pertinent de l’afficher, et a retiré l’étape « J’accepte&nbsp;». 

<div class="row">
<div class="mrgn-tp-lg mrgn-bttm-md col-md-8">
    <figure class="gc-complex-img" role="group"> <img alt="Capture d'écran avant et après le retrait de l'avis de non-responsabilité de l'allocation canadienne pour enfants" src="https://test.canada.ca/experimental/chelsey/research/images/Calculateur_fr.png" class="img-responsive">
      <figcaption>
        <details close="">
          <summary>Description de l'image : retrait de l'avis de non-responsabilité de l'allocation canadienne pour enfants </summary>
          <p class="mrgn-tp-lg"> Sur la première capture d'écran, l’ancienne conception affiche d’abord l’avis de non-responsabilité, qui occupe l’ensemble de l’écran sur les téléphones mobiles et cache l’outil de calcul. Sur la deuxième capture d'écran, la nouvelle conception utilise un bouton vert de super tâche pour attirer l’attention sur l’outil de calcul. L’avis de non-responsabilité ne se trouvant pas sur cette page, elle ne gêne pas la navigation.</p>
        </details>
      </figcaption>
    </figure>
  </div>
</div>

#### Autres améliorations 
Depuis la fin du projet d’optimisation, l’ARC a élaboré des sous-étapes qui aideront les utilisateurs à se concentrer sur des parties précises de leur parcours. Consultez le récent billet de blogue sur le modèle de navigation de style métro pour comprendre les nouveaux changements apportés au modèle.

## Mesure des résultats
Le taux de réussite global des tâches est passé de 28&nbsp;% à 83&nbsp;% lorsque le BTN a à nouveau mise à l’essai les scénarios de tâches du prototype. Cela a poussé l’ARC à modifier rapidement les pages en ligne pour refléter la nouvelle conception.

**Les volumes d’appels ont diminué**&nbsp;: les pages remaniées ont été mises en ligne en décembre 2019. Au cours du premier trimestre de 2020, le nombre d’appels reçus par l’ACE pour demander « Quel sera le montant de mes versements&nbsp;» a diminué de plus de 50&nbsp;%. À l’inverse, les appels visant à poser la même question pour le crédit lié à la TPS, dont les pages n’avaient pas été remaniées, n’ont pas diminué au cours de cette même période. 

**Augmentation de l’utilisation du calculateur**&nbsp;: l’utilisation du calculateur de prestations a doublé après que la page fut renommée « Combien vous pourriez recevoir&nbsp;» et que le lien vers le calculateur a été mis en évidence à l’aide d’un bouton vert. Entre avril et juin 2020, le nombre de visites sur la page en anglais du calculateur de prestations a presque doublé par rapport à ce qu’il était en 2019, totalisant 609&nbsp;703 visites en 2020 par rapport à 341&nbsp;492 visites en 2019. Les visites sur la page en français sont aussi passées de 76&nbsp;124 en 2019 à 118&nbsp;956 en 2020.

## Ce que nous avons appris
**Faire participer le centre d’appels aux projets d’optimisation.** La collaboration avec l’équipe du centre d’appels s’est avérée une étape cruciale pour atteindre l’objectif de réduire le nombre d’appels. Assurez-vous de connaître les principaux facteurs d’appel et d’organiser le contenu de manière à répondre à ces questions plutôt que de simplement fournir l’ensemble des renseignements et de laisser les personnes chercher elles-mêmes les réponses.

**Adaptez votre conception pour les utilisateurs d’appareils mobiles.** Pour les services où l’utilisation d’appareils mobiles est élevée, le modèle de navigation de style métro constitue une amélioration importante par rapport à la navigation par onglets dans plusieurs pages. Il permet de diviser des étapes uniques sur plusieurs pages qui illustrent clairement les étapes et le cheminement sur un téléphone.

Le modèle de navigation de style métro a amélioré la navigation pour de nombreux services offerts par l’ARC. Cela a commencé par l’allocation canadienne pour enfants, puis il a ensuite été largement utilisé dans le cadre des communications relatives aux prestations liées à la COVID-19 pendant la pandémie. L’ARC a continué à réaliser des tests d’utilisabilité et a amélioré davantage la conception, comme on peut le constater en visitant les nouvelles pages liées aux prestations.

D’autres ministères ont commencé à utiliser le modèle de navigation de style métro en raison de son utilité et de sa souplesse. Avant d’avoir recours à ce modèle, il est important de savoir quand l’utiliser et comment préparer le contenu pour qu’il fonctionne bien avec ce modèle.

## Pour en savoir plus 
- [Navigation de style métro](https://conception.canada.ca/configurations-conception-communes/navigation-metro.html)
- [Pages de lancement d’un service — Modèle de Canada.ca](https://conception.canada.ca/modeles-recommandes/pages-lancement-service.html)
- [Navigation dans plusieurs pages ordonnées](https://conception.canada.ca/configurations-conception-communes/navigation-plusieurs-pages.html)
  - On l’utilise pour exposer les grandes lignes du contenu qui s’étend sur plusieurs pages et qui a un ordre par défaut ou préféré.

## Communiquer avec le Bureau de la transformation numérique 
Communiquez avec nous si vous avez des questions ou si vous souhaitez connaître les résultats de recherche détaillés de ce projet.

-  Courriel&nbsp;: [dto-btn@tbs-sct.gc.ca](mailto:dto-btn@tbs-sct.gc.ca)
-  Twitter&nbsp;: #CanadaDotCa (en anglais)/ #CanadaPointCa (en français)
-  Slack&nbsp;: [http://design-GC-conception.slack.com](http://design-gc-conception.slack.com/)




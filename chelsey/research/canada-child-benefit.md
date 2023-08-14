---
altLangPage: "/resumes-recherche/allocation-canadienne-enfants"
breadcrumbs:
  - title: "About Canada.ca"
    link:  "https://www.canada.ca/en/government/about.html"
  - title: Improving content on Canada.ca
    link: "https://blog.canada.ca/pages/project-overview.html"
css:
- ../css/blog.css
- https://use.fontawesome.com/releases/v5.15.4/css/all.css
date: 2023-08-11
description: "This research summary explains the context of the research project in which the subway navigation pattern was created and all the considerations that were taken into account."
language: en
layout: default
share: true
section-title: "Research summary"
title: "Canada Child Benefit"
---

The Canada Child Benefit (CCB) contributes to reducing child poverty in Canada. In early 2019, the Digital Transformation Office (DTO) partnered with the Canada Revenue Agency (CRA) to redesign the Canada Child Benefit pages on Canada.ca. The team’s goal was to reduce calls to the call centre for key questions. After the redesigned pages went live in 2020, the CRA call centre confirmed that call rates had indeed dropped.

To meet the needs of parents on mobile phones, the team co-designed a new pattern we called subway navigation. The existing design was broken into steps, but wasn’t effective on phone screens. The new design’s visual representation of the links resembles the stops on a subway map.

This research summary explains the context of the research project in which the subway navigation pattern was created and all the considerations that were taken into account. It also highlights other innovations from this project.

Subway navigation has proven to be an effective pattern to lead users through a service that involves several steps. Analytics and usability testing have shown that it keeps users ‘on track’ with improved findability and success rates. The CRA later adopted and extended the pattern for the successful Canada Emergency Response Benefit (CERB) and Canada Recovery Benefits pages. 

By understanding when and how to use subway navigation, you can use this powerful pattern correctly. 

## Establishing a baseline
In 2019, the Canada Revenue Agency (CRA) sought to reduce calls from Canadians who couldn’t find or understand the web content that explains how to receive or maintain their child benefits. The Digital Transformation Office (DTO) partnered with CRA to work on this top task. 

The first step was to conduct workshops with stakeholders, including call centre staff. The intent of the workshops was to understand the top call drivers.

The team used call centre data to characterize common issues. They then generated an extensive set of real-world scenarios that reflected the problems and contexts that drove the highest volume of calls. They used this data to create testing scenarios for baseline and comparison tests.

Top call-drivers included:

-  Why do people miss payments (25%)
-  How much will I get (12%)
-  Apply for CCB (10.5%)
-  Debt/amount owing (4.3%)

The team selected a set of these scenarios to establish a baseline measurement. 20 Canadian parents on phones attempted the scenarios in a moderated usability performance study. The overall success rate was 28% across 7 task scenarios. An additional 5 scenarios were tested but fewer than 16 participants completed them so they weren’t included in the overall success score.

<div class="row">
<div class="mrgn-tp-lg mrgn-bttm-md col-md-12">
    <figure class="gc-complex-img" role="group">
      <figcaption>
        <details close="">
          <summary>Task Scenarios in baseline</summary>
          <p class="mrgn-tp-lg">
          <div class="row mrgn-tp-lg">
  <div class="col-md-12">
    <div class="table-responsive">
      <table class="table">
       <caption class="wb-inv">
        Task scenarios in baseline
        </caption>
        <thead>
          <tr>
            <th class="col-md-4">Task</th>
            <th class="col-md-8">Scenario</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>Payments stopped</td>
            <td><p>You didn't get your usual child benefit payment in May/July. Which of the reasons below would cause     payments to stop?</p>
             </td>
          </tr>
          <tr>
            <td>Calculate payment</td>
            <td><p>Mart's second child was just born. How much Canada Child Benefit will Mart get every month? - Mart lives in Quebec, single with sole custody. 1st child is 2 years old - Made 60,000 last year - Will be on leave for next 12 months so will only make $30,000</p>
              </td>
          </tr>
          <tr>
            <td>Payment date</td>
            <td><p>Baseline: Exactly which day in July will your Canada Child Benefit payment be deposited?</p>     
                <p>Optimization: Exactly which day in December will your Canada Child Benefit payment be deposited?
                </p>
              </td>
          </tr>
          <tr>
            <td>Share custody percentage</td>
            <td><p>Peter's kids are living with his ex. They will start coming to stay with Peter for 2 weekends per month. Should he apply for the Canada Child Benefit?
</p>
              </td>
          </tr>
          <tr>
            <td>Shared custody percentage</td>
            <td><p>If you were separated and sharing custody, could the two of you choose what percentage of the Canada Child Benefit each of you will get?
</p>
              </td>
          </tr>
          <tr>
            <td>Payment less in July</td>
            <td><p>Petra's July Child Benefit payment arrived and it is much less than she received in June. What is the most likely reason for this change?
</p>
              </td>
          </tr>
          <tr>
            <td>Direct deposit change within a month</td>
            <td>Is it safe to close your old bank account before your June 20th Child Benefit payment? You changed your direct deposit to a new bank account number on June 5th.</td>
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

The most common problems were not finding the page that held the answer (32% of participants had that problem) or not being able to determine the correct answer from the information on the page (for example mixing eligibility with entitlement).

## Design solutions
The team focused on prototyping a design that would solve the problems seen in the baseline test. The existing pages used the service initiation template with the ordered multi-page navigation pattern.  Parents on phones couldn’t use the multi-page navigation effectively.

It took up too much of the screen, and didn’t convey the grouped nature of the pages.  Some parents thought the page sets were “On this page” options. They also tended to avoid the Overview page.

The team replaced the multi page navigation pattern with the new subway navigation pattern. The subway pattern differentiates sections in a tighter space and conveys the connections.

<div class="row">
<div class="mrgn-tp-lg mrgn-bttm-md col-md-8">
    <figure class="gc-complex-img" role="group"> <img alt="Screenshot of Canada Child Benefit previous multi-page navigation" src="https://test.canada.ca/experimental/chelsey/research/images/CCB_overview_EN.png" class="img-responsive">
      <figcaption>
        <details close="">
          <summary>Image description: Canada Child Benefit previous multi-page navigation</summary>
          <p class="mrgn-tp-lg">The old service initiation template with ordered multi-page navigation had links to other pages listed in individual boxes at the top of the page. The content of the selected page appeared below, which gave the impression that the links were "On this page" links and not links to related pages with further information.</p>
        </details>
      </figcaption>
    </figure>
  </div>
</div>

### The subway navigation pattern
Subway navigation includes:
-  An index page leading to all the steps 
-  Step pages that include links to the other steps
-  Descriptive headings focused on answers

Both the index page and the step pages use a visual representation of the links between steps that resembles a subway map. 

#### New index page
In the subway navigation pattern, an index page replaces the Overview page. It has a title, brief description, and a step graphic that matches the subway steps menu. It provides an easy-to-scan landing page for the service that outlines each step. Landing pages help with both search engine optimization and support the information architecture. Users can navigate back to the index page through the breadcrumb.

#### Step pages
In the original Service initiation template with the multi-page navigation pattern, people had problems navigating between pages, often selecting the button for the page they were already on.  The Subway pattern makes the steps clearer without repeating the title and positions the On this page pattern after the subway links. On desktop, the subway links appear on the right of the screen. 

<div class="row">
<div class="mrgn-tp-lg mrgn-bttm-md col-md-8">
    <figure class="gc-complex-img" role="group"> <img alt="Screenshot of Canada Child Benefit previous multi-page navigation and new subway navigation" src="https://test.canada.ca/experimental/chelsey/research/images/CCB_subway_EN.png" class="img-responsive">
      <figcaption>
        <details close="">
          <summary>Image description: Canada Child Benefit templates comparison</summary>
          <p class="mrgn-tp-lg">(Left) Previous multi-page navigation. (Right) Subway navigation clearly differentiates the step pages from the On this page links and has the title of the page “Keep getting your payments” below the subway links.</p>
        </details>
      </figcaption>
    </figure>
  </div>
</div>

#### New descriptive headings focused on answers
In the Service initiation template with the multi-page navigation, page titles appear as buttons with no space for description. Word wrapping throws off the alignment, so content designers often limit the number of words to control the size of the buttons.  In the baseline study, this made it harder for people to choose between the buttons because the labels weren’t clear enough.

<div class="row">
<div class="mrgn-tp-lg mrgn-bttm-md col-md-8">
    <figure class="gc-complex-img" role="group"> <img alt="Screenshot of Canada Child Benefit navigation menu" src="https://test.canada.ca/experimental/chelsey/research/images/CCB_nav_menu_EN.png" class="img-responsive">
      <figcaption>
        <details close="">
          <summary>Image description: Canada Child Benefit navigation menu</summary>
          <p class="mrgn-tp-lg">Screenshot of a navigation menu. The heading is Canada Child Benefit: Overview. The navigation options are Overview, Eligibility, Apply, How much can you expect, Payment dates</p>
        </details>
      </figcaption>
    </figure>
  </div>
</div>

In the subway pattern, the link text can be longer. The index page has space for a description below each link.

<div class="row">
<div class="mrgn-tp-lg mrgn-bttm-md col-md-8">
    <figure class="gc-complex-img" role="group"> <img alt="Screenshot of Canada Child Benefit subway pattern" src="https://test.canada.ca/experimental/chelsey/research/images/Subway_EN.png" class="img-responsive">
      <figcaption>
        <details close="">
          <summary>Image description: Canada Child Benefit subway pattern</summary>
          <p class="mrgn-tp-lg">Desktop view of the index page for CCB with each step page listed. The titles for each step page address common call center questions. They include Who can apply, Apply, How much you can get, Payment dates, Keep getting your payments, Contact the CRA. Under each title is a short description describing what users can find on the page.</p>
        </details>
      </figcaption>
    </figure>
  </div>
</div>

### Content design solutions
The optimization project included many other successful changes focused on answers over information. Use of subway navigation was complemented by: 

-  integrating content from publications 
-  rewriting headings with answer keywords in plain language
-  reducing complexity with choices
-  removing disclaimer barriers
-  removing duplicated content

#### Removing publications
The answers users are looking for should be integrated into the grouped page content. In the baseline test, some answers about custody were in a PDF booklet that some participants refused to open on their phones. In the comparison study, we incorporated the booklet answers directly into the step pages used in the subway navigation. This integration ensured that both custody tasks reached 100% success, compared to baseline rates below 50%.

#### Rewriting headings with answer keywords in plain language
We redesigned page titles and headings to answer top user questions. For instance, baseline participants looked under “Apply” to know “who can apply” as well as “how to keep being eligible”. The subway design had separate page titles for each of the answers. 

<div class="row">
<div class="mrgn-tp-lg mrgn-bttm-md col-md-8">
    <figure class="gc-complex-img" role="group"> <img alt="Screenshot of Canada Child Benefit previous and new design with adjusted page titles" src="https://test.canada.ca/experimental/chelsey/research/images/CCB_eligibility_EN.png" class="img-responsive">
      <figcaption>
        <details close="">
          <summary>Image description: Canada Child Benefit previous and new design with adjusted page titles</summary>
          <p class="mrgn-tp-lg">The old design included the following pages: Overview, Eligibility, Apply, How much you can expect and Payment dates. The new design adjusted the page titles to match what people look for: Who can apply, Apply, How much you can get, Payment dates, Keep getting your payments, Contact the CRA</p>
        </details>
      </figcaption>
    </figure>
  </div>
</div>

#### Reducing complexity with choices
The original pages had few headings buried in long blocks of text that covered every situation. People struggled to find answers on their phones.

In the comparison study, the team used the <a href="https://design.canada.ca/common-design-patterns/collapsible-content.html">expand collapse pattern</a> to collapse answers that applied to only specific groups of people. This approach was very successful at shortening the pages, and helping people choose the right answer for their situation. 

#### Removing disclaimer barriers
On the live site, a long disclaimer blocked access to an important benefit calculator tool, with an ‘I accept’ button below to launch it. Participants failed to scroll past the disclaimer to the button, and some who did find the button hesitated to choose “accept”.  The team moved the disclaimers to the answer phase in the tool, where they were relevant, and removed the ‘I accept’ step.

<div class="row">
<div class="mrgn-tp-lg mrgn-bttm-md col-md-8">
    <figure class="gc-complex-img" role="group"> <img alt="Screenshot of Canada Child Benefit disclaimer update" src="https://test.canada.ca/experimental/chelsey/research/images/Calculator_EN.png" class="img-responsive">
      <figcaption>
        <details close="">
          <summary>Image description: Canada Child Benefit disclaimer update</summary>
          <p class="mrgn-tp-lg"> On the left, the old design displays the disclaimer first, which takes up the whole screen on mobile and hides the calculator. On the right, the new design uses a green super task button to draw attention to the calculator. The disclaimer isn't part of this page, so it doesn't get in the way.</p>
        </details>
      </figcaption>
    </figure>
  </div>
</div>

#### Other improvements
Since the optimization project, CRA has developed sub-steps that will help users to focus on specific parts of their journey. See the recent blog post on the subway pattern to understand new developments on the pattern.

## Measuring outcomes
The overall task success went up from 28% to 83% when DTO retested the task scenarios on the prototype. This prompted CRA to move quickly to change the live pages to reflect the new design.

**Call volumes dropped**: the redesigned pages went live in December 2019. In Q1 of 2020, calls for CCB asking “how much will my payment be” dropped by more than 50%. In contrast, calls for the same question for the GST credit - without redesigned pages - didn’t drop during the same period.

**Calculator use increased**: use of the Benefits calculator doubled after the page name changed to “How much can I get” and the calculator was highlighted with a green button. From April to June 2020, visits to the English benefits calculator page were almost double what they were in 2019 (609,703 in 2020 compared to 341,492 in 2019). Visits to the French page increased by more than a third ( 118,956 in 2020 compared with 76,124 in 2019).

## What we learned
**Involve the call centre in optimization projects.** To achieve the outcome of reducing calls, collaborating with the call centre team was essential. Know your top call drivers, and frame the content to answer those questions, rather than simply providing all the information for people to find the answers themselves.

**Design for mobile users.** For high-mobile services, the subway pattern is a substantial improvement over the multi-page tab navigation. It breaks up unique steps into pages that clearly convey the steps and journey on a phone.

The subway pattern has improved navigation for many services at CRA. It started with the Canada Child Benefit and was also widely used to communicate COVID benefits during the pandemic. CRA has continued doing usability testing and has continued to improve the design on new benefits pages.

Other departments have started to use the subway pattern for its usefulness and flexibility. Before using the pattern, it’s important to know when to use it and how to prepare the content to work well with the pattern.

## Explore further

-  [Subway navigation pattern](https://design.canada.ca/common-design-patterns/subway-navigation.html)
-  [Service initiation pages template](https://design.canada.ca/recommended-templates/service-initiation-pages.html)
-  [Ordered multi-page navigation](https://design.canada.ca/common-design-patterns/ordered-multipage.html)
-    Used to provide an outline of content that spans multiple pages and has a default or preferred order

## Connect with the Digital Transformation Office
Connect with us if you have questions or would like to see the detailed research findings from this project.

-  Email: [dto-btn@tbs-sct.gc.ca](mailto:dto-btn@tbs-sct.gc.ca)
-  Twitter: #CanadaDotCa (English) / #CanadaPointCa (French)
-  Slack: [http://design-GC-conception.slack.com](http://design-GC-conception.slack.com)



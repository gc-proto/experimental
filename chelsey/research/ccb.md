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
language: fr
layout: default
share: true
section-title: "Research summary"
title: "Canada Child Benefit"
---

he Canada Child Benefit (CCB) contributes to reducing child poverty in Canada. In early 2019, the Digital Transformation Office (DTO) partnered with the Canada Revenue Agency (CRA) to redesign the Canada Child Benefit pages on Canada.ca. The team’s goal was to reduce calls to the call centre for key questions. After the redesigned pages went live in 2020, the CRA call centre confirmed that call rates had indeed dropped.

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
<div class="mrgn-tp-lg mrgn-bttm-md col-md-8">
    <figure class="gc-complex-img" role="group">
      <figcaption>
        <details close="">
          <summary>Task Scenarios in baseline</summary>
          <p class="mrgn-tp-lg">
          <div class="row mrgn-tp-lg">
  <div class="col-md-8">
    <div class="table-responsive">
      <table class="table">
       <caption class="wb-inv">
        Task scenarios in baseline
        </caption>
        <thead>
          <tr>
            <th class="col-md-3">Task</th>
            <th class="col-md-5">Scenario</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>Task 1. Payments stopped</td>
            <td><p>You didn't get your usual child benefit payment in May/July. Which of the reasons below would cause     payments to stop?</p>
             </td>
          </tr>
          <tr>
            <td>Task 2. Calculate payment</td>
            <td><p>Mart's second child was just born. How much Canada Child Benefit will Mart get every month? - Mart lives in Quebec, single with sole custody. 1st child is 2 years old - Made 60,000 last year - Will be on leave for next 12 months so will only make $30,000</p>
              </td>
          </tr>
          <tr>
            <td>Task 4. Payment date</td>
            <td><p>Baseline: Exactly which day in July will your Canada Child Benefit payment be deposited? Optimization: Exactly which day in December will your Canada Child Benefit payment be deposited?
</p>
              </td>
          </tr>
          <tr>
            <td>Task 5. Share custody percentage</td>
            <td><p>Peter's kids are living with his ex. They will start coming to stay with Peter for 2 weekends per month. Should he apply for the Canada Child Benefit?
</p>
              </td>
          </tr>
          <tr>
            <td>Task 8. Shared custody percentage</td>
            <td><p>If you were separated and sharing custody, could the two of you choose what percentage of the Canada Child Benefit each of you will get?
</p>
              </td>
          </tr>
          <tr>
            <td>Task 9. Payment less in July</td>
            <td><p>Petra's July Child Benefit payment arrived and it is much less than she received in June. What is the most likely reason for this change?
</p>
              </td>
          </tr>
          <tr>
            <td>Task 12. Direct deposit change within a month</td>
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
    <figure class="gc-complex-img" role="group"> <img alt="Screenshot of an interactive trust exercise" src="https://test.canada.ca/experimental/chelsey/research/images/trust-en.png" class="img-responsive">
      <figcaption>
        <details close="">
          <summary>Image description: Interactive trust exercise</summary>
          <p class="mrgn-tp-lg">A sample of the survey experience for respondents using a desktop computer. Two similar Canada.ca webpages are displayed side-by-side. The survey tells the user to click the image that they trust the most as the official Government of Canada website. If they trust them equally, the user is instructed to click ‘same’.</p>
        </details>
      </figcaption>
    </figure>
  </div>
</div>











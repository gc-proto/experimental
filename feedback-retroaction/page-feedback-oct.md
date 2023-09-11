---
altLangPage: "https://test.canada.ca/experimental/feedback-retroaction/outil-retroaction.html"
breadcrumbs:
  - title: Design system
    link: "https://www.canada.ca/en/government/about/design-system.html"
  - title: Analytics and feedback
    link: "https://www.canada.ca/en/analytics.html"
  - title: Page feedback
    link: "https://design.canada.ca/feedback/index.html"
dateModified: 2023-03-03
language: en
layout: default
pageclass: cnt-wdth-lmtd
title: "Page feedback tool"
---

<p class="small">Last updated: October 4, 2023</p>

<p><span class="label label-warning">Optional</span></p>

The feedback tool is an **optional** pattern to collect feedback on the page experience. It replaces the “Report a problem” pattern while actively collecting user feedback.

![A heading labelled "Did you find what you were looking for?", followed by options to select yes or no.](./images/page-feedback.png)

## On this page

*   [When to use](#when-to-use)
*   [What to avoid](#what-to-avoid)
*   [Content and design](#content-and-design)
*   [How to implement](#how)
*   [Research and rationale](#research)
*   [Discussion](#discussion)



## When to use

Consider adding the page feedback tool to:

*   uncover specific page-level issues affecting your GC Task Success Survey task score
*   research issues on pages you plan on working on in the future
*   understand if new or existing pages are meeting user needs
*   identify emerging issues
*   monitor after page improvements have gone live



## What to avoid

Avoid using the page feedback tool on pages where there is no plan to monitor comments or take action. We also don’t recommend using the tool within secure spaces.

[Additional behaviours to avoid when analyzing feedback](https://design.canada.ca/feedback/when.html#how-not-to-use-the-tool)

## Content and design

<h3>Visual examples</h3>

<h4>1. Initial view of the feedback tool</h4>
![](./images/page-feedback.png)

<h4>2a. Default view after selecting "No"</h4>
![](./images/description-en.jpg)

<h4>2b. Optional view after selecting "No" with contact option</h4>
<p>The expando labeled “Need urgent help with a problem? Contact us” will be closed by default.</p>
<img src="./images/feedback-contact-en.png" width="600">


<h4>3. View after selecting "Yes" or after submitting feedback</h4>
<img src="./images/thankyou-new.png" width="600">


<details>
<summary>Feedback tool</summary>
<mark>what would be a better way to show the text for these images?</mark>
<p>A heading labelled "Did you find what you were looking for?", followed by options to select yes or no.</p>

<p>A heading labelled "Please provide more details", followed by the text "You will not receive a reply.
Don't include personal information (telephone, email, SIN, financial, medical, or work details).
Maximum 300 characters", and a text field to provide more details.</p>

<p>A heading labelled "Thank you for your feedback"</p>
</details>

<h3>Content specifications</h3>

<p><span class="label label-warning">Optional</span> Contact link</p>
<p>Consider adding a contact link in the page feedback tool if:</p>
<ul>
<li>users are trying to use the feedback tool as a method to get a response from the government</li>
<li>you have tried to make the page content clearer for how to contact the program or service and users are still using the feedback tool to get a response for their situation</li>
</ul>

<p>The link can go to an HTML page or an email address.</p>

<p>Keep the link text short. The recommended wording is “Contact [the Service Name]”</p>


<h4>Interactions</h4>
<p><strong>If a user selects "No"</strong> they will be shown an open text field to enter their comment.</p>

<p>The open text field begins with a heading labelled "Please provide more details", followed by the text "You will not receive a reply.
Don't include personal information (telephone, email, SIN, financial, medical, or work details).
Maximum 300 characters". After selecting "Submit", the user is shown a thank you message.</p>

<p>If the contact option is used, a contact link for the service is placed inside an expando labeled “Need urgent help with a problem? Contact us”.</p>

<p><strong>If a user selects "Yes"</strong> they will only be shown a thank you message.</p>


<h3>Design specifications</h3>
<p>The feedback widget replaces the "Report a problem" pattern when in use.</p>

<p><span class="label label-warning">Optional</span> Contact link</p>

<p>Only consider adding a contact link in the page feedback tool if:</p>
<ul>
<li>users are trying to use the feedback tool as a method to get a response from the government</li>
<li>you have tried to make the page content clearer for how to contact the program or service and users are still using the feedback tool to get a response for their situation</li>
</ul>



<a id="how"></a>
<h2>How to implement</h2>

<p>Add it to the bottom of a content page after the page content and before the date modified. </p>

<div class="wb-eqht">
<div class="row">
<div class="col-md-12">

<h3>Feedback tool for AEM pages</h3>
<p>Use these instructions for any page hosted on the Adobe Managed Web Service.</p>


<details>
<summary>Instructions</summary>

<h4>Add the feedback component</h4>
<p><mark>Need link to this</mark><a href="">How to add the feedback component to your page in AEM</a>. (Internal only on GCPedia) </p>

<h4><span class="label label-warning">Optional but recommended</span> Add a theme hidden value in the feedback code.</h4>

<p>This is useful when you want to download feedback for an entire theme of pages at the same time.</p>

<p>In most cases, you should include the Canada.ca theme for your content (full list below). </p>

<p>This is a unilingual value - enter the same theme value to your English and French pages.</p>

<details>
<summary>Canada.ca theme values</summary>

<ul>
<li>About Gov</li>
<li>Benefits</li>
<li>Business</li>
<li>CanadaTheWorld</li>
<li>Culture</li>
<li>Defense</li>
<li>Environment</li>
<li>Health</li>
<li>Immigration</li>
<li>Indigenous</li>
<li>Jobs</li>
<li>Money</li>
<li>Policing</li>
<li>PublicService</li>
<li>Science</li>
<li>Taxes</li>
<li>Transport</li>
<li>Travel</li>
<li>Veterans</li>
</ul>
</details>

<p>
If you would like to add a new theme value that is not currently in the Feedback Viewer, contact the Canada Digital Service. We will add the new theme value into the Feedback Viewer.</P>


<h4><span class="label label-warning">Optional</span> Add a “Section” hidden value in the feedback code. </h4>

<p>This is useful when you want to download feedback for multiple pages at the same time.</p>

<p>Consider including this value when you are adding the feedback tool to multiple pages on the same topic, such as “passports” or “employment insurance”.</p>

<p>This is a unilingual value - enter the same section value to your English and French pages.</p>

<p>If you would like to add a new section value that is not currently in the Feedback Viewer, contact the Canada Digital Service. We will add the new section value into the Feedback Viewer.</p>



<h4><span class="label label-warning">Optional</span> Contact link</h4>

<p>Only consider adding a contact link if:</p>
<ul>
<li>Users are trying to use the feedback tool as a method to get a response from the government</li>
<li>You have tried to make the page content clearer for how to contact the program or service and users are still using the feedback tool to get a response for their situation.</li>
</ul>

</details>                            
</div>


<div class="col-md-12">

<h3>Feedback tool code for non-AEM pages</h3>
<p>Use these instructions for any page that is not hosted on the Adobe Managed Web Service.</p>

<details>
<summary>Instructions</summary>

<h4>Add the feedback component</h4>
<p>Insert the feedback tool code where the “Report a problem on this page” is located in your page's HTML.</li>


<h4>Add the mandatory hidden values</h4>
<p>Update the data attributes for:</p>
<ul>
<li><mark>Required??</mark>Page title</li>
<li>Submission page (URL)</li>
<li><mark>Required??</mark>Page language (Use EN or FR)</li>
</ul>


<h4><span class="label label-warning">Optional but recommended</span> Add a theme hidden value in the feedback code.</h4>

<p>This is useful when you want to download feedback for an entire theme of pages at the same time.</p>

<p>In most cases, you should include the Canada.ca theme for your content (full list below). </p>

<p>This is a unilingual value - enter the same theme value to your English and French pages.</p>

<details>
<summary>Canada.ca theme values</summary>
<ul>
<li>About Gov</li>
<li>Benefits</li>
<li>Business</li>
<li>CanadaTheWorld</li>
<li>Culture</li>
<li>Defense</li>
<li>Environment</li>
<li>Health</li>
<li>Immigration</li>
<li>Indigenous</li>
<li>Jobs</li>
<li>Money</li>
<li>Policing</li>
<li>PublicService</li>
<li>Science</li>
<li>Taxes</li>
<li>Transport</li>
<li>Travel</li>
<li>Veterans</li>
</ul>
</details>

<p>If you would like to add a new theme value that is not currently in the Feedback Viewer, contact the Canada Digital Service. We will add the new theme value into the Feedback Viewer.</P>


<h4><span class="label label-warning">Optional</span> Add a “Section” hidden value in the feedback code. </h4>

<p>This is useful when you want to download feedback for multiple pages at the same time.</p>

<p>Consider including this value when you are adding the feedback tool to multiple pages on the same topic, such as “passports” or “employment insurance”.</p>

<p>This is a unilingual value - enter the same section value to your English and French pages.</p>

<p>If you would like to add a new section value that is not currently in the Feedback Viewer, contact the Canada Digital Service. We will add the new section value into the Feedback Viewer.</p>



<h4><span class="label label-warning">Optional</span> Contact link</h4>

<p>Only consider adding a contact link if:</p>
<ul>
<li>Users are trying to use the feedback tool as a method to get a response from the government</li>
<li>You have tried to make the page content clearer for how to contact the program or service and users are still using the feedback tool to get a response for their situation.</li>
</ul>

</details>



<details>
 <summary>Code</summary>
<ul>
<li><a href="https://wet-boew.github.io/GCWeb/sites/feedback/feedback-docs-en.html#variantPFT">Page Feedback Tool (default)</a></li>
<li><a href="https://wet-boew.github.io/GCWeb/sites/feedback/feedback-docs-en.html#variantPFTContact">Page Feedback Tool with contact link</a></li>
</ul>
</details>



</div>
</div>        
</div>


<h3 id="guidance">a Accessing and analyzing feedback</h3>

<p>Feedback can be viewed and downloaded as CSV or Excel files at any time using the Feedback Viewer website.</p>

<p>The Feedback Viewer is a password protected environment available to all page feedback participants. Contact the Canada Digital Service to access to the site.</p>

<p>Email: <a href="mailto:dto.btn@tbs-sct.gc.ca">dto.btn@tbs-sct.gc.ca</a></p>

<p><a href="https://design.canada.ca/feedback/index.html">Full guidance for using and analyzing page feedback</a> <p>




<a id="research"></a>
<h2>Research and rationale</h2>

<h3>Research findings</h3>
<p><a href="https://blog.canada.ca/2020/10/09/collect-feedback.html">Blog post: Collect feedback, find issues</a></p>

<h3>Policy rationale</h3>
<p>The <cite>Guideline for Service and Digital</cite> requires <a href="https://www.canada.ca/en/government/system/digital-government/guideline-service-digital.html#ToC2_2">client feedback</a> to be an integral part of service or product design. It can take several forms, including using the page feedback tool.</p>



<a id="discussion"></a>
<h2>Discussion</h2>
<ul>

<li><a href="mailto:dto.btn@tbs-sct.gc.ca">Send an email to the Canada Digital Service</a></li>
</ul>

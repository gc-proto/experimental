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
The expando labeled “Need urgent help with a problem? Contact us” will be closed by default.
![](./images/description-en.jpg)

<h4>3. View after selecting "Yes" or after submitting feedback</h4>
![](./images/thank-you-en.jpg)


<details>
<summary>Feedback tool</summary>

<p>A heading labelled "Did you find what you were looking for?", followed by options to select yes or no.</p>

<p>A heading labelled "Please provide more details", followed by the text "You will not receive a reply.
Don't include personal information (telephone, email, SIN, financial, medical, or work details).
Maximum 300 characters", and a text field to provide more details.</p>

<p>A heading labelled "Thank you for your feedback"</p>
</details>

<h3>Content specifications</h3>

<p><span class="label label-warning">Optional</span> Contact link</p>

<p>If using the contact link option, the link can go to an HTML page or an email address.</p>
<p>Keep the link text short and aim for the format “Contact [the Service Name]”</p>


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

<p>Consider adding a contact link in the page feedback tool if:</p>
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
<ol class="lst-spcd">

<li><a href="">How to add the feedback component to your page in AEM</a>. (Internal only on GCPedia) </li>

<li><span class="label label-warning">Optional but recommended</span> Add a theme hidden value in the feedback code.<br>

In most cases, you should include the Canada.ca theme for your content (full list below). This is useful when you want to download feedback for an entire theme of pages at the same time.<br>

This is a unilingual value - enter the same theme value to your English and French pages.

<details>
<summary>Canada.ca themes</summary>

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
<br>
If you would like to add a new theme value that is not currently in the Feedback Viewer, contact the Canada Digital Service. We will add the new theme value into the Feedback Viewer.<br>



</li>


<li><span class="label label-warning">Optional</span> Add a “Section” hidden value in the feedback code. <br>

Consider including this value when you are adding the feedback tool to multiple pages on the same topic, such as “passports” or “employment insurance”.  This is useful when you want to download feedback for multiple pages at the same time. <br>

This is a unilingual value - enter the same section value to your English and French pages.<br>

If you would like to add a new section value that is not currently in the Feedback Viewer, contact the Canada Digital Service. We will add the new section value into the Feedback Viewer.

</li>

<li><span class="label label-warning">Optional</span> Contact link<br>

Consider adding a contact link if:
<ul>
<li>Users are trying to use the feedback tool as a method to get a response from the government</li>
<li>You have tried to make the page content clearer for how to contact the program or service and users are still using the feedback tool to get a response for their situation.</li>
</ul>
</li>
</ol>
</details>                            


</div>

<div class="col-md-12">
<h3>Feedback tool code for non-AEM pages</h3>
<p>Use these instructions for any page that is not hosted on the Adobe Managed Web Service.</p>

<details>
<summary>Instructions</summary>
<ol class="lst-spcd">
<li>Insert this HTML code where the  “Did you find what you were looking for?” and “Share this page” are located.</li>

<li>Update the values of the hidden input  fields with the information specific to your implementation.  These hidden fields are for:</li>
<ul>
<li>Institution (your department acronym) - required</li>
<li>Theme - required</li>
<li>Section (a section of your website) - required but can be left blank</li>
<li>Page title - required</li>
<li>Submission page (URL) - required</li>
<li>Page language (Use EN or FR) - required</li>
</ul>

<p><strong><span class="bg-warning">Important note! </span></strong>Institution, Theme, Section values should be the SAME in English and French.</p>

<li>Add the Javascript just above the closing /body tag</li>

<li>When someone submits a comment, they will see a checkmark icon and a thank you message.  If you do not see a checkmark, you may need to include a reference to the Font Awesome icon catalog in your page header.</li>

<pre class="prettyprint"><code>
&lt;link rel=&quot;stylesheet&quot; href=&quot;https://use.fontawesome.com/releases/v5.8.1/css/all.css&quot; integrity=&quot;sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf&quot; crossorigin=&quot;anonymous&quot; /&gt;&lt;/li&gt;
 </code></pre>

<li><strong>For machine learning pilots only:</strong> Tell the DTO the URLS that the feedback tool has been added to.</li>

<li><strong>For all pilots:</strong> Tell the DTO if you are adding a new section or theme, so we can add these filters into the Feedback Viewer.</li>

</ol>
</details>

<details>
 <summary>Code</summary>

 </details>



</div>                  
</div>            
</div>


<h3 id="guidance">Accessing and analyzing feedback</h3>

<p>Feedback can be viewed and downloaded as CSV or Excel files at any time using the Feedback Viewer website.</p>

<p>The Feedback Viewer is a password protected environment available to all page feedback participants. Contact the DTO to access to the site.</p>

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

<li><a href="mailto:dto.btn@tbs-sct.gc.ca">Send an email to the Digital Transformation Office</a></li>
</ul>

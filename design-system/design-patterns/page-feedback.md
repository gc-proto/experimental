---
altLangPage: "#"
breadcrumbs:
  - title: Design system
    link: "https://www.canada.ca/en/government/about/design-system.html"
  - title: Analytics and feedback
    link: "https://www.canada.ca/en/government/about/design-system.html"
  - title: Page feedback
    link: "https://www.canada.ca/en/government/about/design-system.html"
css:
- https://design.canada.ca/css/split-h1.css
- https://design.canada.ca/css/custom.css
- https://use.fontawesome.com/releases/v5.15.4/css/all.css
date: 2023-03-03
dateModified: 2023-03-03
description: "Using page feedback to understand page level issues affecting task success."
lang: en
layout: without-h1
title: "Page feedback tool"
pageclass: cnt-wdth-lmtd
---
          <p class="bg-warning small"><strong>Optional on standard pages</strong></p>
            
        

          <p>The feedback tool is an <strong>optional</strong> pattern to collect feedback on the page experience. It replaces the “Report a problem” pattern while actively collecting user feedback.</p>
              
               <img src="../images/page-feedback.png" class="img-responsive pattern-demo" alt='A heading labelled "Did you find what you were looking for?", followed by options to select yes or no.'>
          <!--      <img src="../images/page-feedback-detail.png" class="img-responsive pattern-demo" alt=''>
                <details>
                <summary>Feedback tool</summary>
                
                  <p>A heading labelled "Did you find what you were looking for?", followed by options to select yes or no.</p>
                  
          <p>A heading labelled "Please provide more details", followed by the text "You will not receive a reply.
            Don't include personal information (telephone, email, SIN, financial, medical, or work details). 
            Maximum 300 characters", and a text field to provide more details.</p>
                </details>-->
            
          
            <h2>On this page</h2>
            <ul>

            	<li><a href="#rationale">When to use</a></li>
            	<li><a href="#cautions">What to avoid</a></li>
              <li><a href="#content">Content and design</a></li>
            	<li><a href="#how">How to implement</a></li>
                  	<li><a href="#research">Research and rationale</a></li>
              <li><a href="#latest">Latest changes</a></li>
              <li><a href="#discuss">Discussion</a></li>
            </ul>
            
            <section>
              
                 <h2 id="rationale">When to use</h2>
                
                   
                   <P>Consider adding the page feedback tool to:</p>
                   <ul>
                     <li>uncover specific page-level issues affecting your GC Task Success Survey task score</li>
                     <li>research issues on pages you plan on working on in the future </li>
                         <li>understand if new or existing pages are meeting user needs </li>
                         <li>identify emerging issues</li>
                         <li>monitor after page improvements have gone live</li>

                   </ul>
                     
                  <h2 id="cautions">What to avoid</h2>
                  
                   <P>Avoid using the page feedback tools on pages where there is no plan to monitor comments or take action.</p>
                     
                     <p><a href="https://test.canada.ca/experimental/feedback/when.html#not">Additional behaviours to avoid when analyzing feedback.</a></p>
                
                
                 <h2 id="content">Content and design</h2>
                 <img src="../images/page-feedback.png" class="img-responsive pattern-demo" alt=''>
            <img src="../images/page-feedback-detail.png" class="img-responsive pattern-demo" alt=''>
            <mark>Needs thank you image</mark>
                  <details>
                  <summary>Feedback tool</summary>
                  
                    <p>A heading labelled "Did you find what you were looking for?", followed by options to select yes or no.</p>
                    
            <p>A heading labelled "Please provide more details", followed by the text "You will not receive a reply.
              Don't include personal information (telephone, email, SIN, financial, medical, or work details). 
              Maximum 300 characters", and a text field to provide more details.</p>
            </details>
                  
                  <h3>Content specifications</h3>
                  <p><mark>Future content here about optional contact addition</mark></p>
               <h2 id="how">How to implement</h2>
               
               <p>Add it to the bottom of a content page after the page content and before the date modified. </p>

               <div class="wb-eqht">
                  <div class="row">
                  
                  
                    <div class="col-md-12">
                      <h3 class="h4">1. Feedback tool code for AEM pages</h3>
                      <p>Use this feedback code for any page hosted on the Adobe Managed Web Service.</p>
                      
                      
                      <details>
<summary>Instructions</summary>
                      <ol class="lst-spcd">
                     <li>Add a Generic HTML component at the bottom of the main content. Take the HTML code (below) as your baseline. This will be the “Did you find what you were looking for?” and “Share this page” section. </li>

<li>Update the values of the hidden input  fields with the information specific to your implementation.  </li>


These hidden fields are for:</li>
<ul>
 <li>Institution (your department acronym) - required</li>
<li>Theme - required</li>
<li>Section (a section of your website) - required but can be left blank</li>
<li>Page title - required</li>
</ul>

<strong><span class="bg-warning">Important note!</strong></span> Institution, Theme, Section values should be the SAME in English and French.
</br></br>




</li>

<li>Save and publish your changes! </li>



<li><strong>For machine learning pilots only:</strong> Tell the DTO the URLS that the feedback tool has been added to in order for feedback to populate the Airtable view.</li>



<li><strong>For all pilots:</strong> Tell the DTO if you are adding a new section or theme, so we can add these filters into the Feedback Viewer.</li>

</ol>
</details>      
                      
                      
                      
                      <details>
<summary>Code</summary>

<pre class="prettyprint"><code>
  &lt;div class=&quot;row row-no-gutters mrgn-tp-xl&quot;&gt;
      &lt;div class=&quot;col-sm-7 col-lg-6&quot;&gt;
          &lt;section class=&quot;gc-pg-hlpfl provisional&quot;&gt;
              &lt;div class=&quot;well mrgn-bttm-0&quot;&gt;
                  &lt;form id=&quot;gc-pg-hlpfl-frm&quot; action=&quot;/gc/services/generateemail&quot; method=&quot;post&quot; autocomplete=&quot;off&quot; class=&quot;provisional wb-postback&quot; data-wb-postback=&quot;{&quot;success&quot;:&quot;.gc-pg-hlpfl-thnk&quot;,&quot;content&quot;:&quot;#gc-pg-hlpfl-frm&quot;}&quot;&gt;
  &lt;input type=&quot;hidden&quot; name=&quot;institutionopt&quot; value=&quot;Institution - required - must use same acronym value EN and FR&quot;&gt;
  &lt;input type=&quot;hidden&quot; name=&quot;themeopt&quot; value=&quot;Theme - required - must use same value EN and FR&quot;&gt;
  &lt;input type=&quot;hidden&quot; name=&quot;sectionopt&quot; value=&quot;Section - required but can be blank - same value EN and FR&quot;&gt;
  &lt;input type=&quot;hidden&quot; name=&quot;pageTitle&quot; value=&quot;Page title (EN) - required&quot;&gt;
                  &lt;input type=&quot;hidden&quot; name=&quot;emailTemplate&quot; value=&quot;servcan/gc-pagesuccessen&quot;&gt;
                      &lt;div class=&quot;gc-pg-hlpfl-btn&quot;&gt;
                          &lt;div class=&quot;row row-no-gutters&quot;&gt;
                              &lt;div class=&quot;col-xs-12 col-sm-7 mrgn-tp-sm&quot;&gt;
                                  &lt;h2 class=&quot;mrgn-tp-sm h5&quot;&gt;Did you find what you were looking for?&lt;/h2&gt;
                              &lt;/div&gt;
                              &lt;div class=&quot;col-xs-8 col-sm-5 text-right&quot;&gt;
                                  &lt;button type=&quot;submit&quot; name=&quot;helpful&quot; value=&quot;Yes&quot; class=&quot;btn btn-primary&quot; data-gc-analytics-wtph&gt;Yes&lt;/button&gt;
                                  &lt;button type=&quot;button&quot; class=&quot;btn btn-primary mrgn-lft-sm nojs-hide&quot; data-wb-doaction=&quot;[                                    {&quot;action&quot;:&quot;removeClass&quot;,&quot;source&quot;:&quot;.gc-pg-hlpfl-no&quot;,&quot;class&quot;:&quot;nojs-show&quot;},
                                      {&quot;action&quot;:&quot;addClass&quot;,&quot;source&quot;:&quot;.gc-pg-hlpfl-btn&quot;,&quot;class&quot;:&quot;hide&quot;}
                                  ]&quot; data-gc-analytics-wtph-no&gt;No&lt;/button&gt;
                              &lt;/div&gt;
                          &lt;/div&gt;
                      &lt;/div&gt;
                      &lt;p class=&quot;h3 hidden nojs-show&quot;&gt;If not, tell us why:&lt;/p&gt;
                      &lt;div class=&quot;gc-pg-hlpfl-no nojs-show&quot;&gt;
                          &lt;fieldset&gt;
                              &lt;legend class=&quot;h4 mrgn-tp-0 mrgn-bttm-md&quot;&gt;What was wrong?&lt;/legend&gt;
                              
  &lt;div class=&quot;radio&quot;&gt;
  &lt;label for=&quot;problem1&quot;&gt;
  &lt;input name=&quot;problem&quot; id=&quot;problem1&quot; type=&quot;radio&quot; value=&quot;I can't find the information&quot; data-gc-analytics-wtph-value=&quot;I can't find the information-Je ne peux pas trouver l'information&quot; data-gc-analytics-collect=&quot;notPrivate&quot;&gt;I can't &lt;strong&gt;find&lt;/strong&gt; the information
  &lt;/label&gt;
  &lt;/div&gt;

  &lt;div class=&quot;radio&quot;&gt;
  &lt;label for=&quot;problem2&quot;&gt;
  &lt;input name=&quot;problem&quot; id=&quot;problem2&quot; type=&quot;radio&quot; value=&quot;The information is hard to understand&quot; data-gc-analytics-wtph-value=&quot;The information is hard to understand-L'information est difficile à comprendre&quot; data-gc-analytics-collect=&quot;notPrivate&quot;&gt; The information is hard to &lt;strong&gt;understand&lt;/strong&gt;
  &lt;/label&gt;
  &lt;/div&gt;

  &lt;div class=&quot;radio&quot;&gt;
  &lt;label for=&quot;problem3&quot;&gt;
  &lt;input name=&quot;problem&quot; id=&quot;problem3&quot; type=&quot;radio&quot; value=&quot;There was an error / something didn't work&quot; data-gc-analytics-wtph-value=&quot;There was an error or something didn't work-Il y avait une erreur ou quelque chose ne fonctionnait pas&quot; data-gc-analytics-collect=&quot;notPrivate&quot;&gt; There was an error or something &lt;strong&gt;didn't work&lt;/strong&gt;
  &lt;/label&gt;
  &lt;/div&gt;
                             &lt;div class=&quot;radio&quot;&gt;
                                  &lt;label for=&quot;problem4&quot;&gt;
                                      &lt;input name=&quot;problem&quot; id=&quot;problem4&quot; type=&quot;radio&quot; value=&quot;Other reason&quot; data-gc-analytics-wtph-value=&quot;Other reason-Autre raison&quot; data-gc-analytics-collect=&quot;notPrivate&quot;&gt;
                                      Other reason
                                  &lt;/label&gt;
                             &lt;/div&gt;
                          &lt;/fieldset&gt;
                          &lt;label for=&quot;problem6&quot; class=&quot;mrgn-bttm-0&quot;&gt;Please provide more details&lt;/label&gt;
                          &lt;p class=&quot;small&quot;&gt;
                              &lt;strong&gt;You will not receive a reply. Don't include personal information (telephone, email, SIN, financial, medical, or work details).&lt;/strong&gt;
                              &lt;br&gt;
                              &lt;span class=&quot;small&quot;&gt;Maximum 300 characters&lt;/span&gt;
                          &lt;/p&gt;
                          &lt;textarea id=&quot;problem6&quot; name=&quot;details&quot; class=&quot;full-width&quot; maxlength=&quot;300&quot;&gt;&lt;/textarea&gt;
                          &lt;button type=&quot;submit&quot; name=&quot;helpful&quot; value=&quot;No&quot; class=&quot;btn btn-primary mrgn-tp-md mrgn-bttm-sm&quot; data-gc-analytics-wtph-submit&gt;Submit&lt;/button&gt;
                      &lt;/div&gt;
                      &lt;input type=&quot;hidden&quot; name=&quot;problem&quot; value=&quot;&quot;&gt;
                  &lt;/form&gt;
                  &lt;div class=&quot;gc-pg-hlpfl-thnk hide&quot;&gt;
                      &lt;p class=&quot;h6 mrgn-tp-sm mrgn-bttm-sm&quot;&gt;&lt;span class=&quot;far fa-check-circle text-success mrgn-rght-sm&quot; aria-hidden=&quot;true&quot;&gt;&lt;/span&gt; Thank you for your feedback&lt;/p&gt;
                  &lt;/div&gt;
              &lt;/div&gt;
          &lt;/section&gt;
      &lt;/div&gt;
      &lt;div class=&quot;col-sm-3 col-sm-offset-1 col-lg-offset-3&quot;&gt;
          &lt;div class=&quot;wb-share&quot; data-wb-share=&quot;{&quot;pnlId&quot;:&quot;pnlShrPg&quot;, &quot;lnkClass&quot;: &quot;btn btn-default btn-block mrgn-tp-md&quot;}&quot;&gt;&lt;/div&gt;
      &lt;/div&gt;
  &lt;/div&gt;


</code></pre>
</details>
                    
                    
                    </div>
                    
                     <div class="col-md-12">
                       <h3 class="h4">2. Feedback tool code for non-AEM pages</h3>
                       <p>Use this feedback tool code for any page that is not hosted on the Adobe Managed Web Service.</p>
                       
                       <details>
 <summary>Instructions</summary>
                       <ol class="lst-spcd">
                      <li>Insert this HTML code where the  “Did you find what you were looking for?” and “Share this page” are located.</li>

<li>Update the values of the hidden input  fields with the information specific to your implementation.  </li>


These hidden fields are for:</li>
<ul>
  <li>Institution (your department acronym) - required</li>
<li>Theme - required</li>
<li>Section (a section of your website) - required but can be left blank</li>
<li>Page title - required</li>
<li>Submission page (URL) - required</li>
<li>Page language (Use EN or FR) - required</li>
</ul>

<strong><span class="bg-warning">Important note!</strong></span> Institution, Theme, Section values should be the SAME in English and French.
</br></br>




</li>

<li>Add the Javascript just above the closing /body tag</li>


<li>When someone submits a comment, they will see a checkmark icon and a thank you message.  If you do not see a checkmark, you may need to include a reference to the Font Awesome icon catalog in your page header.</br></br>

  <pre class="prettyprint"><code>
&lt;link rel=&quot;stylesheet&quot; href=&quot;https://use.fontawesome.com/releases/v5.8.1/css/all.css&quot; integrity=&quot;sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf&quot; crossorigin=&quot;anonymous&quot; /&gt;&lt;/li&gt;
 </code></pre>
</li>
<li><strong>For machine learning pilots only:</strong> Tell the DTO the URLS that the feedback tool has been added to in order for feedback to populate the Airtable view.</li>



<li><strong>For all pilots:</strong> Tell the DTO if you are adding a new section or theme, so we can add these filters into the Feedback Viewer.</li>

</ol>
</details>
                       <details>
 <summary>Code</summary>
 <pre class="prettyprint"><code>
   &lt;!-- START PAGE FEEDBACK WIDGET --&gt;
   &lt;div class=&quot;row row-no-gutters mrgn-tp-xl&quot;&gt;
   &lt;div class=&quot;col-sm-7 col-lg-6&quot;&gt;
      &lt;section class=&quot;gc-pg-hlpfl provisional&quot;&gt;
         &lt;div class=&quot;well mrgn-bttm-0&quot;&gt;
            &lt;form id=&quot;gc-pg-hlpfl-frm&quot; action=&quot;#&quot; method=&quot;post&quot; autocomplete=&quot;off&quot;&gt;
               &lt;input type=&quot;hidden&quot; name=&quot;institutionopt&quot; value=&quot;Institution acronym - required - must use same value EN and FR&quot;&gt;
               &lt;input type=&quot;hidden&quot; name=&quot;themeopt&quot; value=&quot;Theme - required - must use same value EN and FR&quot;&gt;
               &lt;input type=&quot;hidden&quot; name=&quot;language&quot; value=&quot;Language - required - use EN or FR&quot;&gt;
               &lt;input type=&quot;hidden&quot; name=&quot;pageTitle&quot; value=&quot;Page title EN - required&quot;&gt;
               &lt;input type=&quot;hidden&quot; name=&quot;submissionPage&quot; value=&quot;Page URL - required&quot;&gt;
               &lt;input type=&quot;hidden&quot; name=&quot;sectionopt&quot; value=&quot;Section - required but can be blank - must use same value EN and FR&quot;&gt;
               &lt;input type=&quot;hidden&quot; id=&quot;helpful&quot; name=&quot;helpful&quot; value=&quot;Yes&quot;&gt;
               &lt;div class=&quot;gc-pg-hlpfl-btn&quot;&gt;
                  &lt;div class=&quot;row row-no-gutters&quot;&gt;
                     &lt;div class=&quot;col-xs-12 col-sm-7 mrgn-tp-sm&quot;&gt;
                        &lt;h2 class=&quot;mrgn-tp-sm h5&quot;&gt;Did you find what you were looking for?&lt;/h2&gt;
                     &lt;/div&gt;
                     &lt;div class=&quot;col-xs-8 col-sm-5 text-right&quot;&gt;
                        &lt;button id=&quot;btnyes&quot; type=&quot;submit&quot; value=&quot;Yes&quot; class=&quot;btn btn-primary&quot;&gt;Yes&lt;/button&gt;
                        &lt;button id=&quot;btnno&quot; type=&quot;button&quot; class=&quot;btn btn-primary mrgn-lft-sm nojs-hide&quot;&gt;No&lt;/button&gt;
                     &lt;/div&gt;
                  &lt;/div&gt;
               &lt;/div&gt;
               &lt;p class=&quot;h3 hidden nojs-show&quot;&gt;If not, tell us why:&lt;/p&gt;
               &lt;div class=&quot;gc-pg-hlpfl-no nojs-show&quot;&gt;
                  &lt;fieldset&gt;
                     &lt;legend class=&quot;h4 mrgn-tp-0 mrgn-bttm-md&quot;&gt;What was wrong?&lt;/legend&gt;
                     &lt;div class=&quot;radio&quot;&gt;
                        &lt;label for=&quot;problem1&quot;&gt;
                        &lt;input name=&quot;problem&quot; id=&quot;problem1&quot; type=&quot;radio&quot; value=&quot;I can't find the information&quot; data-gc-analytics-wtph-value=&quot;I can't find the information-Je ne peux pas trouver l'information&quot; data-gc-analytics-collect=&quot;notPrivate&quot;&gt;
                        I can't &lt;strong&gt;find&lt;/strong&gt; the information
                        &lt;/label&gt;
                     &lt;/div&gt;
                     &lt;div class=&quot;radio&quot;&gt;
                        &lt;label for=&quot;problem2&quot;&gt;
                        &lt;input name=&quot;problem&quot; id=&quot;problem2&quot; type=&quot;radio&quot; value=&quot;The information is hard to understand&quot; data-gc-analytics-wtph-value=&quot;The information is hard to understand-L'information est difficile à comprendre&quot; data-gc-analytics-collect=&quot;notPrivate&quot;&gt;
                        The information is hard to &lt;strong&gt;understand&lt;/strong&gt;
                        &lt;/label&gt;
                     &lt;/div&gt;
                     &lt;div class=&quot;radio&quot;&gt;
                        &lt;label for=&quot;problem3&quot;&gt;
                        &lt;input name=&quot;problem&quot; id=&quot;problem3&quot; type=&quot;radio&quot; value=&quot;There was an error / something didn't work&quot; data-gc-analytics-wtph-value=&quot;There was an error or something didn't work-Il y avait une erreur ou quelque chose ne fonctionnait pas&quot; data-gc-analytics-collect=&quot;notPrivate&quot;&gt;
                        There was an error or something &lt;strong&gt;didn't work&lt;/strong&gt;
                        &lt;/label&gt;
                     &lt;/div&gt;
                     &lt;div class=&quot;radio&quot;&gt;
                        &lt;label for=&quot;problem4&quot;&gt;
                        &lt;input name=&quot;problem&quot; id=&quot;problem4&quot; type=&quot;radio&quot; value=&quot;Other reason&quot; data-gc-analytics-wtph-value=&quot;Other reason-Autre raison&quot; data-gc-analytics-collect=&quot;notPrivate&quot;&gt;
                        Other reason
                        &lt;/label&gt;
                     &lt;/div&gt;
                  &lt;/fieldset&gt;
                  &lt;label for=&quot;problem6&quot; class=&quot;mrgn-bttm-0&quot;&gt;Please provide more details&lt;/label&gt;
                  &lt;p class=&quot;small&quot;&gt;
                     &lt;strong&gt;You will not receive a reply. Don't include personal information (telephone, email, SIN, financial, medical, or work details).&lt;/strong&gt;
                     &lt;br&gt;
                     &lt;span class=&quot;small&quot;&gt;Maximum 300 characters&lt;/span&gt;
                  &lt;/p&gt;
                  &lt;textarea id=&quot;problem6&quot; name=&quot;details&quot; class=&quot;full-width&quot; maxlength=&quot;300&quot;&gt;&lt;/textarea&gt;
                  &lt;button type=&quot;submit&quot; value=&quot;No&quot; class=&quot;btn btn-primary mrgn-tp-md mrgn-bttm-sm&quot;&gt;Submit&lt;/button&gt;
               &lt;/div&gt;
            &lt;/form&gt;
            &lt;div class=&quot;gc-pg-hlpfl-thnk hide&quot;&gt;
               &lt;p class=&quot;h6 mrgn-tp-sm mrgn-bttm-sm&quot;&gt;&lt;span class=&quot;far fa-check-circle text-success mrgn-rght-sm&quot; aria-hidden=&quot;true&quot;&gt;&lt;/span&gt; Thank you for your feedback&lt;/p&gt;
            &lt;/div&gt;
         &lt;/div&gt;
      &lt;/section&gt;
   &lt;/div&gt;
   &lt;div class=&quot;col-sm-3 col-sm-offset-1 col-lg-offset-3&quot;&gt;
      &lt;div class=&quot;wb-share&quot; data-wb-share=&quot;{&quot;pnlId&quot;:&quot;pnlShrPg&quot;, &quot;lnkClass&quot;: &quot;btn btn-default btn-block mrgn-tp-md&quot;}&quot;&gt;&lt;/div&gt;
   &lt;/div&gt;
   &lt;/div&gt;
   &lt;!-- END PAGE FEEDBACK WIDGET --&gt;
   &lt;!-- START SCRIPT PAGE FEEDBACK WIDGET --&gt;
   &lt;script&gt;
   $(document).on(&quot;wb-ready.wb&quot;, function() {
      $(&quot;#btnno&quot;).click(function(e) {
          $(&quot;.gc-pg-hlpfl-no&quot;).removeClass(&quot;nojs-show&quot;);
          $(&quot;.gc-pg-hlpfl-btn&quot;).addClass(&quot;hide&quot;);
          $(&quot;#helpful&quot;).val(&quot;No&quot;);
      });
      $(&quot;#gc-pg-hlpfl-frm&quot;).submit(function(e) {
          e.preventDefault();
          $(&quot;.gc-pg-hlpfl-thnk&quot;).removeClass(&quot;hide&quot;);
          $(&quot;#gc-pg-hlpfl-frm&quot;).addClass(&quot;hide nojs-show&quot;);
          $.ajax({
              url: 'https://pagesuccessemailqueue.azurewebsites.net/api/QueueProblemForm',
              type: 'POST',
              dataType: 'text',
              data: $('form#gc-pg-hlpfl-frm').serialize(),
              success: function(data) {},
              error: function(xhr, status, err) {
                  console.log(xhr.responseText);
              }
          });
      });
   });
   &lt;/script&gt;
   &lt;!-- END SCRIPT PAGE FEEDBACK WIDGET --&gt;

 </code></pre>
 </details>
                        
                        
                      
                     </div>
                  
                  </div>
              
              
                
               </div>
            </section>

            <section>
               <h3 id="guidance">Accessing and analyzing feedback</h3>
<ul>
  <li><a href="https://test.canada.ca/experimental/design-system/performance/feedback/index.html">Guidance for  analyzing, and using page feedback</a> calls for client feedback </li>
  <li><a href="https://www.gcpedia.gc.ca/wiki/Page_feedback_tool-test#Access_to_feedback">How to access feedback</a> (internal only)</li>
</ul>

            </section>
          

            <section>
              
              
               <h2 id="research">Research and rationale</h2>
               <h3>Policy rationale</h3>
              <p>The <a href="https://test.canada.ca/experimental/design-system/performance/feedback/index.html">Guideline for Service and Digital</a> requires <a href="https://www.canada.ca/en/government/system/digital-government/guideline-service-digital.html#ToC2_2">client feedback</a> to be an integral part of service or product design. It can take several forms, including using the page feedback tool.</p>
               
                <h2 id="latest">Latest changes</h2>
              
              
            
           <h2 id="discuss">Discussion</h2>
           <ul>
             <li><a href="https://github.com/canada-ca/design-system-systeme-conception/issues">Discuss the pattern in GitHub
               issues</a></li>
             <li><a href="https://design-gc-conception.slack.com/join/shared_invite/enQtODE1OTc5Mzg5NzQ4LWQ3MjZjMTdjMjk2ZTZmMTJjYWQ3ZmRiNDYwYjRmN2NjYzQyNjFlNDBlY2FkNWE1ODg2YjExY2QwZmVjN2MwMGM">Join the conversation on Slack</a></li>
             <li><a href="mailto:dto.btn@tbs-sct.gc.ca">Send an email to the Digital Transformation Office</a></li>
           </ul>
    
            </section>

            
              <!-- START PAGE FEEDBACK WIDGET -->
              <div class="row row-no-gutters mrgn-tp-xl">
                <div class="col-sm-7 col-lg-6">
                  <section class="gc-pg-hlpfl provisional">
                    <div class="well mrgn-bttm-0">
                      <form id="gc-pg-hlpfl-frm" action="#" method="post" autocomplete="off">
                        <input type="hidden" name="institutionopt" value="tbs">
                        <input type="hidden" name="themeopt" value="Policies">
                        <input type="hidden" name="language" value="EN">
                        <input type="hidden" name="pageTitle" value="Designing content for Canada.ca">
                        <input type="hidden" name="submissionPage" value="https://design.canada.ca/continuous-improvement.html">
                        <input type="hidden" name="sectionopt" value="Design system">
                        <input type="hidden" id="helpful" name="helpful" value="Yes">
                        <div class="gc-pg-hlpfl-btn">
                          <div class="row row-no-gutters">
                            <div class="col-xs-12 col-sm-7 mrgn-tp-sm">
                              <h2 class="mrgn-tp-sm h5">Did you find what you were looking for?</h2>
                            </div>
                            <div class="col-xs-8 col-sm-5 text-right">
                              <button id="btnyes" type="submit" value="Yes" class="btn btn-primary">Yes</button>
                              <button id="btnno" type="button"
                                class="btn btn-primary mrgn-lft-sm nojs-hide">No</button>
                            </div>
                          </div>
                        </div>
                        <p class="h3 hidden nojs-show">If not, tell us why:</p>
                        <div class="gc-pg-hlpfl-no nojs-show">
                          <fieldset>
                            <legend class="h4 mrgn-tp-0 mrgn-bttm-md">What was wrong?</legend>
                            <div class="radio">
                              <label for="problem1">
                                <input name="problem" id="problem1" type="radio"
                                  value="I can't find the information"
                                  data-gc-analytics-wtph-value="I can't find the information-Je ne peux pas trouver l'information"
                                  data-gc-analytics-collect="notPrivate">
                                I can't <strong>find</strong> the information
                              </label>
                            </div>
                            <div class="radio">
                              <label for="problem2">
                                <input name="problem" id="problem2" type="radio"
                                  value="The information is hard to understand"
                                  data-gc-analytics-wtph-value="The information is hard to understand-L'information est difficile à comprendre"
                                  data-gc-analytics-collect="notPrivate">
                                The information is hard to <strong>understand</strong>
                              </label>
                            </div>
                            <div class="radio">
                              <label for="problem3">
                                <input name="problem" id="problem3" type="radio"
                                  value="There was an error / something didn't work"
                                  data-gc-analytics-wtph-value="There was an error or something didn't work-Il y avait une erreur ou quelque chose ne fonctionnait pas"
                                  data-gc-analytics-collect="notPrivate">
                                There was an error or something <strong>didn't work</strong>
                              </label>
                            </div>
                            <div class="radio">
                              <label for="problem4">
                                <input name="problem" id="problem4" type="radio" value="Other reason"
                                  data-gc-analytics-wtph-value="Other reason-Autre raison"
                                  data-gc-analytics-collect="notPrivate">
                                Other reason
                              </label>
                            </div>
                          </fieldset>
                          <label for="problem6" class="mrgn-bttm-0">Please provide more details</label>
                          <p class="small">
                            <strong>You will not receive a reply. Don't include personal information (telephone, email, SIN, financial, medical, or work details).</strong>
                            <br>
                            <span class="small">Maximum 300 characters</span>
                          </p>
                          <textarea id="problem6" name="details" class="full-width" maxlength="300"></textarea>
                          <button type="submit" value="No" class="btn btn-primary mrgn-tp-md mrgn-bttm-sm">Submit</button>
                        </div>
                      </form>
                      <div class="gc-pg-hlpfl-thnk hide">
                        <p class="h6 mrgn-tp-sm mrgn-bttm-sm"><span class="far fa-check-circle text-success mrgn-rght-sm"
                            aria-hidden="true"></span> Thank you for your feedback</p>
                      </div>
                    </div>
                  </section>
                </div>
                <div class="col-sm-3 col-sm-offset-1 col-lg-offset-3">
                  <div class="wb-share"
                    data-wb-share="{&quot;pnlId&quot;:&quot;pnlShrPg&quot;, &quot;lnkClass&quot;: &quot;btn btn-default btn-block mrgn-tp-md&quot;}">
                  </div>
                </div>
              </div>
              <!-- END PAGE FEEDBACK WIDGET -->
              
            <div class="row pagedetails">
            
            
               <div class="datemod col-xs-12 mrgn-tp-lg">
                  <dl id="wb-dtmd">
                     <dt>Date modified:</dt>
                     <dd><time property="dateModified">2018-12-19</time></dd>
                  </dl>
               </div>
            </div>
         </main>
         <footer id="wb-info">
            <div class="landscape">
               <nav class="container wb-navcurr">
                  <h2 class="wb-inv">About government</h2>
                  <ul class="list-unstyled colcount-sm-2 colcount-md-3">
                     <li><a href="https://www.canada.ca/en/contact.html">Contact us</a></li>
                     <li><a href="https://www.canada.ca/en/government/dept.html">Departments and agencies</a></li>
                     <li><a href="https://www.canada.ca/en/government/publicservice.html">Public service and military</a></li>
                     <li><a href="https://www.canada.ca/en/news.html">News</a></li>
                     <li><a href="https://www.canada.ca/en/government/system/laws.html">Treaties, laws and regulations</a></li>
                     <li><a href="https://www.canada.ca/en/transparency/reporting.html">Government-wide reporting</a></li>
                     <li><a href="https://pm.gc.ca/eng">Prime Minister</a></li>
                     <li><a href="https://www.canada.ca/en/government/system.html">How government works</a></li>
                     <li><a href="https://open.canada.ca/en/">Open government</a></li>
                  </ul>
               </nav>
            </div>
            <div class="brand">
               <div class="container">
                  <div class="row">
                     <nav class="col-md-9 col-lg-10 ftr-urlt-lnk">
                        <h2 class="wb-inv">About this site</h2>
                        <ul>
                           <li><a href="https://www.canada.ca/en/social.html">Social media</a></li>
                           <li><a href="https://www.canada.ca/en/mobile.html">Mobile applications</a></li>
                           <li><a href="https://www1.canada.ca/en/newsite.html">About Canada.ca</a></li>
                           <li><a href="https://www.canada.ca/en/transparency/terms.html">Terms and conditions</a></li>
                           <li><a href="https://www.canada.ca/en/transparency/privacy.html">Privacy</a></li>
                        </ul>
                     </nav>
                     <div class="col-xs-6 visible-sm visible-xs tofpg">
                        <a href="#wb-cont">Top of Page <span class="glyphicon glyphicon-chevron-up"></span></a>
                     </div>
                     <div class="col-xs-6 col-md-3 col-lg-2 text-right">
                        <img src="http://www.canada.ca/etc/designs/canada/wet-boew/assets/wmms-blk.svg" alt="Symbol of the Government of Canada">
                     </div>
                  </div>
               </div>
            </div>
         </footer>
         <!--[if gte IE 9 | !IE ]><!-->
         <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.js"></script>
         <!-- <script src="https://wet-boew.github.io/themes-dist/GCWeb/wet-boew/js/wet-boew.min.js"></script> -->
         <script src="../js/datalist.js"></script>
         <!--<![endif]-->
         <!--[if lt IE 9]>
         <script src="./wet-boew/js/ie8-wet-boew2.min.js"></script>
         <![endif]-->
         <script src="https://www.canada.ca/etc/designs/canada/wet-boew/js/theme.min.js"></script>
         <script>
            document.getElementById('submissionPage').value = location.href;
         </script>
      </body>
    </html>
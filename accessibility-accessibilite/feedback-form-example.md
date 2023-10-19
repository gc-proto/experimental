---
altLangPage: /accessibilite/formulaire-retroaction.html
breadcrumbs: false
dateModified: 2023-10-19
description: "Provide feedback on [Institution name]’s accessibility plan, barriers you have experienced, or any matter related to accessibility."
layout: form
nomenu: true
noReportProblem: true
nositesearch: true
share: false
title: "[Institution name]’s accessibility feedback form"
---
<h1 property="name" id="wb-cont" dir="ltr">Provide accessibility feedback to [Institution name]</h1>
<div class="row mrgn-tp-lg">
  <div class="col-md-8">
    <p>Provide feedback on [Institution name]’s accessibility plan, barriers you have experienced, or any matter related to accessibility.</p>
    <p>You can consult the <a href="feedback-process.html">Accessibility feedback process</a> for other ways to provide feedback and how we use your feedback.</p>
    <details class="mrgn-tp-lg">
      <summary>Privacy disclaimer</summary>
      <div class="row mrgn-tp-lg">
        <div class="col-md-12">
          <p>[Include your institution’s privacy disclaimer.]</p>
          <h2>[Privacy disclaimer sample]</h2>
          <p>The collection of personal information is authorized by section 7(1)(a) and Section 70 of the <em>Accessible 
            Canada Act</em>.  This personal information is collected by the [Accessibility office or coordinator] to comply with the <em>Accessible Canada Act</em> by creating a mechanism to collect feedback and be able to respond back to the individual 
            and acknowledge that their feedback has been collected and how it was handled.</p>
          <p>Collection and use of this personal information is in accordance 
            with the <em>Privacy Act</em>. The mechanism is used to collect feedback 
            internally and externally on our Accessibility Plan, 
            future progress reports, as well as accessibility and barriers to accessibility within the work carried out in each 
            department.</p>
          <p>The personal information collected is described in Personal Information Bank PSU 938 – 
            Outreach Activities and will be retained for 7 years. Under the <em>Privacy Act</em> you have the right of access to, and correction of, your personal 
            information. To exercise either of these rights, contact [Institution name]’s ATIP Coordinator. If 
            you are not satisfied with Canadian Heritage’s response to your privacy concern, you may wish 
            to Contact the Office of the Privacy Commissioner of Canada.</p>
          <h2 class="h3">Contact information</h2>
          <ul class="mrgn-tp-lg">
            <li>[Institution name]’s ATIP Coordinator</li>
            <li><a href="https://www.priv.gc.ca/en/contact-the-opc/">Contact the Office of the Privacy Commissioner of Canada</a></li>
          </ul>
          <h2 class="h3">References</h2>
          <ul class="mrgn-tp-lg">
            <li><a href="https://www.laws-lois.justice.gc.ca/eng/acts/A-0.6/page-1.html">Accessible Canada Act</a>
              <ul>
                <li><a href="https://www.laws-lois.justice.gc.ca/eng/acts/A-0.6/page-1.html#h-1153444">section 7(1)(a)</a></li>
                <li><a href="https://www.laws-lois.justice.gc.ca/eng/acts/A-0.6/page-5.html#h-1154040">Section 70</a></li>
              </ul>
            </li>
            <li><a href="https://laws-lois.justice.gc.ca/ENG/ACTS/P-21/index.html">Privacy Act</a></li>
            <li><a href="https://www.canada.ca/en/treasury-board-secretariat/services/access-information-privacy/access-information/information-about-programs-information-holdings/standard-personal-information-banks.html#psu938">Personal Information Bank PSU 938 – Outreach Activities</a></li>
          </ul>
        </div>
      </div>
    </details>
  </div>
</div>
<div class="row mrgn-tp-lg">
  <div class="col-md-8">
    <div class="wb-frmvld">
      <form id="accessibility_feedback">
        <div class="wb-fieldflow gc-font-2019" data-wb-fieldflow='{"noForm": true, "renderas":"radio", "gcChckbxrdio":true}'>
          <p>1. What do you want to provide feedback on?</p>
          <ul>
            <li data-wb-fieldflow='{"action": "query", "name": "feedback_type", "value": "feedback_type1"}'>Accessibility barrier</li>
            <li data-wb-fieldflow='{"action": "query", "name": "feedback_type", "value": "feedback_type2"}' >[Institution name]'s Accessibility Plan</li>
            <li data-wb-fieldflow='[
                                {"action": "toggle", "toggle": "#feedback_type_other", "live":true },
                                {"action": "query", "name": "feedback_type", "value": "feedback_type3" }
                               ]'>Other item</li>
          </ul>
        </div>
        <div id="feedback_type_other" class="hidden">
          <div class="form-group">
            <label for="feedback_type3_desc"><span class="field-name gc-font-2019">Describe the item you want to provide feedback on</span></label>
            <input class="form-control full-width input-lg" id="feedback_type3_desc" name="feedback_type3_desc" type="text" />
          </div>
        </div>
        <div class="wb-fieldflow gc-font-2019" data-wb-fieldflow='{"noForm": true, "noreqlabel": true, "renderas":"checkbox", "gcChckbxrdio":true}'>
          <p>2. Select all the areas that are relevant to your comments</p>
          <ul>
            <li data-wb-fieldflow='{"action": "query", "name": "areas", "value": "areas4"}'>Physical environment (door knob, ramp, elevator, etc.)</li>
            <li data-wb-fieldflow='{"action": "query", "name": "areas", "value": "areas5"}'>Employment (recruitment processes, etc.)</li>
            <li data-wb-fieldflow='{"action": "query", "name": "areas", "value": "areas6"}'>Technology (websites, software applications, etc.)</li>
            <li data-wb-fieldflow='{"action": "query", "name": "areas", "value": "areas7"}'>Attitude (biases, micro aggressions, related to my mental health, etc.)</li>
            <li data-wb-fieldflow='{"action": "query", "name": "areas", "value": "areas8"}'>Information and communication (forms, plain language, bilingualism, etc.)</li>
            <li data-wb-fieldflow='{"action": "query", "name": "areas", "value": "areas9"}'>Systemic exclusion (events, policies, procedures, etc.)</li>
            <li data-wb-fieldflow='{"action": "query", "name": "areas", "value": "areas10"}'>Procurement (bidding for contracts, etc.)</li>
            <li data-wb-fieldflow='[
                                {"action": "toggle", "toggle": "#area_other", "live": true},
                                {"action": "query", "name": "areas", "value": "areas11"}
                                ]'>Other area</li>
          </ul>
        </div>
        <div id="area_other" class="hidden">
          <div class="form-group">
            <label for="areas_desc"><span class="field-name gc-font-2019">Describe the area you want to provide feedback on</span></label>
            <input class="form-control full-width input-lg" id="areas_desc" name="areas_desc" type="text" />
          </div>
        </div>
        <div class="form-group mrgn-tp-lg">
          <label for="description" class="required"><span class="field-name gc-font-2019">3. Describe the issue and provide comments. <strong class="required">(required)</strong></span></label>
          <p>Do not include information that could identify a person.</p>
          <textarea class="form-control required full-width" rows="10" id="description"></textarea>
        </div>
        <div class="mrgn-tp-lg">
          <div class="wb-fieldflow gc-font-2019" data-wb-fieldflow='{"noForm": true, "renderas":"radio", "gcChckbxrdio":true}'>
            <p>4.  Do you want us to contact you about your feedback? </p>
            <ul>
              <li data-wb-fieldflow='{"action": "query", "name": "feedback_type", "value": "feedback_type1"}'>No</li>
              <li data-wb-fieldflow='[
                                {"action": "toggle", "toggle": "#email_request_other", "live":true },
                                {"action": "query", "name": "feedback_type", "value": "feedback_type3" }
                               ]'>Yes, I’m comfortable providing my email address for contact purposes only.</li>
            </ul>
          </div>
          <div id="email_request_other" class="hidden">
            <div class="form-group">
              <label for="email1"><span class="field-name gc-font-2019">Email address</span> (yourname@domain.com)</label>
              <p>Your email address will only be used to contact you.  It will not be shared.</p>
              <div class="row">
                <div class="col-md-8">
                  <input class="form-control input-lg full-width" id="email1" name="email1" type="email" autocomplete="email" />
                </div>
              </div>
              <div class="clearfix"></div>
            </div>
          </div>
        </div>
      </form>
    </div>
    <div class="mrgn-tp-xl">
      <ul class="list-inline">
        <li>
          <input class="btn btn-primary btn-lg mrgn-bttm-md" type="submit" value="Submit feedback">
        </li>
        <li><a href="afeedback-04-01-en.html" type="button" class="btn btn-link btn-lg">Cancel</a></li>
      </ul>
    </div>
  </div>
</div>
<div class="clearfix"></div>

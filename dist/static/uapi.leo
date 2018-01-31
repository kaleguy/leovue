<?xml version="1.0" encoding="utf-8"?>
<!-- Created by Leo: http://leoeditor.com/leo_toc.html -->
<leo_file xmlns:leo="http://leoeditor.com/namespaces/leo-python-editor/1.1" >
<leo_header file_format="2" tnodes="0" max_tnode_index="0" clone_windows="0"/>
<globals body_outline_ratio="0.5" body_secondary_ratio="0.5">
	<global_window_position top="50" left="50" height="500" width="700"/>
	<global_log_window_position top="0" left="0" height="0" width="0"/>
</globals>
<preferences/>
<find_panel_settings/>
<vnodes>
<v t="josephorr.20180129170337.1"><vh>About these docs</vh></v>
<v t="josephorr.20180122132057.1" a="E"><vh>Installation</vh>
<v t="josephorr.20180116174541.1"><vh>[README](README.md)</vh></v>
</v>
<v t="josephorr.20180119152548.1" a="E"><vh>Reference Data Endpoints</vh>
<v t="josephorr.20180119152558.1"><vh>[Swagger Docs](http://localhost:9000/api-docs)</vh></v>
</v>
<v t="josephorr.20180103114444.2" a="E"><vh>Integration</vh>
<v t="josephorr.20180129170754.1"><vh>The Current Integration</vh>
<v t="josephorr.20180124164201.1"><vh>[Swagger UI](http://localhost:9000/api-intdocs)</vh></v>
<v t="josephorr.20180126175608.1"><vh>[Integration README](integration/README.md)</vh></v>
</v>
<v t="josephorr.20180116175436.1"><vh>The iw module</vh>
<v t="josephorr.20180103114545.1"><vh>[JSDocs](integration/iw-lib.md)</vh></v>
</v>
<v t="josephorr.20180119140518.1"><vh>Generic Reports</vh>
<v t="josephorr.20180119140525.1"><vh>[QA Fails](http://localhost:9000/uapi/iw/qa/fail)</vh></v>
<v t="josephorr.20180119151339.1"><vh>[Submitted](http://localhost:9000/uapi/iw/report/print)</vh></v>
<v t="josephorr.20180119151530.1"><vh>[Submitted/QA](http://localhost:9000/uapi/iw/report/qa)</vh></v>
</v>
<v t="josephorr.20180130172032.1" a="E"><vh>What an integration does</vh>
<v t="josephorr.20180130172304.1" a="E"><vh>&lt;&lt; The structure of submission info &gt;&gt;</vh>
<v t="josephorr.20180130173100.1"><vh>&lt;&lt; stages &gt;&gt;</vh></v>
</v>
</v>
<v t="josephorr.20180129172033.1" a="E"><vh>Creating a new Integration</vh>
<v t="josephorr.20180129173319.1"><vh>&lt;&lt; The folder structure of a customization &gt;&gt;</vh></v>
<v t="josephorr.20180129174427.1"><vh>&lt;&lt; Creating a new Save endpoint &gt;&gt;</vh></v>
<v t="josephorr.20180129175827.1" a="E"><vh>&lt;&lt; The folder structure of a new Save endpoint &gt;&gt;</vh>
<v t="josephorr.20180130124058.1"><vh>&lt;&lt; conf.es6 &gt;&gt;</vh></v>
<v t="josephorr.20180130131822.1"><vh>&lt;&lt; index.es6 &gt;&gt;</vh>
<v t="josephorr.20180130133150.1"><vh>&lt;&lt; Example createWorkflow &gt;&gt;</vh></v>
<v t="josephorr.20180130135411.1"><vh>&lt;&lt; Workflow stage functions &gt;&gt;</vh>
<v t="josephorr.20180130133116.1"><vh>&lt;&lt; An Example Stage Function &gt;&gt;</vh></v>
</v>
</v>
<v t="josephorr.20180130170150.1" a="E"><vh>&lt;&lt; the xsl folder &gt;&gt;</vh>
<v t="josephorr.20180130180418.1"><vh>&lt;&lt; the data section &gt;&gt;</vh></v>
</v>
</v>
</v>
</v>
</vnodes>
<tnodes>
<t tx="josephorr.20180103114444.2">@language md

Integration consists of creating an endpoint that takes an Unqork submission id and sends the corresponding submission data to the customer's system. 

The integration endpoint is created via the iw (integration-workflow) module.

The iw module is in the master repo. Integration code specific to a customer is in the customer repo.



</t>
<t tx="josephorr.20180103114545.1"></t>
<t tx="josephorr.20180116174541.1"></t>
<t tx="josephorr.20180116175436.1">@language md

The iw module contains functions used for creating integration workflows.

The functions of the iw module are documented in the JSDocs. The particular functions used in creating a single integration endpoint are documented in the following sections. 
</t>
<t tx="josephorr.20180119140518.1">@language md

The integration module provides several generic reports even if no custom integration endpoint has been set up.

* QA Fails: shows submissions which have been marked as complete but have not been submitted to the customer.
* Submitted: shows submissions which have been submitted to the customer.
* Submitted/QA: same as submitted, but with a QA link, allows the user to mark the submission as QA reviewed.

The QA link saves the user info into the submissionInfo/qa key. Any parameters passed in as a url query string will also get saved.

For example, iw/qa/save?reviewed=true will result in the following key.

```
qa: {
  user: username,
  reviewed: true
}
```</t>
<t tx="josephorr.20180119140525.1"></t>
<t tx="josephorr.20180119151339.1"></t>
<t tx="josephorr.20180119151530.1"></t>
<t tx="josephorr.20180119152548.1">@language md

Reference data endpoints are external endpoints, e.g. Edmonds Auto Service that return data to Unqork. These endpoints are created by:

1. Making an entry in the referenceData table.
2. Making an entry in the src/services/formioapp/targets.yaml file.
3. Making an entry in one of the client customization targets files, see the client-libertymutual repo for an example.

Entries in any of above case get Swagger docs created automatically.

The source that reads the above entries and creates the endpoints is in src/api/unqork</t>
<t tx="josephorr.20180119152558.1"></t>
<t tx="josephorr.20180122132057.1">@language md

The Unqork-API can be run via Docker by using the unqork-dev repo.

The following section displays the README.md file for standalone mode.</t>
<t tx="josephorr.20180124164201.1"></t>
<t tx="josephorr.20180126175608.1"></t>
<t tx="josephorr.20180129170337.1">@language md

This documentation consists of:

* Markdown files generated from JSDocs in the source files.
* An outline file (docs.leo) created with the Leo Outlining Editor.
* Links to all Swagger docs. The Unqork-API server must be running in local mode for the Swagger docs to display.

The index.html file in the docs folder loads all of the Markdown files into the outline and displays in the browser.

To regenerate the Markdown, run:

```
npm run docs
```</t>
<t tx="josephorr.20180129170754.1">@language md

Integrations are stored in client repos, e.g. client-libertymutual.

There is a script to copy from a client repo and regenerate documentation.
Run this script with then name of the client repo to copy client customizations
into your working repo. The files are copied into the src/api/integrations folder,
which is listed in gitignore, so you can safely test these files in your local
work area without having them committed to git.

```
./integration.sh libertymutual.
```

If you run the above command and the client has endpoints and documentation, it will show up in this section.

[[Swagger UI]]: Swagger docs for the customized endpoints. This also includes the generic iw endpoints.

[[Integration README]]: Markdown docs for the customized endpoints.</t>
<t tx="josephorr.20180129172033.1">@language md

An integration is created in a customer repo. An example is in the client-libertymutual repo.

&lt;&lt; The folder structure of a customization &gt;&gt;
&lt;br&gt;
&lt;&lt; Creating a new Save endpoint &gt;&gt;
&lt;br&gt;
&lt;&lt; The folder structure of a new Save endpoint &gt;&gt;



</t>
<t tx="josephorr.20180129173319.1">@language md

```
src/
├─ integration/
│  ├─ reports/
│  └─ save/
├─ README.md
├─ routes.es6
├─ targets.yaml
├─ targets.prod.yaml
└─ soap-endpoints.yaml
```

The README.md and routes.es6 files are required, the others are optional.

The **reports** and **save** folders can be named otherwise, as long as they match what is the routes.es6 file.

The reports and save folders contain code for implementing endpoints. Additional endpoints/folders can be added as long as specified in routes.es6.

The yaml files are for adding additional reference data endpoints, beyond those in the referenceData collection in mongo.</t>
<t tx="josephorr.20180129174427.1">@language md

Endpoints are registered in the routes.es6 file init function. Typically, this will look like this:

```
  router.use('/uapi/save', save)
```

The above endpoint will then be in the integration/save folder.</t>
<t tx="josephorr.20180129175827.1">@language md

```
save/
├─ examples/
│  ├─ {example.xml}
│  └─ {example.json}
├─ xsl/
│  ├─ {message-type-1}/
│  │  ├─ request.xsl
│  │  └─ response.xsl
│  └─ {message-type-2}
│     ├─ request.xsl
│     └─ response.xsl
├─ conf.es6
└─ index.es6
```

&lt;&lt; conf.es6 &gt;&gt;
&lt;br&gt;
&lt;&lt; index.es6 &gt;&gt;
&lt;br&gt;
&lt;&lt; the xsl folder &gt;&gt;

 

</t>
<t tx="josephorr.20180130124058.1">@language md

The iw module is passed a workflow and a set of xsl files. This is where you set up object that will hold the xsl, that will be passed to iw.

You'll generally only need to edit this section:

```
const msgTypes = [
  'W6', // MILS CREAR
  'W6b', // MILS CONSULTAR
  'W7', // Submission to IAxis
  'W9' // Put docs in IAxis
]
```

The above array corresponds to the subfolders of the xsl folder, discussed in a later section.</t>
<t tx="josephorr.20180130131822.1">@language md

You'll generally a new integration by copying this file from an existing integration.

Main points:

* Import xsl info from the conf file and instantiate iw:

    ```
    const iw = iwf(url, xsl, TOKEN)
    
    ```
    
* Integrations may have one or more stages (e.g., submit for inspection, send submission, send documents). Create a function for each stage. 

  &lt;&lt; Workflow stage functions &gt;&gt;

* Create a workflow from the stage functions.

  &lt;&lt; Example createWorkflow &gt;&gt;

Once you have done the above, you can add the save routes via:

```
iw.addRoutes(router, createWorkflow)
```
</t>
<t tx="josephorr.20180130133116.1">@language javascript
function submitApplication (d) {
  
  // d.complete may have been added by a previous message's response via xsl.
  console.log('In W7 call, skip:', d.complete)
  if (d.complete === 'true') { return Promise.resolve(d) } 
  
  // in this case we are checking to see if the "policyNumber" for this
  // stage has been set, and if so, it means this stage has already been
  // called and we will skip. This is particular to this customization.
  const latest = _.get(d, 'data.submissionInfo.stages.submit.latest')
  if (latest) {
    let policyNumber = _.get(d, 'data.submissionInfo.stages.submit.' + latest).policyNumber
    let cpc = _.get(d, 'data.submissionInfo.stages.submit.' + latest).codigoProcesoCargue
    // already have a policy number so skip this stage
    if (policyNumber &amp;&amp; cpc) {
      d.report.W7 = { status: 'skipped' }
      d.complete = true
      return Promise.resolve(d)
    }
  }
  
  // if we got here, we're going to go ahead and send the message appropriate for this
  // stage.
  return iw.sendMsg(d, 'W7')
}</t>
<t tx="josephorr.20180130133150.1">@language javascript
/**
* This is an example workflow function, that will be passed to 
* the iw module to create the save and bulksave endpoints.
*
* It is passed an observable by the iw module that contains an 
* object that contains the submission data. This object
* is then passed along to each worflow function.
*/
function createWorkflow (obs) {
  return obs
    .switchMap(registerForInspection)
    .switchMap(submitApplication)
    .switchMap(submitDocuments)
    .switchMap(d =&gt; iw.postProcess(d, postProcess))
}</t>
<t tx="josephorr.20180130135411.1">@language md

Workflow functions generally correspond to one endpoint call in the integration process. For example, one endpoint might be to schedule a car inspection.
 
Workflow functions receive a single object with the following properties:

-data: contains the complete json submission data from mongo
-xml: same as data but converted to xml
-report: contains an object that workflow functions can add properties to.

Workflow functions can add properties to the 'd' object, which can then be read by later workflow functions. 

In addition, as the 'd' object passes along through workflow functions, xsl response templates can add new properties under data.submissionInfo or at the root of 'd'. 

For more about this, see the section on the xsl folder.

&lt;&lt; An Example Stage Function &gt;&gt;


</t>
<t tx="josephorr.20180130170150.1">@language md

The xsl folder contains subfolders, one per message type.

Each message type has a request.xsl and a response.xsl. 

The request.xsl takes d.xml as input (see previous sections for an explanation of d.xml), and transforms it into the xml message that the target endpoint expects.

The response.xsl takes the xml returned by the target service and transforms it into xml with three sections:


- **data**
- **control**
- **originalMessage**

The originalMessage section copies the full original return message.

&lt;&lt; the data section &gt;&gt;
</t>
<t tx="josephorr.20180130172032.1">@language md

An integration does two things:

1. Get a submission into a target system.
2. Save data about this submission process back into the original submission, under a key called **submissionInfo**.

The submissionInfo key is created almost immediately when a submission endpoint is called, so if this key is missing it means that the form has not been sent to the integration. 

&lt;&lt; The structure of submission info &gt;&gt;
</t>
<t tx="josephorr.20180130172304.1">@language md

**messages:** an object containing every message ever received by the submission endpoint. The keys in this object take the form of 'd' + unix timestamp + '_m' + messageType.

**lastMessage:** the key to the last message that was received.

**stages:** data reflecting the state of each stage.

More about stages:

&lt;&lt; stages &gt;&gt;

</t>
<t tx="josephorr.20180130173100.1">@language md 

Example of how the stages object might look after two stages named "submit" and "aux" are called:

```
"aux": {
  "d2017_12_06_07_25_53": {
    "status": "0"
  },
  "d2017_12_06_07_25_52": {
    "status": "0"
  },
  "status": "0",
  "latest": "d2017_12_06_07_25_53"
},
"submit": {
    "d2017_12_06_07_25_51": {
      "fault": "",
      "appStatus": "issued",
      "status": "0",
      "policyNumber": "7001878"
    },
   "d2017_12_06_07_25_50": {
     "fault": "",
     "appStatus": "issued",
     "status": "0",
     "policyNumber": "7001878"
    },
   "status": "0",
   "latest": "d2017_12_06_07_25_51"
}
```

All of the information in the stages object is a representation of information in one or more messages, so this is in effect duplicate data. It is put into this form by the integration module for more convenient access.

The particular information in each stage is the result of response.xsl template transforming data returning from the endpoint corresponding to the stage. For more information about how the xsl file works, see &lt;&lt; the xsl folder &gt;&gt; section.</t>
<t tx="josephorr.20180130180418.1">@language md

A typical data section:

```
  &lt;data&gt;
    &lt;key&gt;submit&lt;/key&gt;
    &lt;fault&gt;&lt;xsl:value-of select="//faultcode"/&gt;&lt;/fault&gt;
    &lt;items&gt;
      &lt;policyNumber&gt;&lt;xsl:value-of select="//emisionPoliza/numeroPoliza"/&gt;&lt;/policyNumber&gt;
      &lt;status&gt;&lt;xsl:value-of select="//infoResponse/estado/codigoEstado"/&gt;&lt;/status&gt;
      &lt;statusDescr&gt;&lt;xsl:value-of select="//infoResponse/estado/descripcionEstado"/&gt;&lt;/statusDescr&gt;
      &lt;appStatus&gt;
        &lt;xsl:choose&gt;
          &lt;xsl:when test="//infoResponse/estado/codigoEstado = 0"&gt;issued&lt;/xsl:when&gt;
          &lt;xsl:otherwise&gt;rejected&lt;/xsl:otherwise&gt;
        &lt;/xsl:choose&gt;
      &lt;/appStatus&gt;
      &lt;fault&gt;&lt;xsl:value-of select="//faultcode"/&gt;&lt;/fault&gt;
    &lt;/items&gt;
  &lt;/data&gt;
```

This will result in a submit stage object saved into submissionInfo looking something like this:

```
submit: {
  status: 0,
  latest: d2017_12_06_07_25_53,
  d2017_12_06_07_25_53: {
    policyNumber: 12345
    status: "OK"
    statusDescr: "It's OK"
    appStatus: issued
    fault: ""
  }
}
```

In other words, everything listed under data/items ends up in the stage d{timestamp} key. Two top level keys are also updated: 

* **latest:** this will be the updated to the lastest message key (d{timestamp}
* **status:** this will be the same value as the status of the latest message</t>
</tnodes>
</leo_file>

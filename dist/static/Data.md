# Data and Metadata in Leo/LeoVue

## Data

When you create an outline to be displayed in LeoVue, node content can 
be JSON data. 

For example, here is some JSON data in a Leo Node. Note that there 
is a 'template' property.

<img src="images/leo-json.png" alt="alt text" width="700">
<div class="hshim"></div>

When viewed in LeoVue, the data from the node is displayed with 
the corresponding template. (Templates are lodash templates, and can 
be put in your index.html file. See the LeoVue repo for examples.)

<img src="images/leovue-json.png" alt="alt text" width="700">
<div class="hshim"></div>

You can give data nodes names with the @dataset directive:

<img src="images/leo-dataset.png" alt="alt text" width="700">
<div class="hshim"></div>

In another node, you can then add a Vue.js component that 
uses the dataset:

<img src="images/leo-dataset-chart.png" alt="alt text" width="700">
<div class="hshim"></div>

LeoVue renders the Vue.js component:

<img src="images/leovue-dataset-chart.png" alt="alt text" width="700">
<div class="hshim"></div>

If you have a set of data nodes, as in the screenshot below, you can add then @group directive:

<img src="images/leo-group.png" alt="alt text" width="700">
<div class="hshim"></div>

The @group directive creates an array of JSON data. You can use the summary-table component:

<img src="images/leo-summary.png" alt="alt text" width="700">
<div class="hshim"></div>

to display a tabular summary:

<img src="images/leovue-summary.png" alt="alt text" width="700">
<div class="hshim"></div>


## Metadata

Regular content nodes can also have metadata (in YAML) using the 
@m directive:

<img src="images/leo-metadata.png" alt="alt text" width="700">
<div class="hshim"></div>

LeoVue does not display the @metadata:

<img src="images/leovue-metadata.png" alt="alt text" width="700">
<div class="hshim"></div>

However, behind the scenes Leo attaches the metadata to the node 
object. You access the metadata by creating a metadata group 
with the @mgroup directive:

<img src="images/leovue-mgroup.png" alt="alt text" width="700">
<div class="hshim"></div>

The @mgroup directive creates an array of metadata items that 
can be used just like any other JSON data:

<img src="images/leo-mgroup-summary.png" alt="alt text" width="700">
<div class="hshim"></div>

displays in LeoVue as:

<img src="images/leovue-mgroup-summary.png" alt="alt text" width="700">
<div class="hshim"></div>


## Tags

The @t directive is similar to the @m directive, except that 
instead of JSON or YAML, what follows the @t directive is a simple 
list of tags:

<img src="images/leo-tag.png" alt="alt text" width="700">
<div class="hshim"></div>

Tags can be used with the &lt;tagsearch/&gt; directive:

<img src="images/leo-tagsearch.png" alt="alt text" width="700">
<div class="hshim"></div>

The tagsearch component displayed in LeoVue:

<img src="images/leovue-tagsearch.png" alt="alt text" width="700">
<div class="hshim"></div>




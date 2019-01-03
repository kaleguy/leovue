# LeoVue - Leo - LeoVue

You can use LeoVue to import content into Leo, edit in Leo, and then display again in LeoVue.

## JSON Nodes

A node with the following format will load JSON from the given url. 

```
@json [Title](url)
```

For example, if you have a Leo file with the following node title:

```
@json [Math Book](https://openlibrary.org/api/books?format=json&jscmd=data&bibkeys=ISBN:0201558025)
```

And in the content of the Leo node, you specify a template and optionally more key-value pairs, for example:

```
template: openbooks
comments: This is a math book. It was on the Openlibrary site.
```

Then, when the file is viewed with LeoVue and the user clicks on the node, the JSON at the above URL will be retrieved by LeoVue, then applied to the 'openbooks' template, with the resulting formatted content displayed in the node content pane.

A note about templates, these are lodash templates and can be placed in your index.html file. The id of the template is the name of the template. For examples, see the index.html file at the LeoVue Github repo.

## Export to Leo Format

As described in the previous section, when you click on a JSON node in LeoVue, LeoVue downloads the JSON at the URL. LeoVue stores this JSON along with the template name and any other values found in the original Leo file. It stores the raw JSON, not the formatted HTML.

If you open the side menu, you can see a link for 'Download Node Data'. This allows you to download the data in the current node. 

If you haven't clicked on any JSON nodes and therefore have not loaded in any JSON data, when you export a node you just get the same data in the original file. 

However, if you have clicked on a JSON node, the file you export will new data in it. In this way you can use LeoVue to load data into a Leo file that you can then open in Leo for further organization.

## An Example: ResearchGate

The [Scraper-API](https://github.com/kaleguy/scraper-api) project can be used to extract JSON data from ResearchGate, a site for scientific research papers.

You can extract JSON for a single article or for a list of articles.

If the JSON you are retrieving is an array of items, then you can tell LeoVue to create child nodes for these items.

For example if you have a node in your Leo file like this:

```
@json [Research of Jordan Peterson](http://localhost:8888/rg/articles?name=Jordan_Peterson2)
```

Combined with this node content:

```
template: rgarticles
nodeList: 
  listKey: articles
  template: rgarticle-brief
```

The JSON that will be downloaded from URL above should look something [like this](https://cdn.jsdelivr.net/npm/leo-vue@1.18.1/static/articles-Jordan_Peterson2.json). 

Here's a view of a Leo file with a node like the one above (with a couple of extra params in the content node):

<img src="images/json-list-leo.png" alt="alt text" width="700">

When you click on the node in LeoVue, LeoVue will retrieve the JSON for the given URL, which has an array of articles. It will create a child node for each article like this:

<img src="images/json-list-leovue.png" alt="alt text" width="700">

You can select a node and download a Leo file for that node:

<img src="images/json-list-dl.png" alt="alt text" width="700">

If you download the Leo file for the node starting at 'Research of Jordan Peterson' as in this example you will see that the downloaded Leo file has new nodes below the original node:

<img src="images/json-list-leo2.png" alt="alt text" width="700">

Note that the child nodes have a @dataSet directive. Directives in hidden in LeoVue, so you don't see this in the title in LeoVue.

Behind the scenes LeoVue has created a new dataSet node for each array item instead of creating a regular content node. This is so that components elsewhere in the Leo file can refer to this dataSet. For an example of this read on...

## More JSON Options

In the example above, a single JSON directive on a node will result in a set of child nodes when displayed with LeoVue. This is because the 'nodeList' parameter has been specified.

```
nodeList: 
  listKey: articles
  template: rgarticle-brief
```

* **listKey**: the key in the JSON data that is pointing to the array of items
* **template**: The template to use to display an item

In this case, LeoVue will construct a set of child nodes from the JSON data array, and each node will get as content a single item from the data array.

You can also tell LeoVue not to create datasets with node content but to instead create more JSON nodes:



<img src="images/json-list-jbp.png" alt="alt text" width="700">

In the above image we've created a Leo file with a similar JSON node as above, but with a url pointing to a static file.  

If you view this in LeoVue and then download the Leo file from LeoVue, you end up with a different result than above:

<img src="images/json-list-jbp2.png" alt="alt text" width="700">

The child nodes are not dataSets, rather they are new JSON nodes. This is because the 'urlTitle' param has been specified.

```
nodeList: 
  listKey: articles
  template: rgarticle-brief
```

* **titleKey**: the key in the JSON data that is pointing to the array of items
* **hrefKey**: The key for the url of the item
* **hrefIsQueryString**: The template to use to display an item

==========xx

In the present case you can not only have LeoVue retrieve a list of nodes, you can additionally click on each retrieved node and get more JSON data for the given article.

The result will be a list of all of the articles, with JSON data for each article. You can then export this to a Leo file and use Leo's editing and clone features to organize the articles into multiple groups. 

Leo nodes have the benefits of both folders (hierarchical groups) and tags (more than one path to a content item). When you are done organizing your content with Leo, you can then view the newly edited Leo file with LeoVue.

An example of a Leo file created via this process:
[Research of Jordan B Peterson](https://kaleguy.github.io/leo-examples/peterson/#/t/1) 

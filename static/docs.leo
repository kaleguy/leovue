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
<v t="josephorr.20170228222411.2" a="E"><vh>Leo Viewer</vh>
<v t="josephorr.20170326174500.1" a="E"><vh>More About Leo</vh>
<v t="josephorr.20170331200243.1"><vh>Introduction</vh></v>
<v t="josephorr.20170327233137.1"><vh>[Feature Introduction](https://kaleguy.github.io/leo-tutorials/feature-introduction.md)</vh></v>
<v t="josephorr.20170327233223.1"><vh>[Chunking](https://kaleguy.github.io/leo-tutorials/chunking.md)</vh></v>
<v t="josephorr.20170327233236.1"><vh>Additional Features</vh></v>
<v t="josephorr.20170327233257.1"><vh>Installing Leo</vh></v>
</v>
<v t="josephorr.20170327233126.1" a="E"><vh>More About Leo Viewer</vh>
<v t="josephorr.20170331200439.1"><vh>Overview</vh></v>
<v t="josephorr.20170331200411.1"><vh>Installing</vh></v>
<v t="josephorr.20170421082838.1"><vh>Configuring</vh></v>
</v>
<v t="josephorr.20170326174511.1" a="E"><vh>Sample Content</vh>
<v t="josephorr.20170304174421.1"><vh>Text</vh>
<v t="josephorr.20170304174436.1"><vh>A Note About Something</vh></v>
</v>
<v t="josephorr.20170304173237.1"><vh>HTML</vh>
<v t="josephorr.20170304174041.1"><vh>Text and Photo</vh></v>
</v>
<v t="josephorr.20170304113011.1"><vh>Code</vh>
<v t="josephorr.20170304113024.1"><vh>Javascript</vh></v>
<v t="josephorr.20170304115429.1"><vh>Coffeescript</vh></v>
</v>
<v t="josephorr.20170304103722.1"><vh>Markdown</vh>
<v t="josephorr.20170304175209.1"><vh>Markdown In Leo</vh></v>
<v t="josephorr.20170304103726.1"><vh>A Markdown Section</vh></v>
<v t="josephorr.20170511084727.1"><vh>[Markdown from a file](example.md)</vh></v>
</v>
<v t="josephorr.20170326071708.1"><vh>Some Cloned Nodes</vh>
<v t="josephorr.20170304115429.1"></v>
<v t="josephorr.20170304175209.1"></v>
</v>
<v t="josephorr.20170511082833.1" a="E"><vh>Subtrees</vh>
<v t="josephorr.20170511083006.1"><vh>[Example](example.leo)</vh></v>
</v>
<v t="josephorr.20170326072340.1" a="E"><vh>File Nodes</vh>
<v t="josephorr.20170408092907.1"><vh>@clean ../src/services/leo.js</vh></v>
<v t="josephorr.20170328225527.1"><vh>@clean ../src/components/TreeViewer.vue</vh>
<v t="josephorr.20170328225654.1"><vh>&lt;&lt; template &gt;&gt;</vh></v>
<v t="josephorr.20170328225718.1"><vh>&lt;&lt; script &gt;&gt;</vh></v>
<v t="josephorr.20170328225741.1"><vh>&lt;&lt; style &gt;&gt;</vh></v>
</v>
</v>
<v t="josephorr.20170401144849.1" a="E"><vh>URL Nodes</vh>
<v t="josephorr.20170401114539.1"><vh>[A URL Node](https://kaleguy.github.io/simpleng2admin/#/home)</vh></v>
<v t="josephorr.20170327233137.1"></v>
</v>
</v>
</v>
</vnodes>
<tnodes>
<t tx="josephorr.20170228222411.2">@language html

&lt;div style="border:1px solid #fff; width:300px;margin-left:auto;margin-right:auto;"&gt;
&lt;svg id="Layer_1" data-name="Layer 1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 387 220"&gt;
&lt;defs&gt;
&lt;style&gt;
H1 {margin: 0}
.cls-1{font-size:122px;stroke:#000;stroke-width:14px;}
.cls-1,.cls-2{stroke-miterlimit:10;font-family:Verdana;} 
.cls-2{font-size:40px;fill:#f2f2f2;stroke:gray;}
.cls-3{letter-spacing:-0.02em;}
.cls-4{letter-spacing:-0.02em;}
&lt;/style&gt;
&lt;/defs&gt;
&lt;title&gt;leoviewer&lt;/title&gt;
&lt;text class="cls-1" transform="translate(25 156.2)"&gt;LEO&lt;/text&gt;
&lt;text class="cls-2" transform="translate(82 188)"&gt;viewer&lt;/text&gt;
&lt;/svg&gt;
&lt;/div&gt;

&lt;p&gt;
Leo Viewer is a web app that can display files created with 
&lt;a href='http://www.leoeditor.com'&gt;Leo&lt;/a&gt;, the open source outlining editor and IDE.
&lt;/p&gt;
&lt;p&gt;
Leo has features that make it particularly suitable for documenting code and other complex documents.
&lt;/p&gt;
&lt;p&gt;
Using Leo, you can create an outlined document like the one you are viewing. Content nodes can contain
text, html, markdown or code. Content nodes can also point to other documents or websites.
&lt;p&gt;
Using Leo Viewer, users can view your document as a normal webpage without having to install Leo.
&lt;/p&gt;
 </t>
<t tx="josephorr.20170304103722.1">Content items in Leo outlines can be Markdown.

To mark content as Markdown, put the following in the first line of the node content:

@language md

When Leo Viewer encounters a node with @language md as the first line, it displays the (html) output, not the md source.
</t>
<t tx="josephorr.20170304103726.1">@language md

# A topic

This is fascinating.

## Another Topic

This one is less so.

### Fine Print

We would rather you not read this section.</t>
<t tx="josephorr.20170304113011.1">@language md

Content items in Leo outlines can be code.

To mark content as code, put the following in the first line of the node content:

&lt;span class='directive'&gt;@language languagename&lt;/span&gt;

for example:

&lt;span class='directive'&gt;@language javascript&lt;/span&gt;

When Leo Viewer encounters a node with a language directive as the first line, it displays formatted code, unless the language is 'html' or 'md' in which case Leo Viewer displays the output view, not the source.
</t>
<t tx="josephorr.20170304113024.1">@language javascript

function getLanguage(text){
   var language = '';
   var re = /^@language (\w+)/;
   var languageTokens = re.exec(text);
   if (languageTokens){
       language = languageTokens[1];
       console.log(language);
   }
   return language;
}</t>
<t tx="josephorr.20170304115429.1">@language coffeescript

Client = require 'ftp'
async = require 'async'
remote_path ='/public_html/targetfolder/'
local_path = 'data/'
fs = require 'fs'

c = new Client()
c.on 'ready', ()-&gt;
  c.list remote_path, (err, list)-&gt;
    if (err) then console.error 'list', err
    file_funcs = (getFileFunc file.name for file in list)
    async.series file_funcs, ()-&gt; c.end()

getFileFunc = (name) -&gt;
  (callback)-&gt;
    if /csv$/.test name
      c.get remote_path + name, (err, stream)-&gt;
        console.log 'Getting ', name
        if err then console.log 'get', err
        stream.once 'close', callback
        stream.pipe fs.createWriteStream local_path + name
    else
      console.log "Skipping", name
      callback()

c.connect(
  host : 'ftp.targethost.com'
  user : 'username@domain.com'
  password : 'password'
)</t>
<t tx="josephorr.20170304173237.1">@language md

Content items in Leo outlines can be HTML.

To mark content as HTML, put the following in the first line of the node content:

&lt;span class='directive'&gt;@language html&lt;/span&gt;

When Leo Viewer encounters a node with @language html as the first line, it displays the html output, not the html source.
</t>
<t tx="josephorr.20170304174041.1">@language html

&lt;h1&gt;Bee And Flower&lt;/h1&gt;

An example of HTML content.

&lt;div&gt;
  &lt;p&gt;
    &lt;img src='https://upload.wikimedia.org/wikipedia/commons/5/5e/200x133px-Biene_auf_lavendel.png'&gt;
  &lt;/p&gt;
&lt;/div&gt;  </t>
<t tx="josephorr.20170304174421.1">Content items in Leo outlines can be plain text.</t>
<t tx="josephorr.20170304174436.1">This is just some regular text.

And now for some hipster ipsum:

Prism selvage farm-to-table, chillwave hexagon echo park tacos wayfarers shabby chic. Man braid chartreuse offal meggings. Messenger bag fap shabby chic blue bottle, typewriter la croix man braid chicharrones fashion axe mlkshk mustache narwhal. Single-origin coffee banh mi put a bird on it, lomo cred mumblecore schlitz flexitarian freegan retro. Edison bulb keytar single-origin coffee, direct trade plaid pug everyday carry ethical enamel pin. Viral neutra direct trade ramps semiotics intelligentsia, organic celiac food truck vice. Echo park PBR&amp;B iPhone trust fund dreamcatcher.</t>
<t tx="josephorr.20170304175209.1">@language md
## Leo Does Markdown

This node was writen with Markdown.

Use the @language md directive to set the node to markdown.</t>
<t tx="josephorr.20170326071708.1">Leo Nodes can be "cloned nodes". This means that they share the same content. 

The nodes in this branch are clones of nodes appearing elsewhere in this document.</t>
<t tx="josephorr.20170326072340.1">Leo Nodes can be @file nodes. This means that Leo keeps a link to an external file and will sync with any changes in the external file. </t>
<t tx="josephorr.20170326174500.1">This section contains a brief introduction to some of the features of Leo.</t>
<t tx="josephorr.20170326174511.1">@language html

&lt;h2&gt;Content Creation with Leo&lt;/h2&gt;

Using Leo, you can create an outline tree with various types of content. This subsection contains some examples of different content created in a Leo file and displayed with the Leo Viewer.</t>
<t tx="josephorr.20170327233126.1">This section contains a guide to using the Leo Viewer program to view files created in Leo.</t>
<t tx="josephorr.20170327233137.1"></t>
<t tx="josephorr.20170327233223.1"></t>
<t tx="josephorr.20170327233236.1">@language md

# Additional Features of Leo

Leo has more features than can be listed in a brief summary.

Some additional features include:

* IDE editing features in content pane
* Fully programmable, the Leo Outline is available to Python scripts running in Leo.
* Compose programs from Outlines
* Create unit tests automatically with @test and @suite scripts
* Import other outline formats</t>
<t tx="josephorr.20170327233257.1">@language md

# Installing Leo

To install on Windows, unzip the following file and run leoApp.exe from the unzipped folder.

[Leo 5.3](https://sourceforge.net/projects/leo/files/Leo/Quick%20Install/Leo_5.3-b1_Win.zip/download)

For other environments, see the:

[Installation page on the Leo Site](http://leoeditor.com/installing.html)</t>
<t tx="josephorr.20170328225527.1">&lt;&lt; template &gt;&gt;
&lt;&lt; script &gt;&gt;
&lt;&lt; style &gt;&gt;
</t>
<t tx="josephorr.20170328225654.1">@language xml
&lt;template&gt;
  &lt;div class="treeviewer"&gt;
    &lt;splitpane leftPaneStyle="width:360px"&gt;
      &lt;ul slot="left"&gt;
        &lt;div v-for="itemdata in data"&gt;
        &lt;item
          class="item"
          :model="itemdata"
          :top="top"
          :textItems="text"
          :targetEl="target.el"&gt;
        &lt;/item&gt;
        &lt;/div&gt;
      &lt;/ul&gt;
      &lt;contentpane slot="right"&gt;&lt;/contentpane&gt;
    &lt;/splitpane&gt;
  &lt;/div&gt;
&lt;/template&gt;
</t>
<t tx="josephorr.20170328225718.1">@language javascript

&lt;script&gt;
  import Item from './Item'
  import ContentPane from './ContentPane'
  import SplitPane from './SplitPane'

  let target = {el: true, v: null}
  export default {
    name: 'treeviewer',
    components: {
      item: Item,
      contentpane: ContentPane,
      splitpane: SplitPane
    },
    data: function () {
      return {
        target: target
      }
    },
    computed: {

      top () {
        // console.log(this.$store.state.leodata)
        if (this.$store.state.leodata.length &gt; 1) { return false }
        return true
      },
      data () {
        return this.$store.state.leodata
      },
      text () {
        return this.$store.state.leotext
      }
    }

  }
&lt;/script&gt;
</t>
<t tx="josephorr.20170328225741.1">@language css
&lt;!-- Add "scoped" attribute to limit CSS to this component only --&gt;
&lt;style scoped&gt;
  .treeviewer{
    height: 100%
  }
  ul {
    list-style-type: none;
    padding: 0;
    padding-left: 10px;
  }
&lt;/style&gt;
</t>
<t tx="josephorr.20170331200243.1">@language md

# About Leo

Leo is a unique text editor and IDE that facilitates a new way of looking at text documents, including code files.

The purpose of this document is to make a very brief introduction to creating tree based content with Leo and
displaying it with Leo Viewer. Leo has features that make it particularly suitable for creating 
documentation of code.

More advanced users of Leo are able to use Leo to practice a type of "Literate Programming", that is, a style of
programming where documentation comes first, and code is generated from the documentation or
is developed in tandem with it.</t>
<t tx="josephorr.20170331200411.1">@language md

# Installing and Using Leo Viewer

To use Leo Viewer, copy the files in the [dist folder at github](https://github.com/kaleguy/leoviewer) to your server. A web server is
required, you can't simply open Leo Viewer from your local file system. If you want to view
files on your local machine without a server, use a node utility like 'http-server'.

You will be able to open Leo Viewer by opening index.html in your browser. If you are not 
serving Leo Viewer from the root of your domain, you'll need to first edit the "base" tag in
index.html. 

About setting the base, for example, the file you are reading is 
hosted on Github Pages at https://kaleguy.github.io/leoviewer/.
So the base tag for the index.html for this installation of Leo Viewer looks like this:

`&lt;base href='/leoviewer/'&gt;`

You can also run Leo Viewer from github pages. Fork the repository on Github, 
then go to Settings - Github pages and choose 'master branch - docs folder'. The file 'docs.leo' in the docs/static folder will
be viewable at username.github.io/myforkname/. (But be sure to edit the base tag as described above). 

The leo file that Leo Viewer displays is located at 'static/docs.leo'. You can open this leo file using the Leo program and edit it,
or replace it with your own file. Currently the name of this file is not configurable, this feature will be added in the next release.

For a quick look at a Leo file, you can also drag and drop the file on to Leo Viewer.
</t>
<t tx="josephorr.20170331200439.1">@language md

# Leo Viewer

Leo Viewer is a web app that can display files created with 
&lt;a href='http://www.leoeditor.com'&gt;Leo&lt;/a&gt;, the open source outlining editor and IDE.

Using Leo, you can create outlined content. Using Leo Viewer you can display this
content as a web page.

The content you are reading was created in Leo. If you're reading this on the Leo Viewer
site, then this content is being displayed via the Leo Viewer.

Leo Viewer is currently at version 0.9.4 

Leo Viewer 0.9.x only is tested in Chrome and may not display correctly in other browsers.

Current features include:
* Display Leo content including markdown, html and code highlighting
* Bookmarkable nodes
* Node titles can be urls to markdown files
* Node titles can be urls to html pages
* Outline and Inline views
* Drag and drop a Leo file to display
* Graphic trees

Features planned for version 1:
* Left Nav collapse - expand
* Keyboard support
* Search
* Accordion Mode (close other nodes except ancestors)
* SEO version (static html files)
* Load Leo files into subtrees

Leo Viewer is an Open Source project. The code is licensed under the MIT license.</t>
<t tx="josephorr.20170401114539.1"></t>
<t tx="josephorr.20170401144849.1">You can create nodes that point to external sites.

To do this, create a node with a Markdown link in the title, for example:

[This is a link](http://www.example.com)

Leo Viewer will show the external site in the content pane.

The next node has the following title:

[A URL Node](https://kaleguy.github.io/simpleng2admin/#/home)

Note that if Leo Viewer is served via https (e.g. Github Pages) only https links will work here.

The second node in this section has the following title:

[Feature Introduction](https://kaleguy.github.io/leo-tutorials/feature-introduction.md)

This is a clone of one of the earlier nodes in this outline. In this case Leo Viewer fetches the document and 
converts it to HTML before displaying it.</t>
<t tx="josephorr.20170408092907.1">@language javascript
import escape from 'escape-html'
import axios from 'axios'

function loadDoc (filename) {
  var p = new Promise((resolve, reject) =&gt; {
    axios.get(filename)
      .then(function (response) {
        resolve(response.data)
      })
      .catch(function (error) {
        console.log(error)
        reject()
      })
  })
  return p
}
function cleanText(data, startId){
  data.name = data.name.replace(/&lt;&lt;/g, '\u00AB')
  data.name = data.name.replace(/&gt;&gt;/g, '\u00BB')
  data.name = data.name.replace(/'/g, '\x27')
  data.name = data.name.replace(/"/g, '\x22')
  //data.name = escape(data.name)
  data.name = data.name.replace(/&amp;#39;/g,'\x27')
  data.id = data.id + ''; // probably unneeded now
  let children = data.children;
  if (!children) { return }
  for (let i = 0; i &lt; children.length; i++){
    cleanText(children[i], startId)
  }
  data.t = data.t.replace(/^.*?_/,'')
  if (startId) {
    data.t = startId + '-' + data.t + ''
  }
}
function getLeoJSON (filename, id) {
  if (filename.indexOf('#') &gt; 0) {
    filename = filename.substring(0, filename.indexOf('#'))
  }
  var p = new Promise((resolve, reject) =&gt; {
    if (!filename.match(/static/)) {
      filename = '/static/' + filename
    }
    if (!filename.match(/\.leo$/)) {
      filename = filename + '.leo'
    }
    loadDoc(filename, 'Text')
      .then(xmlString =&gt; {
        resolve(transformLeoXML(xmlString, id))
      })
  })
  return p
}
function transformLeoXML (xmlString, startId) {
    const oParser = new DOMParser()
    const xml = oParser.parseFromString(xmlString, 'text/xml')
    const tnodes = xml.getElementsByTagName('t')
    let textItems = {}
    for (let i = 0; i &lt; tnodes.length; i++){
      let el = tnodes[i]
      let elText = el.textContent
      let a = el.getAttribute('tx')
      a = a.replace(/\./g,'_')
      a = a.replace(/^.*?_/,'')
      if (startId) {
        a = startId + '-' + a
      }
      if (
         (/^@language /.test(elText)) &amp;&amp;
         (!/^@language html/.test(elText)) &amp;&amp;
         (!/^@language md/.test(elText))
      ){
        // elText = escape(elText)
      }
      textItems[a] = elText
      // h
    }
    const vnodes = xml.getElementsByTagName('v')
    let pid
    for (let i = 0; i &lt; vnodes.length; i++) {
      pid = i + 1
      if (startId) {
        pid = startId + '-' + pid
      }
      vnodes[i].setAttribute('id', '"' +pid + '"')
    }
    var scripts = document.getElementsByTagName('script'),
        str     = '',
        i       = 0,
        il      = scripts.length;
    for (; i&lt;il; i++) {
      if (scripts[i].type === 'leo/xsl-template') str += scripts[i].innerHTML;
    }
    const xsl = oParser.parseFromString(str, 'text/xml')
    const xsltProcessor = new XSLTProcessor()
    xsltProcessor.importStylesheet(xsl)
    const resultDocument = xsltProcessor.transformToFragment(xml, document)
    let data = resultDocument.textContent
    data = data.replace(/,\s?$/, '') // kludge to get rid of trailing comma
    data = '[' + data + ']'
    data = JSON.parse(data)
    data.forEach(d =&gt; cleanText(d, startId))
    const xdata = {}
    xdata.data = data
    xdata.textItems = textItems
    return xdata
}

export {getLeoJSON, transformLeoXML}
</t>
<t tx="josephorr.20170421082838.1">@language md

# Basic Configuration Options

Leo loads static content from the 'static' folder. By default it will load a file named 'docs.leo'.

To tell Leo Viewer to load a different file, either pass a 'filename' parameter on the url, or edit the configuration section of index.html.

[Example of Leo File from URL parameter](/index.html?filename=examples/example)

Currently Available Parameters:
* filename: name of leo file to load (without .leo extension)
* doctitle: Title for the Leo file (will show in top menubar)
* showapptitle: Display 'Leoviewer' in upper left of app

Using parameters on the URL:

```
http://www.mysite.com/leoviewer?filename=example&amp;title=My Leo File&amp;showapptitle=false
```
</t>
<t tx="josephorr.20170511082833.1">@language md 

Leo Viewer can load .leo files into nodes in a parent .leo file.

The child node of this node has the following title:

```
[Example](example.leo)
```
Since the title points to a .leo file, the leo file is loaded into the node when the node is clicked.

The subtree isn't loaded until you click on the node, so outlines can contain many child outlines and still have fast page load.
</t>
<t tx="josephorr.20170511083006.1">The nodes below this one are loaded from another .leo file.</t>
<t tx="josephorr.20170511084727.1"></t>
</tnodes>
</leo_file>

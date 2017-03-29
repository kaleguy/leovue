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
<v t="josephorr.20170327233137.1"><vh>Short Intro</vh></v>
<v t="josephorr.20170327233223.1"><vh>Chunking</vh></v>
<v t="josephorr.20170327233236.1"><vh>Additional Features</vh></v>
<v t="josephorr.20170327233257.1"><vh>Installing Leo</vh></v>
</v>
<v t="josephorr.20170327233126.1"><vh>More About Leo Viewer</vh></v>
<v t="josephorr.20170326174511.1" a="E"><vh>Some Sample Content</vh>
<v t="josephorr.20170304173237.1"><vh>HTML</vh>
<v t="josephorr.20170304174041.1"><vh>Text and Photo</vh></v>
</v>
<v t="josephorr.20170304174421.1"><vh>Text</vh>
<v t="josephorr.20170304174436.1"><vh>A Note About Something</vh></v>
</v>
<v t="josephorr.20170304113011.1"><vh>Code</vh>
<v t="josephorr.20170304113024.1"><vh>Javascript</vh></v>
<v t="josephorr.20170304115429.1"><vh>Coffeescript</vh></v>
</v>
<v t="josephorr.20170304103722.1"><vh>Markdown</vh>
<v t="josephorr.20170304175209.1"><vh>Markdown In Leo</vh></v>
<v t="josephorr.20170304103726.1"><vh>A Markdown Section</vh></v>
</v>
<v t="josephorr.20170326071708.1"><vh>Some Cloned Nodes</vh>
<v t="josephorr.20170304115429.1"></v>
<v t="josephorr.20170304175209.1"></v>
</v>
<v t="josephorr.20170326072340.1" a="E"><vh>File Nodes</vh>
<v t="josephorr.20170326072346.1"><vh>@clean ../src/services/leo.js</vh></v>
<v t="josephorr.20170328225527.1" a="E"><vh>@clean ../src/components/TreeViewer.vue</vh>
<v t="josephorr.20170328225654.1"><vh>&lt;&lt; template &gt;&gt;</vh></v>
<v t="josephorr.20170328225718.1"><vh>&lt;&lt; script &gt;&gt;</vh></v>
<v t="josephorr.20170328225741.1"><vh>&lt;&lt; style &gt;&gt;</vh></v>
</v>
</v>
</v>
</v>
</vnodes>
<tnodes>
<t tx="josephorr.20170228222411.2">@language html

&lt;h1&gt;About Leo Viewer&lt;/h1&gt;
&lt;p&gt;
Leo Viewer is a web app that can display files created with 
&lt;a href='http://www.leoeditor.com'&gt;Leo&lt;/a&gt;, the open source outlining editor and IDE.
&lt;/p&gt;
&lt;p&gt;
Leo has some unique features that make it particularly suitable for documenting code and other complex documents.
&lt;/p&gt;
&lt;p&gt;
Using Leo, you can create an outlined document like the one you are viewing. Content nodes can contain
text, html, markdown or code. Using Leo Viewer, users can view your document as a normal webpage without having to install Leo.
&lt;/p&gt;
 </t>
<t tx="josephorr.20170304103722.1"></t>
<t tx="josephorr.20170304103726.1">@language md

# A topic

This is fascinating.

## Another Topic

This one is less so.

### Fine Print

We would rather you not read this section.</t>
<t tx="josephorr.20170304113011.1"></t>
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
<t tx="josephorr.20170304173237.1">This branch has contains an HTML leaf node in it.</t>
<t tx="josephorr.20170304174041.1">@language html

&lt;h1&gt;Bee And Flower&lt;/h1&gt;

An example of HTML content.

&lt;div&gt;
  &lt;p&gt;
    &lt;img src='https://upload.wikimedia.org/wikipedia/commons/5/5e/200x133px-Biene_auf_lavendel.png'&gt;
  &lt;/p&gt;
&lt;/div&gt;  </t>
<t tx="josephorr.20170304174421.1"></t>
<t tx="josephorr.20170304174436.1">This is just some regular text.

And now for some hipster ipsum:

Prism selvage farm-to-table, chillwave hexagon echo park tacos wayfarers shabby chic. Man braid chartreuse offal meggings. Messenger bag fap shabby chic blue bottle, typewriter la croix man braid chicharrones fashion axe mlkshk mustache narwhal. Single-origin coffee banh mi put a bird on it, lomo cred mumblecore schlitz flexitarian freegan retro. Edison bulb keytar single-origin coffee, direct trade plaid pug everyday carry ethical enamel pin. Viral neutra direct trade ramps semiotics intelligentsia, organic celiac food truck vice. Echo park PBR&amp;B iPhone trust fund dreamcatcher.</t>
<t tx="josephorr.20170304175209.1">@language md
## Leo Does Markdown

This node was writen with Markdown.

Use the @language md directive to set the node to markdown.</t>
<t tx="josephorr.20170326071708.1"></t>
<t tx="josephorr.20170326072340.1"></t>
<t tx="josephorr.20170326072346.1">@language javascript
function loadXMLDoc (filename, type) {
  const xhttp = new XMLHttpRequest()
  xhttp.open('GET', filename, false) // synchronous
  xhttp.send('')
  return xhttp['response' + type]
}

function getLeoJSON (filename) {
  var p = new Promise((resolve, reject) =&gt; {
    const xmlString = loadXMLDoc('./static/' + filename + '.leo', 'Text')
    const oParser = new DOMParser()
    const xml = oParser.parseFromString(xmlString, 'text/xml')
    const xsl = loadXMLDoc('./static/leo.xsl', 'XML')
    const xsltProcessor = new XSLTProcessor()
    xsltProcessor.importStylesheet(xsl)
    const resultDocument = xsltProcessor.transformToFragment(xml, document)
    let data = resultDocument.textContent
    data = data.replace(/,\s?$/, '') // kludge to get rid of trailing comma
    const xdata = null
    data = 'xdata = ' + data
    eval(data) // eslint-disable-line JSON.Parse doesn't work because of template strings
    resolve(xdata)
  })
  return p
}

export {getLeoJSON}</t>
<t tx="josephorr.20170326174500.1">@language html
&lt;p&gt;
Leo is a unique text editor and IDE that facilitates a new way of looking at text documents, including programming.
&lt;/p&gt;
&lt;p&gt;
The purpose of this document is to make a very brief introduction to creating tree based content with Leo and
displaying it with Leo Viewer. In particular, Leo has features that make it particularly suitable for creating 
documentation of code.
&lt;/p&gt;
&lt;p&gt;
More advanced uses are able to use Leo to practice a type of "Literate Programming", that is, a style of
programming where documentation comes first, and code is generated from the documentation or
is developed in tandem with it.
&lt;/p&gt;</t>
<t tx="josephorr.20170326174511.1">@language html

&lt;h2&gt;Content Creation with Leo&lt;/h2&gt;

Using Leo, you can create an outline tree with various types of content. This subsection contains some examples of different content created in a Leo file and displayed with the Leo Viewer.</t>
<t tx="josephorr.20170327233126.1"></t>
<t tx="josephorr.20170327233137.1">@language html
&lt;h2&gt;Leo Is an Outlining Editor&lt;/h2&gt;
&lt;p&gt;
In the screenshot below, you can see an outline or tree in the top left pane, and content for 
current node being entered into the bottom pane.
&lt;/p&gt;
&lt;img width="500" src="static/leo1.png" alt="ScreenShot"&gt;

&lt;h2&gt;Leo Outlines can contain Cloned Nodes&lt;/h2&gt;
&lt;p&gt;
A single node can appear in multiple places in your tree, this is called a "clone" node. This allows Leo Outlines
to be in effect, three dimensional and arbitrarily complex.
&lt;/p&gt;
&lt;p&gt;
In the screenshot below, the "Coffeescript" node has been cloned and is appearing in two places in the tree. When you edit the content of the node and then click on its clone, you'll see that the edited content shows on both.
&lt;/p&gt;

&lt;img width="500" src="static/leo2.png" alt="ScreenShot"&gt;

&lt;h2&gt;Leo Outlines can mirror other files&lt;/h2&gt;
&lt;p&gt;
The screenshot below shows a node with a '@clean' directive. This tells Leo that the content of the node should mirror the file specified by the directive.
&lt;/p&gt;
&lt;p&gt;
This means that, when the target file is updated by another program, the content in the node will automatically update in Leo, regardless of whether that
content has been divided into subnodes by Leo. To see how this works, read the next section: &lt;b&gt;Chunking&lt;/b&gt;.
&lt;/p&gt;

&lt;img width="500" src="static/leo3.png" alt="ScreenShot"&gt;</t>
<t tx="josephorr.20170327233223.1">@language html
&lt;p&gt;
In the screenshot below, we've created a new node with a @clean directive with a file name. 
We've pasted the contents of the file into the node.
&lt;/p&gt;
&lt;img width="500" src="static/leo4.png" alt="ScreenShot"&gt;

&lt;p&gt;
This is a Vuejs component file, with three sections. We're going to break the sections out into 
separate nodes. First create a section name using double angle brackets.
&lt;/p&gt;
&lt;img width="500" src="static/leo5.png" alt="ScreenShot"&gt;

&lt;p&gt;
Now select the section name plus the code you want to put in a sub node.
&lt;/p&gt;
&lt;img width="500" src="static/leo6.png" alt="ScreenShot"&gt;

&lt;p&gt;
Enter Cmd-Shift-D to chunk the selected content into a subnode.
&lt;/p&gt;
&lt;img width="500" src="static/leo7.png" alt="ScreenShot"&gt;

&lt;p&gt;
Repeat this process with the other sections of the Vuejs component, now each
has its own node. 
&lt;/p&gt;
&lt;img width="500" src="static/leo8.png" alt="ScreenShot"&gt;

&lt;p&gt;
This is a simple example, but using Leo it is possible to quickly break up a large,
complex set of code into manageable pieces. The target file is not affected,
and if the target file is changed in another program, Leo will update the appropriate nodes.
&lt;/p&gt;</t>
<t tx="josephorr.20170327233236.1"></t>
<t tx="josephorr.20170327233257.1"></t>
<t tx="josephorr.20170328225527.1">&lt;&lt; template &gt;&gt;
&lt;&lt; script &gt;&gt;
&lt;&lt; style &gt;&gt;
</t>
<t tx="josephorr.20170328225654.1">@language xml
&lt;template&gt;
  &lt;div class="treeviewer"&gt;
    &lt;div class="panes-container"&gt;
      &lt;div class="left-pane" id="left-pane"&gt;
        &lt;ul id="demo"&gt;
          &lt;item
            class="item"
            :showContent="true"
            :model="data.data"
            :textItems="data.textItems"
            :open="true"
            :targetEl="target.el"&gt;
          &lt;/item&gt;
        &lt;/ul&gt;
      &lt;/div&gt;
      &lt;div class="panes-separator" id="panes-separator"&gt;&lt;/div&gt;
      &lt;div class="right-pane" id="right-pane"&gt;
      &lt;/div&gt;
    &lt;/div&gt;
  &lt;/div&gt;
&lt;/template&gt;</t>
<t tx="josephorr.20170328225718.1">@language javascript

&lt;script&gt;
import Item from './Item'
import {getLeoJSON} from '../services/leo.js'

let model = {
  data: {},
  textItems: {}
}

let leftPane
let rightPane
let paneSep
// let currentNode = null

let target = {el: null}
export default {
  name: 'treeviewer',
  components: {
    item: Item
  },
  data: function () {
    return {
      data: model,
      target: target,
      open: false,
      active: false
    }
  },
  mounted: () =&gt; {
    leftPane = document.getElementById('left-pane')
    rightPane = document.getElementById('right-pane')
    target.el = rightPane
    paneSep = document.getElementById('panes-separator')
    rightPane.innerHTML = ''

    // The script below constrains the target to move horizontally between a left and a right virtual boundaries.
    // - the left limit is positioned at 10% of the screen width
    // - the right limit is positioned at 90% of the screen width
    var leftLimit = 0
    var rightLimit = 90

    paneSep.sdrag(function (el, pageX, startX, pageY, startY, fix) {
      fix.skipX = true
      if (pageX &lt; window.innerWidth * leftLimit / 100) {
        pageX = window.innerWidth * leftLimit / 100
        fix.pageX = pageX
      }
      if (pageX &gt; window.innerWidth * rightLimit / 100) {
        pageX = window.innerWidth * rightLimit / 100
        fix.pageX = pageX
      }
      var cur = pageX / window.innerWidth * 100
      if (cur &lt; 0) {
        cur = 0
      }
      if (cur &gt; window.innerWidth) {
        cur = window.innerWidth
      }
      var right = (100 - cur - 2)
      leftPane.style.width = cur + '%'
      rightPane.style.width = right + '%'
    }, null, 'horizontal')
    getLeoJSON('docs').then(ldata =&gt; {
      model.data = ldata.data
      model.textItems = ldata.textItems
    })
  }
}
&lt;/script&gt;</t>
<t tx="josephorr.20170328225741.1">@language css
&lt;!-- Add "scoped" attribute to limit CSS to this component only --&gt;
&lt;style scoped&gt;

.treeviewer{
  height: 100%
}
h1, h2 {
  font-weight: normal;
}

ul {
  list-style-type: none;
  padding: 0;
}

li {
  display: inline-block;
  margin: 0 10px;
}

a {
  color: #42b983;
}


.panes-container {
  display: flex;
  width: 100%;
  overflow: hidden;
}

.left-pane {
  width: 250px;
  background: #fff;
}
.right-pane {
  max-width: 600px;
}

.panes-separator {
  width: 11px;
  background: #eee;
  position: relative;
  cursor: col-resize;
  background-image: url('../assets/vertical.png');
  background-repeat: no-repeat;
  background-position: 50%;
}

.right-pane {
  flex: auto;
  background: #fff;
}

.panes-container,
.panes-separator,
.left-pane,
.right-pane {
  margin: 0;
  padding: 0;
  min-height: 100%;
}
.right-pane {
  padding:10px;
  padding-top:0px;
}
p {
  line-height:1.3em;
}


&lt;/style&gt;</t>
</tnodes>
</leo_file>

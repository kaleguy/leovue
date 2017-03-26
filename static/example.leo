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
<v t="josephorr.20170228222411.2" a="E"><vh>Top</vh>
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
<v t="josephorr.20170326072340.1" a="E"><vh>A File Node</vh>
<v t="josephorr.20170326072346.1"><vh>@clean ../src/services/leo.js</vh></v>
</v>
</v>
</vnodes>
<tnodes>
<t tx="josephorr.20170228222411.2">This is the top.</t>
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
<t tx="josephorr.20170304173237.1">This branch has an HTML leaf in it.</t>
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
<t tx="josephorr.20170326072346.1">function loadXMLDoc (filename, type) {
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
</tnodes>
</leo_file>

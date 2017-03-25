var leftPane = document.getElementById('left-pane');
var rightPane = document.getElementById('right-pane');
var paneSep = document.getElementById('panes-separator');

rightPane.innerHTML = '';

var currentNode = null;

function showText(text){
    if (! text){return}

    language = getLanguage(text);

    // just plain text
    if (! language){
        rightPane.innerHTML = `<textarea readonly>${text}</textarea>`;
        return;
    }

    // remove Leo directives from output
    text = removeFirstLine(text);

    switch(language){
        case 'md':
            text = marked(text);
            rightPane.innerHTML = text;
            break;
        case 'html':
            rightPane.innerHTML = text;
            break;
        default:
            text = `<pre><code class="${language}">${text}</code></pre>`;
            rightPane.innerHTML = text;
            hljs.highlightBlock(rightPane);
    }

}

function getLanguage(text){
   var language = '';
   var re = /^@language (\w+)/;
   var languageTokens = re.exec(text);
   if (languageTokens){
       language = languageTokens[1];
       console.log(language);
   }
   return language;
}

function removeFirstLine(text){
    return text.split(/[\n]/).splice(1).join('\n');
}


Vue.component('item', {

   template: '#item-template',
    props: {
        model: Object
    },
    data: function(){
        return {
            open: false,
            active: false
        }
    },
    computed: {
        isFolder: function() {
            return this.model.children && this.model.children.length;
        }
    },
    methods: {
        toggle: function(){
            if (this.isFolder){
                this.open = ! this.open;
            }
            if (currentNode) {
                currentNode.active = false;
            }
            currentNode = this;
            currentNode.active = true;

            console.log(this);
            showText(this.model.text);
        }
    }

});

function loadXMLDoc(filename, type){
    var xhttp = new XMLHttpRequest();
    xhttp.open('GET', filename, false); // synchronous
    xhttp.send('');
    return xhttp['response' + type];
}

function displayResult(){

    var xmlString = loadXMLDoc('example.leo', 'Text');
    var oParser = new DOMParser();
    var xml = oParser.parseFromString(xmlString,'text/xml');
    var xsl = loadXMLDoc('leo.xsl', 'XML');
    var xsltProcessor = new XSLTProcessor();
    xsltProcessor.importStylesheet(xsl);
    var resultDocument = xsltProcessor.transformToFragment(xml, document);
    var data = resultDocument.textContent;
    data = data.replace(/,\s?$/,''); // kludge to get rid of trailing comma
    data = 'var data = ' + data;
    eval(data); // JSON.Parse doesn't work because of template strings
    var demo = new Vue({
        el: '#demo',
        data: {
            treeData: data
        }
    })

}

// The script below constrains the target to move horizontally between a left and a right virtual boundaries.
// - the left limit is positioned at 10% of the screen width
// - the right limit is positioned at 90% of the screen width
var leftLimit = 0;
var rightLimit = 90;


paneSep.sdrag(function (el, pageX, startX, pageY, startY, fix) {

    fix.skipX = true;

    if (pageX < window.innerWidth * leftLimit / 100) {
        pageX = window.innerWidth * leftLimit / 100;
        fix.pageX = pageX;
    }
    if (pageX > window.innerWidth * rightLimit / 100) {
        pageX = window.innerWidth * rightLimit / 100;
        fix.pageX = pageX;
    }

    var cur = pageX / window.innerWidth * 100;
    if (cur < 0) {
        cur = 0;
    }
    if (cur > window.innerWidth) {
        cur = window.innerWidth;
    }

    var right = (100-cur-2);
    leftPane.style.width = cur + '%';
    rightPane.style.width = right + '%';

}, null, 'horizontal');



displayResult();

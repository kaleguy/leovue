function presentation(name, content, index, theme, codeTheme) {

  if (!name) { name = 'default' }
  if (!index) { index = 0 }
  if (!codeTheme) { codeTheme = 'zenburn'}
  if (!theme) { theme = 'black'}

  const html = `
<!doctype html>
<html>
	<head>
		<meta charset="utf-8">
		<!--<base href="static/reveal/"-->
		<base href="https://cdn.jsdelivr.net/npm/reveal.js@3.6.0/">
		
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
		<title>${name}</title>
		<!--
		<link rel="stylesheet" href="css/reveal.css">
		<link id="theme" rel="stylesheet" href="css/theme/${theme}.css">
    -->
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/reveal.js@3.6.0/css/reveal.css">
		<link id="theme" rel="stylesheet" href="https://cdn.jsdelivr.net/npm/reveal.js@3.6.0/css/theme/${theme}.css">
    
		<!-- Theme used for syntax highlighting of code -->
		<!--
		<link rel="stylesheet" href="lib/css/${codeTheme}.css">
		-->
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/highlight.js@9.12.0/styles/${codeTheme}.css">
		
    <style type="text/css">
    .section-link {
      color: #4cb986;
      font-weight: bold;
      cursor: pointer;
      text-decoration: none;
      display: inline-block;
    }
    </style>
  <script>
    window.lconfig = {
      "presentationName": '${name}',
      "index": ${index},
      "appBase": true,
      "showAppTitle": true,
      "showHeader": true,
      "docTitle": "",
      "filename": "docs",
      "firstNodeAsTitle": true,
      "baseMode": "t",
      "viewTypes": [
        {"name": "Outline", "type": "t"},
        {"name": "Inline", "type": "a"},
        {"name": "Graphic Tree", "type": "d"},
        {"name": "Dendrogram", "type": "z"},
        {"name": "Nested Menu", "type": "n"}
      ]
    }
  </script>
  	</head>
	<body>
	  <script type="template" id="slideContent">
	  ${content}	  
    </script>
	  <div id="app-base"></div>
    <script src='https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.1/MathJax.js?config=TeX-MML-AM_CHTML'></script>
    <script src='https://unpkg.com/mermaid@7.1.0/dist/mermaid.min.js'></script>
    
		<script src="https://cdn.jsdelivr.net/npm/reveal.js@3.6.0/lib/js/head.min.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/reveal.js@3.6.0/js/reveal.min.js"></script>
    <!--
		<script src="https://cdn.jsdelivr.net/npm/reveal.js@3.6.0/js/manifest.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/reveal.js@3.6.0/js/vendor.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/reveal.js@3.6.0/js/app.js"></script>
    -->
    
    <!-- reveal.js if local
		<script src="js/reveal.js"></script>
		<script src="lib/js/head.min.js"></script>
		-->
		
		<script src="https://cdn.rawgit.com/kaleguy/leovue/master/dist/static/js/manifest.js"></script>
		<script src="https://cdn.rawgit.com/kaleguy/leovue/master/dist/static/js/vendor.js"></script>
		<script src="https://cdn.rawgit.com/kaleguy/leovue/master/dist/static/js/app.js"></script>
    
	</body>
</html>

  `
  return html
}

export {
  presentation
}

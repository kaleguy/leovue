[![vue2](https://img.shields.io/badge/vue-2.x-brightgreen.svg)](https://vuejs.org/)
[![Dependency Status](https://david-dm.org/kaleguy/leovue.svg)](https://david-dm.org/kaleguy/leovue)

# Leo Vue

Viewer for Leo Files, built with Vue.js.

Use the Open Source [Leo Outlining Editor](http://leoeditor.com) to create tree-based websites.

Content items can be text, markdown, or html with Vue components.

### Leo
Leo is a cross platform desktop program that allows you to create outlined content, like the docs.leo file from this project shown below:
![Leo](https://kaleguy.github.io/leovue/screencasts/leo.gif)

### Leo Vue
You can use Leo Vue to make view Leo files with a browser. Leo Vue also allows you to add urls in node titles, with the content pane showing the url content.
![Leo](https://kaleguy.github.io/leovue/screencasts/leovue.gif)

### Outline Formats
Leo Vue allows you to view outlines in various formats, including inline.
![Leo](https://kaleguy.github.io/leovue/screencasts/leovue-trees.gif)

### Vue Components in Content
Content in nodes can contain Vue components or csv data. Leo Vue renders the Vue components.
![Leo](https://kaleguy.github.io/leovue/screencasts/leovue-components.gif)


## More Examples

[Plays of William Shakespeare](https://kaleguy.github.io/leovue/examples/shakespeare/)

[Plays of William Shakespeare, version with nested menus and no header](https://kaleguy.github.io/leovue/examples/shakespeare_n/)

[More Examples](https://kaleguy.github.io/leo-examples/)

## Build Setup

``` bash
# install dependencies
npm install

# serve with hot reload at localhost:8080
npm run dev

# build for production with minification
npm run build

# build for production and view the bundle analyzer report
npm run build --report

# build site with static pages for SEO, files will be generated into dist/static/site
npm run build-static


```

For detailed explanation on how Vue works with this project, check out the [guide](http://vuejs-templates.github.io/webpack/) and [docs for vue-loader](http://vuejs.github.io/vue-loader).

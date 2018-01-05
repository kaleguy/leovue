[![vue2](https://img.shields.io/badge/vue-2.x-brightgreen.svg)](https://vuejs.org/)
[![Dependency Status](https://david-dm.org/kaleguy/leovue.svg)](https://david-dm.org/kaleguy/leovue)
[![devDependencies Status](https://david-dm.org/kaleguy/leovue/dev-status.svg)](https://david-dm.org/kaleguy/leovue?type=dev)

# Leo Vue

Viewer for Leo Files, built with Vue.js.

Use the Open Source [Leo Outlining Editor](http://leoeditor.com) to create tree-based websites.

Content items can be text, markdown, or html with Vue components.

[Live Site with Docs](https://kaleguy.github.io/leovue/)

### Leo
Leo is a cross platform desktop program that allows you to create outlined content, like the docs.leo file from this project shown below:

![Leo](https://kaleguy.github.io/leovue/screencasts/leo.gif)

### Leo Vue
You can use Leo Vue to view Leo files with a browser. Leo Vue also allows you to put urls in node titles, with the content pane showing the url content.
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

[More](https://kaleguy.github.io/leo-examples/)

## Quick Start

Leo Vue requires a webserver to run. Either install it on your server or run it locally with http-server:

``` bash
# install node.js, then:
npm install -g http-server

```

For a quick start using Leo Vue from a CDN, see [this example repo](https://kaleguy.github.io/leo-examples/)

[Leo Vue CDN](https://www.jsdelivr.com/package/npm/leo-vue)

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

```

## Static Site Builder

This project includes a utility to generate a static site. The outline tree becomes a standalone page, as do each of the content items. These are simple HTML pages with no javascript, so Vue components in content don't work. This feature is generating a site that is easily crawlable, for example for SEO. The pages are very basic at the moment because they aren't really intended for viewing, but styles could be added to make them more presentable.

To generate the static site:

```
# build site with static pages for SEO, files will be generated into dist/static/site

npm install xmldmom
npm install xslt4node
npm run build-static

```

## Deploying to Github-Pages

If you set up your Github repo to serve pages from the docs folder (in repo settings), you can use the following script to make a clean distribution into that folder:

```
npm run build-deploy

```

## Built With

Main feature components:

* [Vue.js](https://vuejs.org/) - The web framework used
* [Vue.D3.Tree](https://github.com/David-Desmaisons/Vue.D3.tree)
* [Lunr](https://lunrjs.com/) and [Vue-Instant](https://github.com/santiblanko/vue-instant) - Search
* [Highlight.js](https://highlightjs.org/) - Code highlighting
* [Velocity-Animate](https://www.npmjs.com/package/velocity-animate) - Animation

Major Content Components:

* [Vue-Chartjs](https://github.com/apertureless/vue-chartjs) - Charts
* [Vue-Table-Component](https://github.com/spatie/vue-table-component) - Tables
* [Mermaid](https://mermaidjs.github.io/) - Diagrams
* [MathJax](https://www.mathjax.org/) - Math Notation
* [Reveal.js](https://revealjs.com/#/) - presentations
* [Vue2-Leaflet](https://github.com/KoRiGaN/Vue2Leaflet) - maps


## Running Offline

The following components are accessed via CDN, so if you want to run offline you'll need to download them and change the links in the relevant files (e.g. index.html).

* MathJax
* Revealjs
* Mermaid

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/kaleguy/leovue/tags).

## Authors

* **kaleguy**

## More Vue development info

For detailed explanation on how Vue works with this project, check out the [guide](http://vuejs-templates.github.io/webpack/) and [docs for vue-loader](http://vuejs.github.io/vue-loader).

## Acknowledgments

Many thanks to **Edward K. Ream** for the uniquely useful Leo program.

Many thanks to **Evan You** and the many contributors to the Vue project and Vue ecosystem.

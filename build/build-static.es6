require('babel-core/register')
const leo = require('../src/services/leo')
const fs = require('fs')
const DOMParser = require('xmldom').DOMParser;
const xslt4node = require('xslt4node')

const text = fs.readFileSync('static/docs.leo', 'utf8')
console.log(text)
const leoJSON = leo.transformLeoXML(text, 'L1', DOMParser, XSLTransformer)
console.log(leoJSON)


// load the leo file

// generate the folders

// generate the content

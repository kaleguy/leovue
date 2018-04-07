import _ from 'lodash'

const none = `
 <div>NO TEMPLATE</div>
`
const weather =
`
<h1>Weather</h1>
`

const templates = { none, weather }

function render (json, templateType) {
  if (!templateType) {
    templateType = 'none'
  }
  const templateString = templates[templateType]
  if (!templateString) {
    return (Promise.resolve('<h2>No Matching Template</h2>'))
  }
  const compiled = _.template(templateString)
  return Promise.resolve(compiled(json))
}

export default { render }

import _ from 'lodash'

const none = `
 <div>NO TEMPLATE</div>
`
const weather =
`
<h1>Weather for <%= params.location %></h1>
<div>Data from <%= params.source %></div>
<div class="weather-report">
  <table>   
    <tr><td class="col-label">Observation Time:</td><td><%= moment(dt * 1000).format('MMMM Do YYYY, h:mm a') %></td></tr>      
    <tr><td class="col-label">Weather:</td><td><%= weather[0].description %></td></tr>      
    <tr><td class="col-label">Temperature:</td><td><%= main.temp %></td></tr>      
    <tr><td class="col-label">Humidity:</td><td><%= main.humidity %></td></tr>      
    <tr><td class="col-label">Wind:</td><td><%= wind.speed %></td></tr>
  </table>
</div>        
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
  let html = '<h2>Template Compilation Error</h2>'
  try {
    html = compiled(json)
  } catch (e) {
    console.log('Template compilation error: ', e)
  }
  return Promise.resolve(html)
}

export default { render }

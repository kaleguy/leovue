import _ from 'lodash'

const none = `
 <div>NO TEMPLATE</div>
`

const openbooks = `
<% var book = data[Object.keys(data)[0]] %>
<div class="book-listing">
  <h2><%- book.title %></h2>
  <h3><%- book.subtitle %></h3>
  <div style="float:left;margin-right:6px;">
    <% if (book.cover) { %>
    <a target="_blank" href="<%= book.url %>"><img src="<%= book.cover.medium %>"/></a>
    <% } %>
  </div>
  <div style="float:left">  
    <table>
      <tr>
        <td class="col-label">Author<% if (book.authors.length > 1) { %>s<% } %>:</td>
        <td style="width:300px">
        <% for (var i = 0; i < book.authors.length; i++) { 
             var author = book.authors[i]
        %>
             <a target="_blank" href="<% author.url %>"><span style="white-space: nowrap"><%- author.name %><br></span></a>
        <% } %>
          </td>
      </tr>
      <tr><td class="col-label">Pages:</td><td><%= book.number_of_pages %></td></tr>
      <tr><td class="col-label">Pub. Date:</td><td><%= book.publish_date %></td></tr>
      <tr>
        <td class="col-label">Publisher:</td>
        <td style="width:300px">
        <% for (var i = 0; i < book.publishers.length; i++) { 
             var publisher = book.publishers[i]
        %>
             <span style="white-space: nowrap"><%- publisher.name %><br></span>
        <% } %>
          </td>
      </tr>    </table>
  </div>
  <% if (data.params.rating) { %>
  <div style="clear:both; padding-top:10px;">
    <star-rating :show-rating="false" :read-only="true" star-size="25" rating="<%= data.params.rating %>"></star-rating>
  </div>
  <% } %>
  <div class="comments">
  <%- data.params.comments %>
  </div>   
</div>
`

const weather =
`
<h1>Weather for <%= data.params.location %></h1>
<div>Data from <%= data.params.source %></div>
<div class="weather-report">
  <table>   
    <tr><td class="col-label">Observation Time:</td><td><%= moment(data.dt * 1000).format('MMMM Do YYYY, h:mm a') %></td></tr>      
    <tr><td class="col-label">Weather:</td><td><%= data.weather[0].description %></td></tr>      
    <tr><td class="col-label">Temperature:</td><td><%= data.main.temp %></td></tr>      
    <tr><td class="col-label">Humidity:</td><td><%= data.main.humidity %></td></tr>      
    <tr><td class="col-label">Wind:</td><td><%= data.wind.speed %></td></tr>
  </table>
</div>        
`

const templates = { none, weather, openbooks }

function render (json, templateType) {
  if (!templateType) {
    templateType = 'none'
  }
  let templateString = null
  // check to see if there is a SCRIPT/template with the matching name
  let templateEl = document.getElementById(templateType)
  if (templateEl) {
    templateString = templateEl.innerText
      .replace(/{{/g, '<%')
      .replace(/}}/g, '%>')
  }
  templateString = templateString || templates[templateType]
  if (!templateString) {
    // return (Promise.resolve('<h2>No Matching Template</h2>'))
    return '<h2>No Matching Template</h2>'
  }
  const compiled = _.template(templateString)
  let html = '<h2 class="error-msg">Template Compilation Error</h2>'
  try {
    html = compiled({data: json})
  } catch (e) {
    console.log('Template compilation error: ', templateType, e)
  }
  // return Promise.resolve(html)
  // TODO: add general cleanup here
  html = html.replace(/&amp;quot;/g, '&quot;')
  return html
}

export default { render }

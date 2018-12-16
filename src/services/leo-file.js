import _ from 'lodash'
const baseString = `
<leo_file xmlns:leo="http://leoeditor.com/namespaces/leo-python-editor/1.1" >
  <leo_header file_format="2" tnodes="0" max_tnode_index="0" clone_windows="0"/>
  <globals body_outline_ratio="0.5" body_secondary_ratio="0.5">
    <global_window_position top="50" left="50" height="500" width="700"/>
    <global_log_window_position top="0" left="0" height="0" width="0"/>
  </globals>
  <preferences/>
  <find_panel_settings/>
  <vnodes>
    %%vnodes%%
  </vnodes>
  <tnodes>
    %%tnodes%%
  </tnodes>
</leo_file>
`

/**
 *
 * @param d {Object}
 * @param items {Array}
 * @param t {Object}
 * @param tItems {Array}
 * @returns {*}
 */
function dataToItems (d, items, t, tItems) {
  items.push(`<v t="leovue.${d.t}"><vh>${d.name}</vh>`)
  let text = t[d.t]
  text = text.replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/&\s/g, '&amp;')
  tItems.push(`<t tx="leovue.${d.t}">${text}</t>`)
  if (_.isArray(d)) {
    return d.forEach(i => dataToItems(i, items, t, tItems))
  }
  if (d.children) {
    d.children.forEach(i => {
      dataToItems(i, items, t, tItems)
    })
  }
  items.push('</v>')
}
function JSONtoLeo (data, textData) {
  let items = []
  let textItems = []
  dataToItems(data, items, textData, textItems)
  // dataToTextItems(textData, textItems)
  let vnodes = items.join('')
  let tnodes = textItems.join('')
  let leo = baseString.replace(/%%vnodes%%/, vnodes)
  leo = leo.replace(/%%tnodes%%/, tnodes)
  return leo
}

export { JSONtoLeo }

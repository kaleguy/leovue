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
<v t="josephorr.20180907154621.1" a="E"><vh>[Formio.js Form Renderer](README.md)</vh>
<v t="josephorr.20180907165357.1" a="E"><vh>@clean examples/simple.html</vh>
<v t="josephorr.20180907165423.1" a="E"><vh>&lt;html&gt;</vh>
<v t="josephorr.20180907165423.2" a="E"><vh>&lt;head&gt;</vh>
<v t="josephorr.20180907165423.3"><vh>bootstrap style link</vh></v>
<v t="josephorr.20180907165423.4"><vh>formio style link</vh></v>
<v t="josephorr.20180907170852.1"><vh>formio library link</vh></v>
<v t="josephorr.20180907165423.6" a="E"><vh>The page script tag</vh>
<v t="josephorr.20180907212457.1"><vh>the Formio page form code</vh></v>
</v>
<v t="josephorr.20180907165423.5"><vh>page style</vh></v>
</v>
<v t="josephorr.20180907165423.7"><vh>&lt;body&gt;</vh></v>
</v>
</v>
<v t="josephorr.20180907154643.1"><vh>[Simple Example](examples/simple.html)</vh></v>
</v>
</vnodes>
<tnodes>
<t tx="josephorr.20180907154621.1"></t>
<t tx="josephorr.20180907154643.1">@language html-source

&lt;html&gt;
&lt;head&gt;
    &lt;link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css'&gt;
    &lt;link rel='stylesheet' href='https://unpkg.com/formiojs@latest/dist/formio.full.min.css'&gt;
    &lt;script src='https://unpkg.com/formiojs@latest/dist/formio.full.min.js'&gt;&lt;/script&gt;
    &lt;script type='text/javascript'&gt;
      window.onload = function() {
        Formio.createForm(
          document.getElementById('formio'),
          {
              components: [
                {
                  type: 'textfield',
                  key: 'firstName',
                  label: 'First Name',
                  placeholder: 'Enter your first name.',
                  input: true
                },
                {
                  type: 'textfield',
                  key: 'lastName',
                  label: 'Last Name',
                  placeholder: 'Enter your last name',
                  input: true
                },
                {
                  type: 'button',
                  action: 'submit',
                  label: 'Submit',
                  theme: 'primary'
                }
              ]
          },
          {
            hooks: {
               beforeSubmit: (submission, next) =&gt; {
                 alert('Before Submit: \n\n' + JSON.stringify(submission, null, 2))
                 next()
               }
            }
          }
        ).then(form =&gt; {
          form.on('submit', submission =&gt; {
            alert('The form was just submitted!\n\n' + JSON.stringify(submission, null, 2))
            form.emit('submitDone', submission)
          })
          form.on('submitDone', submission =&gt; {
            alert('Done submitting form.')
          })
          form.on('change', changed =&gt; {
            console.log('Form was changed', changed);
          })
          form.on('error', errors =&gt; {
            alert('We have errors')
            console.log(errors)
          })
        })
      }
    &lt;/script&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;div id='formio'&gt;&lt;/div&gt;
&lt;/body&gt;
&lt;/html&gt;</t>
<t tx="josephorr.20180907165357.1">@others
@tabwidth -4
</t>
<t tx="josephorr.20180907165423.1">@language htmlsource
&lt;html&gt;
    @others
&lt;/html&gt;

</t>
<t tx="josephorr.20180907165423.2">&lt;head&gt;
    @others
&lt;/head&gt;

</t>
<t tx="josephorr.20180907165423.3">&lt;link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css'&gt;
@others


</t>
<t tx="josephorr.20180907165423.4">&lt;link rel='stylesheet' href='https://unpkg.com/formiojs@latest/dist/formio.full.min.css'&gt;
@others

</t>
<t tx="josephorr.20180907165423.5">&lt;style type="text/css"&gt;
    #formio {
        margin: 60px;
    }
&lt;/style&gt;
</t>
<t tx="josephorr.20180907165423.6">&lt;script type='text/javascript'&gt;
  @others
&lt;/script&gt;
</t>
<t tx="josephorr.20180907165423.7">&lt;body&gt;
&lt;div id='formio'&gt;&lt;/div&gt;
&lt;/body&gt;
</t>
<t tx="josephorr.20180907170852.1">&lt;script src='https://unpkg.com/formiojs@latest/dist/formio.full.min.js'&gt;&lt;/script&gt;

</t>
<t tx="josephorr.20180907212457.1">@language javascript

window.onload = function() {
  Formio.createForm(
    document.getElementById('formio'),
    {
        components: [
          {
            type: 'textfield',
            key: 'firstName',
            label: 'First Name',
            placeholder: 'Enter your first name.',
            input: true
          },
          {
            type: 'textfield',
            key: 'lastName',
            label: 'Last Name',
            placeholder: 'Enter your last name',
            input: true
          },
          {
            type: 'button',
            action: 'submit',
            label: 'Submit',
            theme: 'primary'
          }
        ]
    },
    {
      hooks: {
         beforeSubmit: (submission, next) =&gt; {
           alert('Before Submit: \n\n' + JSON.stringify(submission, null, 2))
           next()
         }
      }
    }
  ).then(form =&gt; {
    form.on('submit', submission =&gt; {
      alert('The form was just submitted!\n\n' + JSON.stringify(submission, null, 2))
      form.emit('submitDone', submission)
    })
    form.on('submitDone', submission =&gt; {
      alert('Done submitting form.')
    })
    form.on('change', changed =&gt; {
      console.log('Form was changed', changed);
    })
    form.on('error', errors =&gt; {
      alert('We have errors')
      console.log(errors)
    })
  })
}</t>
</tnodes>
</leo_file>

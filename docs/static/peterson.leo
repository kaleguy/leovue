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
<v t="josephorr.20181220072125.1" a="E"><vh>Research of Jordan Peterson</vh>
<v t="josephorr.20181204092754.1"><vh>@json [Research of Jordan Peterson](static/articles-Jordan_Peterson2.json)</vh></v>
<v t="josephorr.20190122090141.1"><vh>newHeadline</vh></v>
</v>
</vnodes>
<tnodes>
<t tx="josephorr.20181204092754.1">template: rgarticles
nodeList: 
  listKey: articles
  template: rgarticle
  titleKey: title.text
  hrefKey: title.href
  hrefIsQueryString: true
filter:
  key: type.text
  value: Article
</t>
<t tx="josephorr.20181220072125.1"></t>
<t tx="josephorr.20190122090141.1">@from-1 journal
template: rgjournals
nodeList: 
  listKey: journal
  template: rgjournal
  hrefKey: href
  titleKey: text
  hrefIsQueryString: true
filter:
  key: type.text
  value: Article</t>
</tnodes>
</leo_file>

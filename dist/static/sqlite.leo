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
<v t="tsc.20180214164152.1"><vh>@settings</vh>
<v t="tsc.20180214164152.6"><vh>@buttons</vh>
<v t="tsc.20180214164152.7"><vh>@button delete-blob</vh></v>
<v t="tsc.20180214164152.8"><vh>@button insert-blob</vh></v>
<v t="tsc.20180214164152.9"><vh>@button extract-blob</vh></v>
<v t="tsc.20180214164152.10"><vh>@button import-blobs</vh>
<v t="tsc.20180214164152.11"><vh>@@button import-blobs</vh></v>
</v>
<v t="tsc.20180216195827.1"><vh>@button export-blobs</vh></v>
<v t="tsc.20180214164152.14"><vh>@button edit-blob</vh></v>
<v t="tsc.20180214164152.15"><vh>@button open-blob</vh>
<v t="tsc.20180214164152.16"><vh>@@button open-blob</vh></v>
</v>
<v t="tsc.20180214164152.17"><vh>@button view-blob</vh></v>
</v>
<v t="tsc.20180214164152.2"><vh>@bookmarks</vh>
<v t="tsc.20180219220649.1"><vh>export_blobs</vh></v>
<v t="tsc.20180214164152.3"><vh>import-blobs</vh></v>
<v t="tsc.20180214164152.5"><vh>leo4sqlite.py</vh></v>
</v>
<v t="tsc.20180214164152.18"><vh>@data external tools</vh></v>
<v t="tsc.20180214164152.19"><vh>@string sqlite_output_dir = "/home/tsc/Desktop/leo4sqlite-output"</vh></v>
<v t="tsc.20180214164152.20"><vh>@string sqlite_temp_dir = "/home/tsc/Desktop/leo4sqlite-temp"</vh></v>
<v t="tsc.20180214164152.21"><vh>@@file /home/tsc/Desktop/leo4sqlite/leo4sqlite.py</vh></v>
<v t="tsc.20180214164152.22"><vh>@@file /home/tsc/Desktop/leo-editor/leo/plugins/leo4sqlite.py</vh></v>
<v t="tsc.20180214164152.23"><vh>@@file /home/tsc/Desktop/leo4sqlite-file/leo4sqlite.py</vh></v>
</v>
<v t="tscv11.20180119175627.1" a="E"><vh>Sqlite3</vh>
<v t="tsc.20180206152253.2" a="E"><vh>= leo4sqlite script = </vh>
<v t="tsc.20180212011016.1"><vh>&lt;&lt; version history &gt;&gt;</vh></v>
<v t="tsc.20180212011036.1"><vh>&lt;&lt; docstring &gt;&gt;</vh></v>
<v t="tsc.20180209234613.5"><vh>&lt;&lt; imports &gt;&gt;</vh></v>
<v t="tsc.20180209234613.6"><vh>onCreate</vh></v>
<v t="tsc.20180209234613.7"><vh>init</vh></v>
<v t="tsc.20180209234613.8"><vh>class Leo4SqliteError</vh>
<v t="tsc.20180209234613.9"><vh>class Sqlite3DatabaseError</vh></v>
<v t="tsc.20180213194315.1"><vh>class TableIsBlobTable</vh></v>
<v t="tsc.20180209234613.10"><vh>class UnknownActionError</vh></v>
<v t="tsc.20180209234613.11"><vh>class NoInternalDBsError</vh></v>
<v t="tsc.20180209234613.12"><vh>class NoOutputDirectory</vh></v>
<v t="tsc.20180209234613.13"><vh>class NoTempDirectory</vh></v>
<v t="tsc.20180209234613.14"><vh>class UserCancel</vh></v>
<v t="tsc.20180209234613.15"><vh>class NodeExists</vh></v>
</v>
<v t="tsc.20180209234613.16" a="E"><vh>class InputDialogs</vh>
<v t="tsc.20180209234613.17"><vh>__init__</vh></v>
<v t="tsc.20180209234613.18"><vh>initUI</vh></v>
<v t="tsc.20180209234613.19"><vh>pick_action</vh></v>
<v t="tsc.20180209234613.20"><vh>get_ext_db</vh></v>
<v t="tsc.20180209234613.21"><vh>get_int_dbs</vh></v>
<v t="tsc.20180209234613.22"><vh>select_table</vh></v>
<v t="tsc.20180209234613.23"><vh>get_blob_col</vh></v>
<v t="tsc.20180209234613.24"><vh>insert_blob</vh></v>
<v t="tsc.20180209234613.25"><vh>extract_blob</vh></v>
<v t="tsc.20180209234613.26"><vh>open_blob</vh></v>
<v t="tsc.20180209234613.27"><vh>view_blob</vh></v>
<v t="tsc.20180209234613.28"><vh>edit_blob</vh></v>
<v t="tsc.20180209234613.29"><vh>get_layout</vh></v>
<v t="tsc.20180209234613.30"><vh>grand_central</vh></v>
</v>
<v t="tsc.20180209235407.1"><vh>import_tables</vh>
<v t="tsc.20180209234613.31"><vh>import_table1</vh></v>
<v t="tsc.20180209234613.32"><vh>import_table2</vh></v>
<v t="tsc.20180209234613.33"><vh>import_table3</vh></v>
<v t="tsc.20180209234613.34"><vh>import_table4</vh></v>
</v>
<v t="tsc.20180209235541.1"><vh>export_tables</vh>
<v t="tsc.20180209234613.35"><vh>export_table1</vh></v>
<v t="tsc.20180209234613.36"><vh>export_table2</vh></v>
<v t="tsc.20180209234613.37"><vh>export_table3</vh></v>
<v t="tsc.20180209234613.38"><vh>export_table4</vh></v>
</v>
<v t="tsc.20180214062647.1" a="E"><vh>import_blobs</vh>
<v t="tsc.20180209234613.39"><vh>@@import_blobs</vh></v>
</v>
<v t="tsc.20180224081154.1"><vh>export_blobs</vh>
<v t="tsc.20180224081353.1"><vh>@@export_blobs</vh></v>
<v t="tsc.20180224081154.2"><vh>@@export_blobs</vh></v>
<v t="tsc.20180224081154.3"><vh>@@export_blobs</vh></v>
</v>
<v t="tsc.20180209235759.1"><vh>g.commands</vh>
<v t="tsc.20180209234613.42"><vh>sqlite_make_template</vh></v>
<v t="tsc.20180209234613.43"><vh>sqlite_import_table</vh></v>
<v t="tsc.20180209234613.44"><vh>sqlite_export_table</vh></v>
<v t="tsc.20180209234613.45"><vh>sqlite_import_blobs</vh></v>
<v t="tsc.20180209234613.46"><vh>sqlite_export_blobs</vh></v>
<v t="tsc.20180209234613.47"><vh>sqlite_insert_blob</vh></v>
<v t="tsc.20180209234613.48"><vh>sqlite_extract_blob</vh></v>
<v t="tsc.20180209234613.49"><vh>sqlite_open_blob</vh></v>
<v t="tsc.20180209234613.50"><vh>sqlite_view_blob</vh></v>
<v t="tsc.20180209234613.51"><vh>sqlite_edit_blob</vh></v>
<v t="tsc.20180209234613.52"><vh>sqlite_clear_temp</vh></v>
<v t="tsc.20180209234613.53"><vh>sqlite_delete_data</vh></v>
<v t="tsc.20180209234613.54"><vh>sqlite_purge_files</vh></v>
</v>
<v t="tsc.20180209234613.41"><vh>delete_blobs</vh></v>
<v t="tsc.20180226071844.1"><vh>db3_tbl_idx</vh></v>
</v>
</v>
<v t="tsc.20180214164224.1"><vh>temp</vh>
<v t="tsc.20180228090847.1"><vh>@image filename.jpg</vh></v>
</v>
<v t="tsc.20180224090820.1"><vh>data</vh>
<v t="tsc.20180226003650.1"><vh>@db3 /home/tsc/Desktop/sqlite_filename.db3</vh>
<v t="tsc.20180226003650.2" a="E"><vh>@tbl test</vh>
<v t="tsc.20180226003650.3"><vh>bd, cv, gdfg</vh></v>
<v t="tsc.20180226003650.4"><vh>123, 456.0, 789</vh></v>
</v>
<v t="tsc.20180226003822.1"><vh>@tbl test2</vh>
<v t="tsc.20180226003822.2"><vh>one</vh></v>
<v t="tsc.20180226003822.3"><vh>two</vh></v>
<v t="tsc.20180226003822.4"><vh>IDKey</vh></v>
</v>
</v>
<v t="tsc.20180225234500.1"><vh>@db3 /home/tsc/Desktop/blob_test.db3</vh>
<v t="tsc.20180225234500.2"><vh>@tbl testorama</vh>
<v t="tsc.20180225234500.3"><vh>dumb.jpg</vh></v>
<v t="tsc.20180225234500.4"><vh>Screenshot (2).png</vh></v>
<v t="tsc.20180225234500.5"><vh>Screenshot (3).png</vh></v>
<v t="tsc.20180225234500.6"><vh>ly39gCL._.jpg</vh></v>
</v>
</v>
</v>
</vnodes>
<tnodes>
<t tx="tsc.20180206152253.2" __bookmarks="7d7100580700000069735f6475706571014930300a732e">@language python

&lt;&lt; version history &gt;&gt;
&lt;&lt; docstring &gt;&gt;
&lt;&lt; imports &gt;&gt;

@others
@tabwidth -4
</t>
<t tx="tsc.20180209234613.10">class UnknownActionError(Leo4SqliteError):
    """Unknow action error."""
    

</t>
<t tx="tsc.20180209234613.11">class NoInternalDBsError(Leo4SqliteError):
    """No internal database(s) present."""

</t>
<t tx="tsc.20180209234613.12">class NoOutputDirectory(Leo4SqliteError):
    """No output directory specified in settings."""

</t>
<t tx="tsc.20180209234613.13">class NoTempDirectory(Leo4SqliteError):
    """No temp directory specified in settings."""

</t>
<t tx="tsc.20180209234613.14">class UserCancel(Leo4SqliteError):
    """Action cancelled by user."""

</t>
<t tx="tsc.20180209234613.15">class NodeExists(Leo4SqliteError):
    """Node already exists. New node not created."""



</t>
<t tx="tsc.20180209234613.16">@language python

class InputDialogs(QWidget):
    
    @others
</t>
<t tx="tsc.20180209234613.17">@language python

def __init__(self, c):
    super().__init__()
    self.title = 'leo4sqlite'
    self.setWindowIcon(QtGui.QIcon(r'leo/Icons/application-x-leo-outline.png'))
    self.left = 10
    self.top = 10
    self.width = 640
    self.height = 480

    try:
        self.initUI(c)
    except Leo4SqliteError as l4serr:
        g.es("\nleo4sqlite plugin: %s\n" % l4serr.__doc__)  
        return
</t>
<t tx="tsc.20180209234613.18">@language python

def initUI(self, c):
    self.setWindowTitle(self.title)
    self.setGeometry(self.left, self.top, self.width, self.height)
    qtRectangle = self.frameGeometry()
    centerPoint = QDesktopWidget().availableGeometry().center()
    qtRectangle.moveCenter(centerPoint)
    self.move(qtRectangle.topLeft())
    
    self.pick_action(c)
 
    self.show() 


</t>
<t tx="tsc.20180209234613.19">@language python

def pick_action(self, c):
    
    action = c._leo4sqlite['action']    
        
    cmds = ("get_ext_db select_table get_blob_col")
    
    actions = {
                "import table": cmds + " get_layout grand_central",
                "export table": " get_int_dbs select_table get_blob_col grand_central",
                "import blobs": cmds + " grand_central", 
                "insert blob": cmds + " insert_blob",
                "extract blob": cmds + " extract_blob",
                "open blob": cmds + " open_blob",
                "view blob": cmds + " view_blob",
                "edit blob": cmds + " edit_blob",
         }
    
    if action == "export blobs":
        export_blobs(self, c)
    
    if action not in actions:
        raise UnknownActionError()
    for step in actions[action].split():
        method = getattr(self, step)
        method(c)
    

</t>
<t tx="tsc.20180209234613.20">@language python

def get_ext_db(self, c):
        
    options = QFileDialog.Options()
    #options |= QFileDialog.DontUseNativeDialog
    self.setStyleSheet('padding: 3px; background: white');
    db_fname, _ = QFileDialog.getOpenFileName(self,"select an external database:", "","sqlite files (*.db *.db3 *.sqlite *.sqlite3);;all files (*.*)", options=options) # tnb
    if db_fname == '':
        raise UserCancel()
        return
    else:
        c._leo4sqlite['db_filename'] = db_fname
</t>
<t tx="tsc.20180209234613.21">@language python

def get_int_dbs(self, c):
    
    def get_filename(path):
        fn_lst = []
        filename = os.path.basename(path.rstrip('/'))
        fn_lst.append(filename)
        return filename
    
    db3_lst = c.find_h(r'^.*@db3.*$')   

    if db3_lst:
        new_db3_lst = []
        new_db3_cleans = []
        for db3 in db3_lst: 
            new_db3 = re.sub(r'^.*@db3', '', str(db3))
            new_db3 = new_db3[:-1]
            new_db3 = new_db3.lstrip()
            new_db3_lst.append(new_db3)
            new_db3_clean = get_filename(new_db3)
            new_db3_cleans.append(new_db3_clean)

        self.setStyleSheet('padding: 3px; background: white');
        item, okPressed = QInputDialog.getItem(self, "leo4sqlite","choose internal database.", new_db3_lst, 0, False)
        if not okPressed:
            raise NoInternalDBsError
            return
        else:
            c._leo4sqlite['db_filename'] = item


</t>
<t tx="tsc.20180209234613.22">@language python

def select_table(self, c):

    db_filename = c._leo4sqlite['db_filename']
    tbl_names = []
  
    conn = sqlite3.connect(db_filename)
    res = conn.execute("SELECT name FROM sqlite_master WHERE type='table';")
    
    tbl_nm_str = ''
    for name in res:
        if name[0] != "sqlite_sequence":
            tbl_names.append(name[0])
            tbl_nm_str += "\"" + name[0] + "\", "
        tbl_nm_str = tbl_nm_str[:-3] + "\""
    
    self.setStyleSheet('padding: 3px; background: white');
    item, okPressed = QInputDialog.getItem(self, "leo4sqlite","select a table: ", tbl_names, 0, False)    
    if not okPressed:
            raise UserCancel()
            return
            
    c._leo4sqlite['table_name'] = item
    c._leo4sqlite['tbl_names'] = tbl_names

</t>
<t tx="tsc.20180209234613.23">@language python

def get_blob_col(self, c):
    
    col_nums = []
    col_names = []
    col_types = []
    num_cols = 0
    file_col = 0
    blob_col = 0
    ext_col = 0
    
    db_filename = c._leo4sqlite['db_filename']
    table_name = c._leo4sqlite['table_name']

    conn = sqlite3.connect(db_filename)
    cur = conn.cursor()
    
    ix = 0
    for row in cur.execute("pragma table_info(" + table_name + ")").fetchall():
    
        col_nums.append(str(row[0]))
        col_names.append(str(row[1]))
        col_types.append(str(row[2]))
    
        if row[2] == "BLOB":
            blob_col = ix
        
        if row[1] == "Filename":
            file_col = ix
        
        if row[1] == "Extension":
            ext_col = ix    
        
        ix = ix + 1
    
    num_cols += len(col_nums) # tnb
    
    c._leo4sqlite['num_cols'] = num_cols
    c._leo4sqlite['col_names'] = col_names
    c._leo4sqlite['col_types'] = col_types
    c._leo4sqlite['col_nums'] = col_nums
    c._leo4sqlite['blob_col'] = blob_col
    c._leo4sqlite['file_col'] = file_col
    c._leo4sqlite['ext_col'] = ext_col
</t>
<t tx="tsc.20180209234613.24">@language python

def insert_blob(self, c):
    
    def place_holder(line):
        return '({})'.format(', '.join('?' * len(line)))
    
    col_vals = []
    
    db_filename = c._leo4sqlite['db_filename']
    table_name = c._leo4sqlite['table_name']
    col_names = c._leo4sqlite['col_names']
    
    str_col_names = str(col_names)
    str_col_names = str_col_names[1:-1]

    for i in range(len(col_names)):
        if col_names[i] != "Blobs" and col_names[i] != "Filename" and col_names[i] != "Extension":
            text, okPressed = QInputDialog.getText(self, table_name, col_names[i], QLineEdit.Normal, "")
            if okPressed and text != '':
                col_vals.append(text)
    
    str_col_names = str(col_names)
    str_col_names = str_col_names[1:-1]
                
    options = QFileDialog.Options()
    self.setStyleSheet('padding: 3px; background: white');
    blob_filepath, _ = QFileDialog.getOpenFileName(self,"select file to insert:", "","binary files (*)", options=options)
    
    full_filename = os.path.basename(blob_filepath)
    filename, extension = os.path.splitext(full_filename)

    conn = sqlite3.connect(db_filename)
    cursor = conn.cursor()
    
    with open(blob_filepath, "rb") as input_file:
        ablob = input_file.read()
        cells = col_vals
        cells.append(sqlite3.Binary(ablob))
        cells.append(filename)
        cells.append(extension)
        plh = place_holder(cells)
                        
        cursor.execute("insert into " + table_name + " values {} ".format(plh), cells)
        conn.commit()
        
        g.es("\ndone\n")
</t>
<t tx="tsc.20180209234613.25">@language python

def extract_blob(self, c):
    
    ablob = []
    search_items = []

    file_col = c._leo4sqlite['file_col']
    ext_col = c._leo4sqlite['ext_col']
    blob_col = c._leo4sqlite['blob_col']
    col_names = c._leo4sqlite['col_names']
    table_name = c._leo4sqlite['table_name']
    db_filename = c._leo4sqlite['db_filename']

    sqlite_out_dir = c.config.getString("sqlite_output_dir")
    
    if not sqlite_out_dir:
        raise NoOutputDirectory
        return
    
    sqlite_out_dir = sqlite_out_dir[1:-1]
    
    items = (col_names)
    self.setStyleSheet('padding: 3px; background: white');
    item, okPressed = QInputDialog.getItem(self, "leo4sqlite","select column to search:", items, 0, False)
    
    search_col = item
    
    items = []    
    self.setStyleSheet('padding: 3px; background: white');
    item, okPressed = QInputDialog.getItem(self, "leo4sqlite","choose a search term:", items, 0, False)
    
    search_term = item
    
    conn = sqlite3.connect(db_filename)
    cursor = conn.cursor()
    
    i = 0
    for row in cursor.execute("SELECT * FROM " + table_name):
        if col_names[i] == search_col:
            search_items.append(row[i])
    
    cursor.execute("select * from %s where %s = ?" % (table_name, search_col), [search_term]) # tnb
    row = cursor.fetchone()
    filename = os.path.basename(row[file_col])
    extension = row[ext_col]
    
    
    filepath = sqlite_out_dir + '/' + filename + extension
    
    with open(filepath, "wb") as output_file:   
        cursor.execute("select * from %s where %s = ?" % (table_name, search_col), [search_term]) # tnb
        ablob = cursor.fetchone()
        output_file.write(ablob[blob_col])
        cursor.close()
    
    conn.close()
    g.es("\ndone\n")
</t>
<t tx="tsc.20180209234613.26">@language python

def open_blob(self, c):
    
    items = []
    
    ext_col = c._leo4sqlite['ext_col']
    blob_col = c._leo4sqlite['blob_col']
    file_col = c._leo4sqlite['file_col']
    col_names = c._leo4sqlite['col_names']
    table_name = c._leo4sqlite['table_name']
    db_filename = c._leo4sqlite['db_filename']
    
    sqlite_temp_dir = c.config.getString('sqlite_temp_dir')
    
    if not sqlite_temp_dir:
        raise NoTempDirectory
        return
    
    
    
    p = g.findNodeAnywhere(c, '@data external tools')
    c.selectPosition(p)
    tools = re.split(r'\n', p.b)
    tools = tools[2:-1]
    c.selectThreadBack()
    c.redraw()
    
    items = (col_names)
    self.setStyleSheet('padding: 3px; background: white');
    item, okPressed = QInputDialog.getItem(self, "leo4sqlite","select column to search:", items, 0, False)
    search_col = item
    
    items = []
    self.setStyleSheet('padding: 3px; background: white');
    item, okPressed = QInputDialog.getItem(self, "leo4sqlite","choose a search term:", items, 0, False)
    search_term = item
                          
    self.setStyleSheet('padding: 3px; background: white');
    item, okPressed = QInputDialog.getItem(self, "leo4sqlite","select external tool:", tools, 0, False)
    ext_tool = item
    
    conn = sqlite3.connect(db_filename)
    cursor = conn.cursor()
    
    cursor.execute("select * from %s where %s = ?" % (table_name, search_col), [search_term])
    row = cursor.fetchone()
    filename = row[file_col]
    filename = os.path.basename(filename)
    extension = row[ext_col]

    filepath = (sqlite_temp_dir + '//' + filename + extension)

    with open(filepath, "wb") as output_file:        
        cursor.execute("select * from %s where %s = ?" % (table_name, search_col), [search_term])
        ablob = cursor.fetchone()
        output_file.write(ablob[blob_col])
        cursor.close()

        p = subprocess.Popen([ext_tool, filepath])
</t>
<t tx="tsc.20180209234613.27">@language python

def view_blob(self, c):

    img_types = ['.png', '.jpg', '.bmp', '.gif']
    vid_types = ['.mp4', '.avi', '.wmv', '.flv', '.mov', '.mkv']
    
    file_col = c._leo4sqlite['file_col']
    ext_col = c._leo4sqlite['ext_col']
    blob_col = c._leo4sqlite['blob_col']
    col_names = c._leo4sqlite['col_names']
    
    table_name = c._leo4sqlite['table_name']
    db_filename = c._leo4sqlite['db_filename']
    
    temp_dir = c.config.getString("sqlite_temp_dir")
    if not temp_dir:
        raise NoTempDirectory
        return
        
    temp_dir = temp_dir[1:-1]
    
    def get_extension(path):
        extension = os.path.splitext(path)[1]
        return extension
    
    def get_filename(path):
        filename = os.path.basename(path)
        return filename    
        
    items = col_names
    self.setStyleSheet('padding: 3px; background: white');
    col, okPressed = QInputDialog.getItem(self, "leo4sqlite","select column to search:", items, 0, False)
    search_col = col
    
    items = []
    self.setStyleSheet('padding: 3px; background: white');
    term, okPressed = QInputDialog.getItem(self, "leo4sqlite","choose a search term:", items, 0, False)
    search_term = term
    
    ablob = []
    
    conn = sqlite3.connect(db_filename)
    cursor = conn.cursor()
    
    cursor.execute("select * from %s where %s = ?" % (table_name, search_col), [search_term]) 
    row = cursor.fetchone()
    filename = row[file_col]
    extension = row[ext_col]

    filepath = temp_dir + "/" + filename + extension

    with open(filepath, "wb") as output_file:               
        cursor.execute("select * from %s where %s = ?" % (table_name, search_col), [search_term]) 
        ablob = cursor.fetchone()
        output_file.write(ablob[blob_col])
        cursor.close()
        
        if extension in img_types: 
            ph2b =  (r"@image " + filename + extension)
        if extension in vid_types:
            ph2b =  (r"@movie " + filename + extension)
            
        p = g.findNodeAnywhere(c, "temp")
        c.selectPosition(p)
        
        for child in p.children():
            if child.h == ph2b:
                c.selectPosition(child)
                c.executeMinibufferCommand('vr-show')
                raise NodeExists()
                return
        
        p = p.insertAsLastChild()
        c.selectPosition(p)
        p.h = ph2b
        p.b = filepath
        
        c.executeMinibufferCommand('vr-show')
        c.redraw()
        p = p.parent() 
        c.redraw()    
</t>
<t tx="tsc.20180209234613.28">@language python

def edit_blob(self, c):
    
    def place_holder(line):
        return '({})'.format(', '.join('?' * len(line)))
        
    col_names = c._leo4sqlite['col_names']
    table_name = c._leo4sqlite['table_name']
    db_filename = c._leo4sqlite['db_filename']
    
    names = []

    self.setStyleSheet('padding: 3px; background: white');
    name, okPressed = QInputDialog.getItem(self, "leo4sqlite","enter blob name:", names, 0, False)
    blob_name = name
    
    cols = (col_names)

    self.setStyleSheet('padding: 3px; background: white');
    col, okPressed = QInputDialog.getItem(self, "leo4sqlite","select column name:", cols, 0, False)
    edit_col = col
    
    values = []
    
    self.setStyleSheet('padding: 3px; background: white');
    value, okPressed = QInputDialog.getItem(self, "leo4sqlite", "enter new value:", values, 0, False)
    new_val = value
    
    conn = sqlite3.connect(db_filename)
    cursor = conn.cursor()
    
    cursor.execute("update %s set %s = %s where Filename = ?" % (table_name, edit_col, new_val), [blob_name])
    conn.commit()

    g.es('done')
</t>
<t tx="tsc.20180209234613.29">@language python

def get_layout(self, c):
    
    action = c._leo4sqlite['action']
    table_name = c._leo4sqlite['table_name']    
    
    if action == 'import table':
        items = ('one', 'two', 'three', 'four')
        self.setStyleSheet('padding: 3px; background: white');
        item, okPressed = QInputDialog.getItem(self, "leo4sqlite","choose a layout: ", items, 0, False)
        if not okPressed:
            raise UserCancel
            return

        c._leo4sqlite['layout'] = item

    if action == 'export table':
        tbl_h = "@tbl " + str(table_name)
        p = g.findNodeAnywhere(c, tbl_h)
        c.selectPosition(p)
        lines = re.split(r'\n', p.b)
        line = lines[5]
        layout = line[8:]
        c._leo4sqlite['layout'] = layout
        g.es('layout: ' + str(layout))
</t>
<t tx="tsc.20180209234613.30">@language python

def grand_central(self, c):
    
    db_filename = c._leo4sqlite['db_filename']
    col_names = c._leo4sqlite['col_names']
    col_nums = c._leo4sqlite['col_nums']
    col_types = c._leo4sqlite['col_types']
    blob_col = c._leo4sqlite['blob_col']
    layout = c._leo4sqlite['layout']
    action = c._leo4sqlite['action']
        
    if action == "export blobs":
        export_blobs(self, c)  # , col_nums, col_names, col_types, blob_col)
        return
        
    db3_h = "@db3 " + str(db_filename)
    p = g.findNodeAnywhere(c, db3_h)
    
    if p:
        c.selectPosition(p)
    else:    
        p = c.lastTopLevel().insertAsNthChild(1)
        p.h = "@db3 " + str(db_filename)
        c.redraw(p)
    
    p = p.insertAsNthChild(1)
    p.h = "@tbl " + str(c._leo4sqlite['table_name'])
    c.selectPosition(p)
    c.redraw(p)
    
    if action == "import blobs":   
        p = p.lastNode()
        c.selectPosition(p)
        import_blobs(self, c, p, col_nums, col_names, col_types, blob_col)
    
    if action == "import table" and blob_col:
        raise TableIsBlobTable
        return
        
    if action == "import table":
        if layout == "one":
            import_table1(c, p, col_nums, col_names, col_types, blob_col)
    
        if layout == "two":
            import_table2(c, p, col_nums, col_names, col_types, blob_col)
            
        if layout == "three":
            import_table3(c, p, col_nums, col_names, col_types, blob_col)
        
        if layout == "four":
            import_table4(c, p, col_nums, col_names, col_types, blob_col)
               
    
    if action == 'export table' and blob_col:
        raise TableIsBlobTable
        return
        
        p = c.p
            
        if layout == "one":
            export_table1(self, c, p, col_nums, col_names, col_types, blob_col)
        
        if layout == "two":
            export_table2(self, c, p, col_nums, col_names, col_types, blob_col)
            
        if layout == "three":
            export_table3(self, c, p, col_nums, col_names, col_types, blob_col)
            
        if layout == "four": 
            export_table4(self, c, p, col_nums, col_names, col_types, blob_col)
</t>
<t tx="tsc.20180209234613.31">@language python

def import_table1(c, p, col_nums, col_names, col_types, blob_col):

    table_name = c._leo4sqlite['table_name']
    filepath = c._leo4sqlite['db_filename']
    layout = c._leo4sqlite['layout']
    
    num_cols = 0
    for col in col_nums:
        num_cols = num_cols + 1
    
    g.es("\nimporting table: " + table_name + "\n\n(layout 1)\n")
                    
    rx = 0
    delim = ", "
    new_row = ""
    
    p.b = p.b + "filepath: " + str(filepath) + "\n\n"
    p.b = p.b + str(col_names) + "\n"
    p.b = p.b + str(col_types) + "\n\n"
    p.b = p.b + str("layout: " + layout) + "\n\n"

    conn = sqlite3.connect(filepath)
    cursor = conn.cursor()
    for row in cursor.execute("SELECT * FROM " + table_name):
    
        cx = 0 
        if row != "":
            cols = re.split(delim, str(row))

            ix = 0
            for col in cols:
                if col != "":
                    new_row = new_row + col + ", "
                    cx = cx + 1
                new_row = re.sub(r'[\"]', " ", str(new_row))   
                                
            p.b = p.b + str(new_row[1:-3]) + "\n"
            new_row = ""
            rx = rx + 1       
    
    g.es("done\n")
    c.redraw()
    headline = ("@tbl " + table_name)    
    tbl_node = g.findNodeAnywhere(c, (headline))
    c.selectPosition(tbl_node)
</t>
<t tx="tsc.20180209234613.32">@language python

def import_table2(c, p, col_nums, col_names, col_types, blob_col):

    db_filename = c._leo4sqlite['db_filename']
    table_name = c._leo4sqlite['table_name']
    layout = c._leo4sqlite['layout']

    num_cols = 0
    for col in col_nums:
        num_cols = num_cols + 1
    
    idx = 0
    rx = 0
    
    p.b = p.b + "filepath: " + str(db_filename) + "\n\n"
    p.b = p.b + str(col_names) + "\n"
    p.b = p.b + str(col_types) + "\n\n"
    p.b = p.b + 'layout: ' + layout + '\n\n'
    
    g.es("\nimporting table: " + table_name + "\n\n(layout 2)\n")

    rows = []
    
    conn = sqlite3.connect(db_filename)
    cursor = conn.cursor()
    for row in cursor.execute("SELECT * FROM " + table_name):    
        rows.append(row)
    
        idx = idx + 1  
        if idx == 1:
            p = p.insertAsNthChild(1)
            c.selectPosition(p)
        else:
            p = p.insertAfter()
            c.selectPosition(p)

        delim = ","
        new_row = ""
        
        rx = rx + 1
        if row != "":
            cols = re.split(delim, str(row))
            for col in cols:
                new_row = new_row + col + ","
            new_row = re.sub(r'[\"\'\s]', "", str(new_row))
            final_row = re.sub(r',', ", ", str(new_row))
        p.h = str(final_row[1:-3])
    
    g.es("\ndone\n")
    c.redraw()        
    headline = ("@tbl " + table_name)
    tbl_node = g.findNodeAnywhere(c, (headline))
    c.selectPosition(tbl_node)
</t>
<t tx="tsc.20180209234613.33">@language python

def import_table3(c, p, col_nums, col_names, col_types, blob_col):

    db_filename = c._leo4sqlite['db_filename']
    table_name = c._leo4sqlite['table_name']
    layout = c._leo4sqlite['layout']
    
    g.es("\nimporting table: " + table_name + "\n\n(layout 3)\n")

    conn = sqlite3.connect(db_filename)
    conn.row_factory = sqlite3.Row
    cursor = conn.execute("select * from " + table_name)
    row = cursor.fetchone()
    names = row.keys()

    rx = 0
    cx = 0
    num_cols = 0

    p.b = p.b + "filepath: " + str(db_filename) + "\n\n"
    p.b = p.b + str(col_names) + "\n"
    p.b = p.b + str(col_types) + "\n\n"    
    p.b = p.b + 'layout: ' + layout + '\n\n'

    for col_num in col_nums:
        num_cols = num_cols + 1
    
    cx = 0
    for col_name in names:
        if cx == 0:
            p = p.insertAsLastChild()
        else:
            p = p.insertAfter()
        
        p.h = col_name
        c.redraw()
        
        rx = 0
        rows = []
        for row in cursor.execute("SELECT * FROM " + table_name):
            rows.append(str(row[cx]))
            p.b = p.b + (str(row[cx]) + "\n")
            rx = rx + 1            
            
        cx = cx + 1

    g.es("done\n")
        
    c.redraw()
    headline = ("@tbl " + table_name)    
    tbl_node = g.findNodeAnywhere(c, (headline))
    c.selectPosition(tbl_node)
</t>
<t tx="tsc.20180209234613.34">@language python

def import_table4(c, p, col_nums, col_names, col_types, blob_col):

    db_filename = c._leo4sqlite['db_filename']
    table_name = c._leo4sqlite['table_name']
    layout = c._leo4sqlite['layout']
    
    g.es("\nimporting table: " + table_name + "\n\n(layout 4)\n")

    num_cols = 0
    for col_num in col_nums:
        num_cols = num_cols + 1

    idx = 0

    p.b = p.b + "filepath: " + str(db_filename) + "\n\n"
    p.b = p.b + str(col_names) + "\n"
    p.b = p.b + str(col_types) + "\n\n"
    p.b = p.b + 'layout: ' + layout + '\n\n'
    
    for col_name in col_names:
        if idx == 0:
            p = p.insertAsLastChild()
        else:
            p = p.insertAfter()
            
        p.h = col_name
    
        i = 0
        rx = 0
        cx = 0
        rows = []
        
        conn = sqlite3.connect(db_filename)
        cursor = conn.cursor()
        cursor.execute("select * from " + table_name)
        results = cursor.fetchall()
        num_rows = len(results)
        
        while rx &lt; num_rows:
            for row in cursor.execute("select * from " + table_name):
                if i == 0:
                    p = p.insertAsLastChild()
                else:
                    p = p.insertAfter()
                            
                new_row = re.sub(r'[\(\)\"]', " ", str(row))
                new_row = new_row.lstrip()
                new_row = re.split(r',', new_row)
                rows.append(new_row)
                
                p.h = str(rows[rx][cx + idx])
                
                i = i + 1
                rx += 1

            p = p.parent()   
            if idx &gt;= num_rows:
                break
            new_row = re.sub(r'[\[\]\'\"\s]', "", str(rows[idx]))        
            new_row = re.sub(r',', ", ", new_row) 
            cx += 1
        idx += 1
    
    p = p.parent()
    p.contract()

    g.es("done\n")
    c.redraw()
    headline = ("@tbl " + table_name)
    tbl_node = g.findNodeAnywhere(c, (headline))
    c.selectPosition(tbl_node)

</t>
<t tx="tsc.20180209234613.35">@language python

def export_table1(self, c, p, col_nums, col_names, col_types, blob_col):
    
    def place_holder(line):
        return '({})'.format(', '.join('?' * len(line)))
    
    table_name = c._leo4sqlite['table_name']

    headline = ("@tbl " + table_name)
    tbl_node = g.findNodeAnywhere(c, (headline))        
    c.selectPosition(tbl_node)
    c.redraw()
    p = c.p
    
    g.es("\nexporting table " + table_name + "\n\n(layout 1)\n")

    lines = re.split("\n", p.b)

    new_names = re.sub(r'[\"\'\[\]\s]', "", str(col_names))
    new_types = re.sub(r'[\"\'\[\]\s]', "", str(col_types))

    split_names = re.split(r',', str(new_names))
    split_types = re.split(r',', str(new_types))
    
    sql = "("
    for i in range(len(split_names)):
        sql = sql + split_names[i] + " " + split_types[i] + ", "
    sql = sql[:-2]
    sql = sql + (")")

    lines = lines[7:]
    
    db_filename = c._leo4sqlite['db_filename']
    
    conn = sqlite3.connect(db_filename)
    cur = conn.cursor()

    statement = "SELECT name FROM sqlite_master WHERE type='table';"
    if (table_name,) in cur.execute(statement).fetchall():
        overwrite = g.app.gui.runAskYesNoDialog(c, "overwrite existing table?", message="a table by that name already exists.\nreplace it with current table?") 
        if overwrite == "no":
            print("cancelled\n")
            return
        print("table: '%s' exists" % table_name)
        cur.execute("DROP TABLE " + table_name)
        print("\ndropping old table")
    cur.execute("CREATE TABLE " + table_name + " " + sql)
    print("creating new table")

    for line in lines:    
        if line != "":
            cells = re.split(",", line)         
            plh = place_holder(cells)
            cur.execute("insert into " + table_name + " values {} ".format(plh), cells)
            conn.commit()
        else:
            g.es("\ndone\n")
            return
</t>
<t tx="tsc.20180209234613.36">@language python

def export_table2(self, c, p, col_nums, col_names, col_types, blob_col):
    
    hlines = []
    table_name = c._leo4sqlite['table_name']
    db_filename = c._leo4sqlite['db_filename']
   
    def place_holder(line):
        return '({})'.format(', '.join('?' * len(line)))

    g.es("\nexporting table: " + table_name + "\n\n(layout 2)\n") 

    headline = ("@tbl " + table_name)
    tbl_node = g.findNodeAnywhere(c, (headline))
    c.selectPosition(tbl_node)
    c.redraw()
    p = c.p
    lines = re.split(r"\n", p.b)
    names = lines[2]
    types = lines[3]
    
    for p in p.children():
        hlines.append(p.h)
    
    new_names = re.sub(r'[\"\'\[\]\s]', "", str(names))
    new_types = re.sub(r'[\"\'\[\]\s]', "", str(types))
    
    split_names = re.split(r',', str(new_names))
    split_types = re.split(r',', str(new_types))

    sql = "("
    for i in range(len(split_names)):
        sql = sql + split_names[i] + " " + split_types[i] + ", "
    sql = sql[:-2]
    sql = sql + (")")

    lines = lines[7:]
    
    conn = sqlite3.connect(db_filename)
    cur = conn.cursor()

    statement = "SELECT name FROM sqlite_master WHERE type='table';"
    if (table_name,) in cur.execute(statement).fetchall():
        overwrite = g.app.gui.runAskYesNoDialog(c, "overwrite existing table?", message="a table by that name already exists.\nreplace it with current table?") 
        if overwrite == "no":
            print("cancelled\n")
            return
        print("table: '%s' exists" % table_name)
        cur.execute("DROP TABLE " + table_name)
        print("\ndropping old table")
    cur.execute("CREATE TABLE " + table_name + " " + sql)
    print("creating new table")
    
    for line in hlines:    
        if line != "":
            cells = re.split(",", line)
            
            plh = place_holder(cells)
            cur.execute("insert into " + table_name + " values {} ".format(plh), cells)
            conn.commit()
    g.es("\ndone\n")
</t>
<t tx="tsc.20180209234613.37">@language python

def export_table3(self, c, p, col_nums, col_names, col_types, blob_col):

    def place_holder(line):
        return '({})'.format(', '.join('?' * len(line)))

    table_name = c._leo4sqlite['table_name']
    db_filename = c._leo4sqlite['db_filename']
    layout = c._leo4sqlite['layout']
    
    g.es("\nexporting table: " + table_name + "\n\n(layout 3)\n") 
    headline = ("@tbl " + table_name)
    tbl_node = g.findNodeAnywhere(c, (headline))
    c.selectPosition(tbl_node)
    c.redraw()
    p = c.p
    lines = re.split(r'\n', str(p.b))
    names = lines[2]
    types = lines[3]

    new_names = re.sub(r'[\"\'\[\]\s]', "", str(names))
    new_types = re.sub(r'[\"\'\[\]\s]', "", str(types))
    split_names = re.split(r',', str(new_names))
    split_types = re.split(r',', str(new_types))

    row = []
    rows = []
    cols = []
    num_rows = 0
    num_cols = 0
    split_blines = []
    clean_blines = []
      
    for p in p.children():

        split_blines = re.split(r'\n', p.b)
        num_rows = (len(split_blines))
        clean_blines = re.sub(r'[\'\[\]\s]', "", str(split_blines))
        clean_blines = clean_blines[:-1]
        clean_blines = re.split(r',', clean_blines)
        cols.append(clean_blines)
        num_cols = num_cols + 1
    
    sql = "("
    for i in range(len(split_names)):
        sql = sql + split_names[i] + " " + split_types[i] + ", "
    sql = sql[:-2]
    sql = sql + (")")

    lines = lines[7:]

    conn = sqlite3.connect(db_filename)
    cur = conn.cursor()

    statement = "SELECT name FROM sqlite_master WHERE type='table';"
    if (table_name,) in cur.execute(statement).fetchall():
        overwrite = g.app.gui.runAskYesNoDialog(c, "overwrite existing table?", message="a table with that name already exists.\nreplace it with current table?") 
        if overwrite == "no":
            print("cancelled\n")
            return
        print("table: '%s' exists" % table_name)
        cur.execute("DROP TABLE " + table_name)
        print("\ndropping old table")
    cur.execute("CREATE TABLE " + table_name + " " + sql)
    print("creating new table")
    
    x = 0
    z = 0
    row = []
    rows = []
    while x &lt; num_rows - 1:
        for i in range(len(cols)):
            row.append((cols[i][x]))
        row = re.sub(r'[\[\]\'\"\s]', "", str(row))
        row = re.sub(r',', ", ", row) 
        row = re.split(r',', row)
        cells = row[:int(num_cols)]
        plh = place_holder(cells)
        cur.execute("insert into " + table_name + " values {} ".format(plh), cells)
        conn.commit()
        rows = rows[num_cols:]
        z += 1

        rows.append(row)
        row = row[num_cols:]
        x += 1    
    
    row = rows[0][:num_cols]
    row = rows[0][num_cols:num_cols * num_rows]
    
    row = row[num_cols:]
            
    g.es("\ndone\n")
</t>
<t tx="tsc.20180209234613.38">@language python

def export_table4(self, c, p, col_nums, col_names, col_types, blob_col):
    
    def place_holder(line):
        return '({})'.format(', '.join('?' * len(line)))

    col_hlines = []
    row_hlines = []
    
    db_filename = c._leo4sqlite['db_filename']
    table_name = c._leo4sqlite['table_name']
    
    g.es("\nexporting table: " + table_name + "\n\n(layout 4)\n") 
    headline = ("@tbl " + table_name)
    tbl_node = g.findNodeAnywhere(c, (headline))
    c.selectPosition(tbl_node)
    c.redraw()
    p = c.p
    
    lines = re.split(r'\n', str(p.b))
  
    for p in p.children():
        col_hlines.append(p.h)
        for p in p.children():
            row_hlines.append(p.h)

    num_cols = len(col_hlines)
    num_rows =int(len(row_hlines) / num_cols)

    new_names = re.sub(r'[\"\'\[\]\s]', "", str(col_names))
    new_types = re.sub(r'[\"\'\[\]\s]', "", str(col_types))
    
    split_names = re.split(r',', str(new_names))
    split_types = re.split(r',', str(new_types))
    
    sql = "("
    for i in range(len(split_names)):
        sql = sql + split_names[i] + " " + split_types[i] + ", "
    sql = sql[:-2]
    sql = sql + (")")
    
    lines = lines[7:]
    
    conn = sqlite3.connect(db_filename)
    cur = conn.cursor()
    
    statement = "SELECT name FROM sqlite_master WHERE type='table';"
    if (table_name,) in cur.execute(statement).fetchall():
        overwrite = g.app.gui.runAskYesNoDialog(c, "overwrite existing table?", message="a table by that name already exists.\nreplace it with current table?") 
        if overwrite == "no":
            print("cancelled\n")
            return
        print("table: '%s' exists" % table_name)
        cur.execute("DROP TABLE " + table_name)
        print("\ndropping old table")
    cur.execute("CREATE TABLE " + table_name + " " + sql)
    print("creating new table\n")
    
    i = 0
    x = 0
    row = []
    lines = []
    while x &lt; num_rows:
        for i in range(len(col_hlines)):
            row.append(row_hlines[i * num_rows + x])
            i += num_cols
        if row:
            plh = place_holder(row)
            cur.execute("insert into " + table_name + " values {} ".format(plh), row)
            conn.commit()
        row = row[num_cols:]
        x+= 1
    
    g.es("done\n")
</t>
<t tx="tsc.20180209234613.39">@
def import_blobs(self, c, p, col_nums, col_names, col_types, blob_col):
    
    table_name = c._leo4sqlite['table_name']
    filepath = c._leo4sqlite['db_filename']
    
    num_cols = 0
    for col in col_nums:
        num_cols = num_cols + 1
 
    filename_col = num_cols - 2
    extension_col = num_cols -1
    
    g.es("\nimporting blob table: " + table_name + "\n")
         
    delim = ", "
    new_row = ""
    
    #p.b = p.b + "filepath: " + str(filepath) + "\n\n"
    p.b = p.b + str(col_names) + "\n"
    p.b = p.b + str(col_types) + "\n\n"
    
    conn = sqlite3.connect(filepath)
    cursor = conn.cursor()
    for row in cursor.execute("SELECT * FROM " + table_name):
    
        rx = 0 
        if row != "":
            cols = re.split(delim, str(row))

            cx = 0
            for col in cols:
                if col != "" and col_types[cx] != "BLOB":
                    if cx == 0: col = col[1:]
                    new_row = new_row + col_names[cx] + ": " + col + "\n"
                    cx = cx + 1
                new_row = re.sub(r'[\"]', " ", str(new_row))   
             
            if rx &lt; 3:                    
                p = p.insertAsLastChild()
                cx = 0
            else:
                p = p.insertAfter()
            
            rx + 1
                
            c.selectPosition(p)
            p.h = row[filename_col] + row[extension_col]
            #p.b = p.b + str(filepath) + "\n\n"
            p.b = p.b + str(new_row[:-1]) + "\n"
            new_row = ""

    g.es("done\n")
    c.redraw()
    headline = ("@tbl " + table_name)    
    tbl_node = g.findNodeAnywhere(c, (headline))
    c.selectPosition(tbl_node)
</t>
<t tx="tsc.20180209234613.41">@language python

def delBlobs(c): 
    
    del_blobs_on_exit = c.config.getBool('del_blobs_on_exit')
    
    if del_blobs_on_exit == 1:
        sqlite_temp_dir = c.config.getString('sqlite_temp_dir') 
            
        os.chdir(sqlite_temp_dir)
        files=glob.glob('*')
        if files:
            for filename in files:
                os.unlink(filename)
</t>
<t tx="tsc.20180209234613.42">@language python

@g.command('sqlite-make-template')
def sqlite_make_template(event):
    
    template = [
        ("@settings", "Please customize...", [
            ("@string sqlite_temp_dir = ~/leo4sqlite-temp", "Enter the full path...", []),
            ("@string sqlite_output_dir = ~/leo4sqlite-output", "Enter the full path.", []),
            ("@bool del_blobs_on_exit = False", "Delete blobs extracted for viewing.", []),
            ("@data external tools", "# leave one blank line at the end of this body text\n\nExamples for linux:\n\n/usr/bin/gimp\n/usr/bin/xviewer\n", []),
            ("@commands", "Examples of hotkeys. Command names are in the docstring.", [
                ("@command sqlite-clear-temp @key Alt-Shift-Ctrl-t", "c.executeMinibufferCommand('sqlite-clear-temp'", [
                    ("@test child", "something", []),
                    ("@test child2", "something else", []),
                ]),
                ("@command sqlite-delete-data @key Alt-Shift-Ctrl-d", "c.executeMinibufferCommand('sqlite-delete-data')", []),
                ("@command sqlite-purge-files @key Alt-Shift-Ctrl-p", "c.executeMinibufferCommand('sqlite-purge-files')", []),
            ]),
        ]),
        ("temp", "Clean up temporary nodes.", []),
        ("data", "This node must be the last top level node.", []),
    ]
    
    c = event.get('c')
    c = c.new({}, gui=g.app.gui)
    
    p = c.p
    p.h = "leo4sqlite template"
    
    def mknode(nd, data):
        head, body, children = data
        nd.h = head
        nd.b = body
        for child in children:
            mknode(nd.insertAsLastChild(), child)
    
    for data in reversed(template):
        mknode(p.insertAfter(), data)
   
    c.redraw()
</t>
<t tx="tsc.20180209234613.43">@language python

@g.command('sqlite-import-table')
def sqlite_import_table(event):
    
    c = event.get('c')
    
    action = "import table"
    c._leo4sqlite['action'] = action

    InputDialogs(c)
</t>
<t tx="tsc.20180209234613.44">@language python

@g.command('sqlite-export-table')
def sqlite_export_table(event):
    
    c = event.get('c')
    
    action = "export table"
    c._leo4sqlite['action'] = action
    
    InputDialogs(c)
</t>
<t tx="tsc.20180209234613.45">@language python

@g.command('sqlite-import-blobs')
def sqlite_import_blobs(event):
    
    c = event.get('c')
    
    c._leo4sqlite['action'] = "import blobs"
    c._leo4sqlite['layout'] = "one"    
    
    InputDialogs(c)

</t>
<t tx="tsc.20180209234613.46">@language python

@g.command('sqlite-export-blobs')
def sqlite_export_blobs(event):
    
    c = event.get('c')
    
    c._leo4sqlite['action'] = "export blobs"
    c._leo4sqlite['layout'] = "one"    
    
    InputDialogs(c)

</t>
<t tx="tsc.20180209234613.47">@language python

@g.command('sqlite-insert-blob')
def sqlite_insert_blob(event):   
    
    c = event.get('c')
    
    action = "insert blob"
    c._leo4sqlite['action'] = action
    
    InputDialogs(c)
    
</t>
<t tx="tsc.20180209234613.48">@language python

@g.command('sqlite-extract-blob')
def sqlite_extract_blob(event):    
    
    c = event.get('c')
    
    action = "extract blob"
    c._leo4sqlite['action'] = action
    
    InputDialogs(c)
    
</t>
<t tx="tsc.20180209234613.49">@language python

@g.command('sqlite-open-blob')
def sqlite_open_blob(event):
    
    c = event.get('c')
    
    action = "open blob"
    c._leo4sqlite['action'] = action
    
    InputDialogs(c)
    
</t>
<t tx="tsc.20180209234613.5">@language python

import leo.core.leoGlobals as g

import glob
import os
import re
import sqlite3
import subprocess

from PyQt5 import QtGui
from PyQt5.QtWidgets import QWidget
from PyQt5.QtWidgets import QLineEdit
from PyQt5.QtWidgets import QFileDialog
from PyQt5.QtWidgets import QInputDialog
from PyQt5.QtWidgets import QDesktopWidget
</t>
<t tx="tsc.20180209234613.50">@language python

@g.command('sqlite-view-blob')
def sqlite_view_blob(event):
    
    c = event.get('c')
    
    action = "view blob"
    c._leo4sqlite['action'] = action
    
    InputDialogs(c)
    
</t>
<t tx="tsc.20180209234613.51">@language python

@g.command('sqlite-edit-blob')
def sqlite_edit_blob(event):

    c = event.get('c')
    
    action = "edit blob"
    c._leo4sqlite['action'] = action
    
    InputDialogs(c)
    
</t>
<t tx="tsc.20180209234613.52">@language python

@g.command('sqlite-clear-temp')
def sqlite_clear_temp(event):
    
    c = event.get('c')

    p = g.findNodeAnywhere(c, 'temp')
    if p:
        c.selectPosition(p)
        p.deleteAllChildren()
        c.redraw()
    else:
        pass
</t>
<t tx="tsc.20180209234613.53">@language python

@g.command('sqlite-delete-data')
def sqlite_delete_data(event):
    
    c = event.get('c')
    
    p_lst = c.find_h('data')
    
    if p_lst[0]:
        c.selectPosition(p_lst[0])
        p_lst[0].doDelete()
        
    p = c.lastTopLevel().insertAfter()
    c.selectPosition(p)
    p.h = "data"
    c.redraw()
</t>
<t tx="tsc.20180209234613.54">@language python

@g.command('sqlite-purge-files')
def sqlite_purge_files(event):
    
    c = event.get('c')
    
    p = g.findNodeAnywhere(c, 'temp')
    c.selectPosition(p)
    p.deleteAllChildren()
    c.redraw()
    
    sqlite_temp_dir = c.config.getString("sqlite_temp_dir")

    os.chdir(sqlite_temp_dir)
    files=glob.glob('*')
    if files:
        for filename in files:
            os.unlink(filename)
</t>
<t tx="tsc.20180209234613.6">@language python

def onCreate (tag, keys):
    
    c = keys.get('c')
    c._leo4sqlite = {}

    g.registerHandler('end1', delBlobs)
</t>
<t tx="tsc.20180209234613.7">@language python

def init ():

    ok = g.app.gui.guiName() in ('qt','qttabs')
    if ok:
        if 1: # Create the commander class *before* the frame is created.
            g.registerHandler('before-create-leo-frame',onCreate)
        else: # Create the commander class *after* the frame is created.
            g.registerHandler('after-create-leo-frame',onCreate)
        g.plugin_signon(__name__)       
    return ok

</t>
<t tx="tsc.20180209234613.8">@language python

class Leo4SqliteError(Exception): pass

@others
</t>
<t tx="tsc.20180209234613.9">class Sqlite3DatabaseError(Leo4SqliteError):
    """File is encrypted or is not a database."""
    
</t>
<t tx="tsc.20180209235407.1">@language python

@others
</t>
<t tx="tsc.20180209235541.1">@language python

@others
</t>
<t tx="tsc.20180209235759.1">@language python

@others
</t>
<t tx="tsc.20180212011016.1">@language python

'''
# version history
# 
# *leo4sqlite.py*
# 
#  **v.010** - first working version of plugin.
# 
#  **v.011** - the import layout is now saved in the @tbl node so the export layout can be chosen automatically.
# 
#  **v.015** - added 'sqlite-clear-data', 'sqlite-reset-temp', and 'sqlite-purge-files'.
# 
#  **v.016** - fixed a bug in 'sqlite-extract-table', thanks to Terry Brown.
# 
#  **v.020** - added command 'sqlite-edit-blob', which enables the user to edit indvidual text columns for a 'blob'.
# 
#  **v.022** - various small fixes and enhancements suggested by Terry Brown
#  
#  **v.023** - dialogs now have the standard Leo icon in the upper-left hand corner.
#  
#  **v.024** - the 'get external database' dialog now has two improved options: 1) all files   or   2) .db .db3 .sqlite .sqlite3
#  
#  **v.026** - added basic error handling
#  
#  **v.029** - added settings to auto-delete temporary blob files on exiting Leo and updated the documentation.
#  
#  **v.030** - removed the unused Leo4SQLiteController node.
# 
#  **v.031** - subclassed custom exceptions instead of creating a separate class for each error.
#  
#  **v.033** - added sqlite-make-template command, which creates a new outline with all all of the standard nodes needed to use the script.
'''
</t>
<t tx="tsc.20180212011036.1">@language python

'''
**leo4sqlite v0.50** - by tscv11
|
 
*Introductisson:*

| The script 'leo4sqlite.py' is a Leo-specific python script that provides
| basic import/export functionality between Leo outlines and sqlite3 tables
| as well as blob support  (insert, extract, search for a blob by any value in
| any column, view the blob in the render pane or open it with external tools). 

| Imported tables are stored internally as part of the outline, while exported
| tables (and blobs) are stored in sqlite3 database files.

| Imported tables appear as children of the "data" node (the last top-level
| node). To clear this node of accumulated imports, use the command
| 'sqlite-delete-data'.
|

**Layouts**

| Four import layouts can be used to arrange the data in various formats. 


| *For all layouts:*

 |    The @db3 node header contains the path to the database file.  
 
 |    The @tbl node contains: 
 
  |        a) The path to the db file
  |        b) The table's column names and types
  |        c) The layout used         
    
| *layout one:*

 The @tbl node contains all of the above and the table itself.
 
| *layout two:*
 
 | The @tbl node has one child for every row in the table. Each
 | child's headline contains one row.
 
| *layout 3:*
 
 | The @tbl node has a child for each column. Each column node
 | contains all values for that column.
 
| *layout 4:*
 
 | The @tbl node has a child for each column - their headers contain
 | the column names. Their children's headlines each contain one
 | value from the appropriate column.
 |
 
*Blobs*

| Blobs are arranged one per row with the other columns in that row
| containing information about them. The last three columns of each row
| are reserved for the blob, the filename, and the extension, in that order.
| Any number of columns may be added  and used to store additional
| information related to the blob (which will precede it in the table).
|

*Development Status:*

| *This script is functional but still needs plenty of bug-fixing and fine-tuning.*
|

**The commands currently added by the plugin are:**
 |
 | sqlite-make-template
 | sqlite-import-table
 | sqlite-export-table
 | sqlite-import-blobs
 | sqlite-insert-blob
 | sqlite-extract-blob
 | sqlite-view-blob
 | sqlite-open-blob
 | sqlite-edit-blob
 | sqlite-clear-temp
 | sqlite-delete-data
 | sqlite-purge-files
 |

**How to import a table:**

1. Select "import table" as the sqlite3 action to perform.
2. Choose an external database file
3. Pick a table
4. Select a layout

| *Your imported table should now appear. You're welcome.*  :-)
|

**How to export a table:**

1. Select "export table" as the sqlite3 action to perform.
2. Choose an internal database from those found under the "data" node.
3. Select a table.
4. The correct layout will be read from the table automatically.

| *Your exported table should now be written to the sqlite3 db file.*
|

**How to insert a blob**

1. Select "insert blob" as the sqlite3 action to perform.
2. Choose the target external database file.
3. Pick a 'blob table' where the blob will be stored.
4. Enter information for each column in that blob's row.

| *The blob should now be written to the database file.*
|

**How to extract a blob**

1. Select "extract blob" as the sqlite3 action to perform.
2. Choose the external database file containing the blob.
3. Pick the table containing the blob.
4. Enter a search column and search term.

|  *The matching blob should now be extracted to the*
|  *output folder you've specified in the @settings tree.*
|

**How to view a blob**

1. Select "view blob" as the sqlite3 action to perform.
2. Choose the external database containing the blob you wish to view.
3. Pick the table containing the blob.
4. Specify a search column and search term.

| *The matching blob should now be extracted to the temp folder you've*
| *chosen (in the @settings tree). An @image node is then created for the*
| *blob and the render pane is opened to view it.*
|

**How to open a blob**

1. Select "open blob" as the sqlite3 action to perform.
2. Choose the external database containing the blob you wish to view.
3. Pick the table containing the blob.
4. Specify a search column and search term.
5. Choose an external tool to use when opening the file.

| *The matching blob should now be extracted to the temp folder you've*
| *chosen (in the @settings tree). The file is then opened with the selected*
| *external tool.*
|

**sqlite-clear-temp**

| To remove all temporary blob nodes from the temp node use this command.
| This leaves the files intact.


**sqlite-delete-data**

| This command removes all children of the 'data' node, where all imports
| appear. Use caution!


**sqlite-purge-files**

| This command deletes *all* physical files from the 'leo4sqlite-temp' directory.
|


**Settings**

| There are now four @settings nodes which should be created and placed
| in either the current outline's @settings tree or in myLeoSettings.leo.

| The nodes are:

| @string sqlite_output_dir = "&lt;path&gt;" -&gt; Output directory for extracted blobs.
| @string sqlite_tem_dir = "&lt;path&gt;"     -&gt; Temporary folder for viewed blobs.
| @bool del_blobs_on_exit = 1 (yes) **or** 0 (no)

| And finally,

| @data external tools - this node holds paths to external tools for use when
| opening blobs. The format is simply one full path per line, ending in the name
| of an executable.
|

**Outline Template**

*leo4sqlite_template.leo*

| Included with this distribution you'll find a template made for leo4sqlite that
| includes the standard nodes you'll need, ready for customization.
'''

def initUI(self, c):
    self.setWindowTitle(self.title)
    self.setGeometry(self.left, self.top, self.width, self.height)
    qtRectangle = self.frameGeometry()
    centerPoint = QDesktopWidget().availableGeometry().center()
    qtRectangle.moveCenter(centerPoint)
    self.move(qtRectangle.topLeft())
    
    self.pick_action(c)
 
    self.show() 
</t>
<t tx="tsc.20180213194315.1">class TableIsBlobTable(Leo4SqliteError):
    """Table is a BLOB table: use 'import-blobs' instead."""
</t>
<t tx="tsc.20180214062647.1">@language python

def import_blobs(self, c, p, col_nums, col_names, col_types, blob_col):

    leo4sqlite = []
    table_name = c._leo4sqlite['table_name']
    filepath = c._leo4sqlite['db_filename']
    
    primary_keys = []

    num_cols = len(col_nums)
    primary_key_col = num_cols - 4
    filename_col = num_cols - 2
    extension_col = num_cols - 1

    g.es("\nimporting blob table: " + table_name)

    p.b += str(col_names) + "\n"
    p.b += str(col_types) + "\n\n"
    node_name = p.h

    g.es(filepath + "\n")

    conn = sqlite3.connect(filepath)
    cursor = conn.cursor()
    
    rx = 0
    for row in cursor.execute("SELECT * FROM " + table_name):

        g.es(str(row[:-3]))

        new_row = ""
        for cx, col in enumerate(row):
            if cx == primary_key_col:
                break
            if col != "" and col_types[cx] != "BLOB":
                new_row += "%s: %s\n" % (col_names[cx], col)

        nd = p.insertAsLastChild()
        nd.h = row[filename_col] + row[extension_col]
        nd.b = new_row
        nd.v.u.setdefault('leo4sqlite', {})['index'] = rx

        rx += 1

    g.es("\ndone\n")
    c.redraw()
    c.selectPosition(g.findNodeAnywhere(c, node_name))
</t>
<t tx="tsc.20180214164152.1"></t>
<t tx="tsc.20180214164152.10">@language python

c.executeMinibufferCommand('sqlite-import-blobs')
</t>
<t tx="tsc.20180214164152.11">@
@@language python

#import_blobs(self, c, p, col_nums, col_names, col_types, blob_col):
#table_name = c._leo4sqlite['table_name']

import re
import sqlite3

child_h = []
child_b = []
col_names = []
col_values = []

p = c.p
parent = p.parent()
c.selectPosition(parent)
table_name = c.p.h[5:]

for child in parent.children():
    child_h.append(child.h)
    child_b = re.split(r'\n', str(child.b))
    blobfile = child_b[0]

filepath = blobfile

num_cols = 0
for col in col_nums:
    num_cols = num_cols + 1

filename_col = num_cols - 2

g.es("\nimporting blob table: " + table_name + "\n")
                
delim = ", "
new_row = ""

#p.b = p.b + "filepath: " + str(filepath) + "\n\n"
p.b = p.b + str(col_names) + "\n"
p.b = p.b + str(col_types) + "\n\n"

conn = sqlite3.connect(filepath)
cursor = conn.cursor()

for row in cursor.execute("SELECT * FROM " + table_name):

    cx = 0 
    if row != "":
        cols = re.split(delim, str(row))

        #ix = 0
        for col in cols:
            if col != "" and col_types[cx] != "BLOB":
                if cx == 0: col = col[1:]
                new_row = new_row + col_names[cx] + ": " + col + "\n"
                cx = cx + 1
            new_row = re.sub(r'[\"]', " ", str(new_row))   
         
        if cx &lt; 3:                    
            p = p.insertAsLastChild()
            cx = 0
        else:
            p = p.insertAfter()
            
        c.selectPosition(p)
        p.h = row[filename_col] + row[extension_col]
        #p.b = p.b + str(filepath) + "\n\n"
        p.b = p.b + str(new_row[:-1]) + "\n"
        new_row = ""

g.es("done\n")
c.redraw()
headline = ("@tbl " + table_name)    
tbl_node = g.findNodeAnywhere(c, (headline))
c.selectPosition(tbl_node)
</t>
<t tx="tsc.20180214164152.14">@language python

c.executeMinibufferCommand('sqlite-edit-blob')
</t>
<t tx="tsc.20180214164152.15">@language python

c.executeMinibufferCommand('sqlite-open-blob')
</t>
<t tx="tsc.20180214164152.16">@
@@language python

'''open the blob whose node is currently selected using an external tool'''        

import re
import sqlite3
import subprocess
import PyQt5
import PyQt5.QtWidgets
from PyQt5.QtWidgets import QInputDialog, QDesktopWidget
    
table_node = p.parent()
c.selectPosition(table_node)
table_name = table_node.h
table_name = re.sub(r'^.*@tbl\s', '', str(table_name))

filename = p.h
lines = re.split(r'\n', p.b)
blobfile = lines[0]
blob_col = 3

sqlite_temp_dir = c.config.getString('sqlite_temp_dir')
if not sqlite_temp_dir:
    raise NoTempDirectory


p = g.findNodeAnywhere(c, '@data external tools')
tools = re.split(r'\n', p.b)
tools = tools[2:-1]
c.selectThreadBack()
c.redraw()

title = 'leo4sqlite - open blob - choose tool'
dlg = QInputDialog()
dlg.setWindowTitle(title)
qtRectangle = dlg.frameGeometry()
centerPoint = QDesktopWidget().availableGeometry().center()
qtRectangle.moveCenter(centerPoint)
dlg.move(qtRectangle.topLeft())

dlg.setStyleSheet('padding: 3px; background: white');
ext_tool, okPressed = dlg.getItem(dlg, "leo4sqlite","select external tool:", tools, 0, False)

conn = sqlite3.connect(blobfile)
cursor = conn.cursor()

cursor.execute("select * from %s where Filename = ?" % (table_name), [filename])
row = cursor.fetchone()

filepath = (sqlite_temp_dir + '//' + filename)
filename = filename[:-4]

with open(filepath, "wb") as output_file:        
    cursor.execute("select * from %s where Filename = ?" % (table_name), [filename])        
    ablob = cursor.fetchone()
    output_file.write(ablob[blob_col])
    cursor.close()

    p = subprocess.Popen([ext_tool, filepath])</t>
<t tx="tsc.20180214164152.17">@language python

''' view the selected blob as a temporary file that can be deleted automatically when Leo closes. This is controlled with a @settings tree node as follows: @bool delete_temp_files = 1: yes | 0: no '''

import re
import sqlite3
import subprocess
import PyQt5
import PyQt5.QtWidgets
from PyQt5.QtWidgets import QInputDialog, QDesktopWidget
    
img_types = ['.png', '.jpg', '.bmp', '.gif']
vid_types = ['.mp4', '.avi', '.wmv', '.flv', '.mov', '.mkv']

#prev_nd = c.p.v
table_node = p.parent()
c.selectPosition(table_node)
table_name = table_node.h
table_name = re.sub(r'^.*@tbl\s', '', str(table_name))
g.es(table_name)
#c.selectPosition(prev_nd)

lines = re.split(r'\n', p.b)
filename = p.h
g.es(filename)
fn_len = len(p.h) - 4
extension = filename[fn_len:]
g.es(extension)
blobfile = lines[0]
g.es(blobfile)
blob_col = 3

temp_dir = c.config.getString("sqlite_temp_dir")
if not temp_dir:
    raise NoTempDirectory    
temp_dir = temp_dir[1:-1]

ext_tools = g.findNodeAnywhere(c, '@data external tools')
tools = re.split(r'\n', ext_tools.b)
tools = tools[2:-1]
    
conn = sqlite3.connect(blobfile)
cursor = conn.cursor()

fn_no_ext = filename[:-4]
g.es(fn_no_ext)

filepath = temp_dir + "/" + filename

ablob = []

with open(filepath, "wb") as output_file:               
    cursor.execute("select * from %s where Filename = ?" % (table_name), [fn_no_ext]) 
    ablob = cursor.fetchone()
    output_file.write(ablob[blob_col])
    cursor.close()
    
    if extension in img_types: 
        ph2b =  (r"@image " + filename)
        g.es(ph2b)
    if extension in vid_types:
        ph2b =  (r"@movie " + filename)
        g.es(ph2b)
        
    p = g.findNodeAnywhere(c, "temp")
    c.selectPosition(p)
    
    for child in p.children():
        if child.h == ph2b:
            c.selectPosition(child)
            c.executeMinibufferCommand('vr-show')
            raise NodeExists()
            break
    
    p = p.insertAsLastChild()
    c.selectPosition(p)
    p.h = ph2b
    p.b = filepath
    
    c.executeMinibufferCommand('vr-show')
    c.redraw()
    p = p.parent() 
    c.redraw()    
</t>
<t tx="tsc.20180214164152.18"># one executable per line

xviewer
gimp-2.8
</t>
<t tx="tsc.20180214164152.19"></t>
<t tx="tsc.20180214164152.2"></t>
<t tx="tsc.20180214164152.20"></t>
<t tx="tsc.20180214164152.21"></t>
<t tx="tsc.20180214164152.22"></t>
<t tx="tsc.20180214164152.23"></t>
<t tx="tsc.20180214164152.3" __bookmarks="7d7100580700000069735f6475706571014930300a732e">#@settings:0--&gt;@buttons:2--&gt;@button import-blobs:0</t>
<t tx="tsc.20180214164152.5" __bookmarks="7d7100580700000069735f6475706571014930300a732e">#Sqlite3:1--&gt;@file /home/tsc/Desktop/leo-editor/leo/plugins/leo4sqlite.py:0</t>
<t tx="tsc.20180214164152.6"></t>
<t tx="tsc.20180214164152.7">@language python

c.executeMinibufferCommand('sqlite-delete-blob')
</t>
<t tx="tsc.20180214164152.8">@language python

c.executeMinibufferCommand('sqlite-insert-blob')
</t>
<t tx="tsc.20180214164152.9">@language python

c.executeMinibufferCommand('sqlite-extract-blob')
</t>
<t tx="tsc.20180214164224.1"></t>
<t tx="tsc.20180216195827.1">@language python

c.executeMinibufferCommand('sqlite-export-blobs')
</t>
<t tx="tsc.20180219220649.1" __bookmarks="7d7100580700000069735f6475706571014930300a732e">#Sqlite3:1--&gt;@file /home/tsc/Desktop/leo-editor/leo/plugins/leo4sqlite.py:0--&gt;export_blobs:10</t>
<t tx="tsc.20180224081154.1">@language python

def export_blobs(self, c): 
    '''export table with any text field changes included.'''
    
    db3s = []
    keys = []
    vals = []
    key_lst = []
    val_lst = []
    child_h = []
    child_b = []
    index = {}
    new_row = ''
    leo4sqlite = []
    db3_name = ''
    defalt = ''
    
    p = c.p
    parent = p.parent()
    c.selectPosition(parent)
    table_name = re.sub(r'^@tbl\s', '', parent.h)
    
    index = db3_tbl_idx(c)
    
    for db3 in index:
    
        if table_name in index[db3]:
            db3_name = db3
            c._leo4sqlite['db_filename'] = db3_name
        else:
            db3s.append(db3)
        
    db3s.insert(0, db3_name)

    self.setStyleSheet('padding: 3px; background: white');
    item, okPressed = QInputDialog.getItem(self, "leo4sqlite","select target database (default: currently selected)", db3s, 0, False)    
    if not okPressed:
            raise UserCancel()
            return
    
    g.es("exporting blob table: " + table_name)
    
    p = p.parent()
    c.selectPosition(p)
    
    p = p.parent()
    c.selectPosition(p)
    filename = p.h[5:]
    g.es(filename + "\n")
    
    p = p.firstChild()
    c.selectPosition(p)
    
    for child in p.children():
        child_h.append(child.h)
        child_b = re.split(r'\n', str(child.b))
        
    children = parent.children()
    for child in children:
        child_b = re.split(r'\n', child.b)
        for line in child_b:
            line = re.sub(r'^.*match=', '', line)
            key_val = re.split(r':\s', line)
            
            i = 0
            for field in key_val:
                if i == 0 and field != "":
                    key_lst.append(field)
                else:
                    if i == 1 and field != "":
                        val_lst.append(field)
                i += 1
    
    num_cols = len(child_b) - 1
    
    conn = sqlite3.connect(filename)
    cur = conn.cursor()
    
    cur.execute("select * from %s" % (table_name))
    rows = cur.fetchall()
    
    p = p.firstChild()
    
    rx = 1    
    for row in rows:    
        
        keys = key_lst[:num_cols]
        vals = val_lst[:num_cols]
                  
        cx = 0
        for key in keys:
                
            query = "update {table} set {field} = ? where {pk_field} = ?".format(table=table_name, field=keys[cx], pk_field='IDKey')
            p.v.u['leo4sqlite']['index'] = rx
            cur.execute(query, [vals[cx], p.v.u['leo4sqlite']['index']])

            cx += 1

        key_lst = key_lst[num_cols:]
        val_lst = val_lst[num_cols:]
        
        p = p.next()

        rx += 1
        
        if p:
            continue
        else:
            conn.commit()
            conn.close()
            g.es("\ndone")
            
</t>
<t tx="tsc.20180224081154.2">@
def export_blobs(self, c, col_nums, col_names, col_types, blob_col):
    
    '''export table with any text field changes included.'''
    
    def place_holder(line):
        return '({})'.format(', '.join('?' * len(line)))
    
    keys = []
    vals = []
    key_lst = []
    val_lst = []
    child_h = []
    child_b = []
    new_row = ''
    
    p = c.p
    parent = p.parent()
    c.selectPosition(parent)
    table_name = re.sub(r'^@tbl\s', '', parent.h)
    g.es(table_name)
    
    p = p.parent()
    c.selectPosition(p)
    
    p = p.parent()
    c.selectPosition(p)
    filename = p.h[5:]
    g.es(filename)
    
    p = p.firstChild()
    c.selectPosition(p)
    
    for child in p.children():
        child_h.append(child.h)
        child_b = re.split(r'\n', str(child.b))
    
    children = parent.children()
    for child in children:
        child_b = re.split(r'\n', child.b)
        for line in child_b:
            line = re.sub(r'^.*match=', '', line)
            key_val = re.split(r':\s', line)
            
            i = 0
            for field in key_val:
                if i == 0 and field != "":
                    key_lst.append(field)
                else:
                    if i == 1 and field != "":
                        val_lst.append(field)
                i += 1
    
    num_cols = len(child_b) - 1
    
    conn = sqlite3.connect(filename)
    cur = conn.cursor()
    
    rx = 1    
    cur.execute("select * from %s" % (table_name))
    rows = cur.fetchall()
    for row in rows:    
    
        keys = key_lst[:num_cols]
        vals = val_lst[:num_cols]
        
        cx = 0
        for key in keys:
                
            query = "update %s set %s = ? where Primary_Key = ?" % (table_name, keys[cx])
            cur.execute(query, [vals[cx], rx])
            cx += 1
        
        key_lst = key_lst[num_cols:]
        val_lst = val_lst[num_cols:]
        rx += 1
            
    conn.commit()
    conn.close()
</t>
<t tx="tsc.20180224081154.3">@
def export_blobs(self, c, col_nums, col_names, col_types, blob_col):
    
    '''export table with any text field changes included.'''
    
    keys = []
    vals = []
    key_lst = []
    val_lst = []
    child_h = []
    child_b = []
    new_row = ''
    primary_keys = []
    
    p = c.p
    parent = p.parent()
    c.selectPosition(parent)
    table_name = re.sub(r'^@tbl\s', '', parent.h)
    g.es("exporting blob table: " + table_name)
    #g.es(table_name)
    
    p = p.parent()
    c.selectPosition(p)
    
    p = p.parent()
    c.selectPosition(p)
    filename = p.h[5:]
    g.es(filename + "\n")
    
    p = p.firstChild()
    c.selectPosition(p)
    
    for child in p.children():
        child_h.append(child.h)
        child_b = re.split(r'\n', str(child.b))
        
    children = parent.children()
    for child in children:
        child_b = re.split(r'\n', child.b)
        for line in child_b:
            line = re.sub(r'^.*match=', '', line)
            key_val = re.split(r':\s', line)
            
            i = 0
            for field in key_val:
                if i == 0 and field != "":
                    key_lst.append(field)
                else:
                    if i == 1 and field != "":
                        val_lst.append(field)
                i += 1
    
    num_cols = len(child_b) - 1
    
    conn = sqlite3.connect(filename)
    cur = conn.cursor()
    
    cur.execute("select * from %s" % (table_name))
    rows = cur.fetchall()
    
    p = p.firstChild()
    #g.es(p.h)
    
    rx = 0    
    for row in rows:    
        
        keys = key_lst[:num_cols]
        vals = val_lst[:num_cols]
        
        primary_keys.append(str(row[num_cols:-3]))
        primary_keys[rx] = primary_keys[rx][1:-2]
        primary_keys[rx] = int(primary_keys[rx])
        typ = str(type(primary_keys[rx]))
        
        g.es(str(vals) + " : " + str(primary_keys[rx]) + " " + typ)
        
        cx = 0
        for key in keys:
                
            query = "update %s set %s = ? where Primary_Key = ?" % (table_name, keys[cx])
            cur.execute(query, [vals[cx], primary_keys[rx]])
            cx += 1
        
        key_lst = key_lst[num_cols:]
        val_lst = val_lst[num_cols:]
        
        #g.es(p.h)
            
        rx += 1
        
        p = p.next()

        if p:
            continue
        else:
            conn.commit()
            conn.close()
            g.es("done")
</t>
<t tx="tsc.20180224081353.1">@
def export_blobs(self, c, col_nums, col_names, col_types, blob_col):
    
    '''export table with any text field changes included.'''
    
    import re
    import sqlite3
    
    keys = []
    vals = []
    key_lst = []
    val_lst = []
    child_h = []
    child_b = []
    new_row = ''
    primary_keys = []
    
    p = c.p
    parent = p.parent()
    c.selectPosition(parent)
    table_name = re.sub(r'^@tbl\s', '', parent.h)
    g.es("exporting blob table: " + table_name)
    #g.es(table_name)
    
    p = p.parent()
    c.selectPosition(p)
    
    p = p.parent()
    c.selectPosition(p)
    filename = p.h[5:]
    g.es(filename + "\n")
    
    p = p.firstChild()
    c.selectPosition(p)
    
    for child in p.children():
        child_h.append(child.h)
        child_b = re.split(r'\n', str(child.b))
        
    children = parent.children()
    for child in children:
        child_b = re.split(r'\n', child.b)
        for line in child_b:
            line = re.sub(r'^.*match=', '', line)
            key_val = re.split(r':\s', line)
            
            i = 0
            for field in key_val:
                if i == 0 and field != "":
                    key_lst.append(field)
                else:
                    if i == 1 and field != "":
                        val_lst.append(field)
                i += 1
    
    num_cols = len(child_b) - 1
    
    conn = sqlite3.connect(filename)
    cur = conn.cursor()
    
    cur.execute("select * from %s" % (table_name))
    rows = cur.fetchall()
    
    p = p.firstChild()
    #g.es(p.h)
    
    rx = 0    
    for row in rows:    
        
        keys = key_lst[:num_cols]
        vals = val_lst[:num_cols]
        
        primary_keys.append(str(row[num_cols:-3]))
        primary_keys[rx] = primary_keys[rx][1:-2]
        primary_keys[rx] = int(primary_keys[rx])
        typ = str(type(primary_keys[rx]))
        
        g.es(str(vals) + " : " + str(primary_keys[rx]) + " " + typ)
        
        cx = 0
        for key in keys:
                
            query = "update %s set %s = ? where PrimaryKey = ?" % (table_name, keys[cx])
            cur.execute(query, [vals[cx], primary_keys[rx]])
            cx += 1
        
        key_lst = key_lst[num_cols:]
        val_lst = val_lst[num_cols:]
        
        #g.es(p.h)
            
        rx += 1
        
        p = p.next()

        if p:
            continue
        else:
            conn.commit()
            conn.close()
            g.es("\ndone")
</t>
<t tx="tsc.20180224090820.1"></t>
<t tx="tsc.20180225234500.1"></t>
<t tx="tsc.20180225234500.2">['one', 'two', 'three', 'IDKey', 'Blobs', 'Filename', 'Extension']
['TEXT', 'REAL', 'INTEGER', 'INTEGER', 'BLOB', 'TEXT', 'TEXT']

</t>
<t tx="tsc.20180225234500.3" leo4sqlite="7d71005805000000696e64657871014b01732e">one: sheen
two: happy
three: clown
</t>
<t tx="tsc.20180225234500.4" leo4sqlite="7d71005805000000696e64657871014b02732e">one: blue
two: goofy
three: frown
</t>
<t tx="tsc.20180225234500.5" leo4sqlite="7d71005805000000696e64657871014b03732e">one: grey
two: smarty
three: brown
</t>
<t tx="tsc.20180225234500.6" leo4sqlite="7d71005805000000696e64657871014b04732e">one: olive
two: smarty
three: clown
</t>
<t tx="tsc.20180226003650.1"></t>
<t tx="tsc.20180226003650.2">filepath: /home/tsc/Desktop/sqlite_filename.db3

['one', 'two', 'three']
['INTEGER', 'REAL', 'INTEGER']

layout: two

</t>
<t tx="tsc.20180226003650.3"></t>
<t tx="tsc.20180226003650.4"></t>
<t tx="tsc.20180226003822.1">filepath: /home/tsc/Desktop/sqlite_filename.db3

['one', 'two', 'IDKey']
['STRING', 'TEXT', 'INTEGER']

layout: three

</t>
<t tx="tsc.20180226003822.2">hi
hey
hello
</t>
<t tx="tsc.20180226003822.3">mom
dad
terry
</t>
<t tx="tsc.20180226003822.4">1
2
3
</t>
<t tx="tsc.20180226071844.1">@language python

def db3_tbl_idx(c):

    import re
    
    db3_tbl_idx = {}
    
    db3s = c.find_h(r'^@db3\s.*')
    
    for db3 in db3s:
        db3_h = re.sub(r'.*@db3 ', '', db3.h)
        for tbl in db3.children():
            tbl_h = re.sub(r'.*@tbl ', '', tbl.h)
            db3_tbl_idx.setdefault(db3_h, []).append(tbl_h)
    
    #g.es(db3_tbl_idx)
    return db3_tbl_idx
</t>
<t tx="tsc.20180228090847.1">/filepath</t>
<t tx="tscv11.20180119175627.1">@language python
'''
**leo4sqlite.py plugin**

*This node belongs at the top level of 'leoPlugins.leo'*

|
         
**Notes**

 | 1. This script needs to be streamlined and polished, which I intend to do (in the end I'm a perfectionist). Any suggestions toward that end are welcome!
 
**Issues**
 
 | 3. Data types - column affinity, manifest type, storage type

**Ideas**
    
 | 1. Recent files for blob command dialogs?
 |

**The commands currently added by the plugin are:**

 |* sqlite-make-template
 |* sqlite-import-table
 |* sqlite-export-table
 |* sqlite-open-blob
 |* sqlite-view-blob
 |* sqlite-insert-blob
 |* sqlite-extract-blob
 |* sqlite-reset-temp
 |* sqlite-clear-data
 |* sqlite-purge-files
 |
 
I want to make this the best plugin I can rather than rushing to finish it. Leo deserves no less! Please provide any feedback you can, and don't hesitate to suggest improvements! :-)
'''</t>
</tnodes>
</leo_file>

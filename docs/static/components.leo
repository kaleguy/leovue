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
<v t="josephorr.20170905085447.2"><vh>Overview</vh></v>
<v t="josephorr.20170905085604.1" a="E"><vh>Components</vh>
<v t="josephorr.20170905085846.1" a="E"><vh>@clean viewgrid.js</vh>
<v t="josephorr.20171221140714.1"><vh>&lt;&lt; component &gt;&gt;</vh>
<v t="josephorr.20171221140937.1"><vh>&lt;&lt; controller &gt;&gt;</vh>
<v t="josephorr.20171221141334.1"><vh>&lt;&lt; set current row &gt;&gt;</vh></v>
<v t="josephorr.20171221141452.1"><vh>&lt;&lt; load data from event &gt;&gt;</vh></v>
<v t="josephorr.20171221141658.1"><vh>&lt;&lt; process result &gt;&gt;</vh>
<v t="josephorr.20171221171204.1"><vh>&lt;&lt; formula fields &gt;&gt;</vh></v>
<v t="josephorr.20171221171930.1"><vh>&lt;&lt; db records &gt;&gt;</vh>
<v t="josephorr.20171221173502.1"><vh>&lt;&lt; db formula fields &gt;&gt;</vh></v>
</v>
</v>
<v t="josephorr.20171223133830.1"><vh>&lt;&lt; the jsGrid loadData function &gt;&gt;</vh></v>
<v t="josephorr.20171223133928.1"><vh>&lt;&lt; data watcher &gt;&gt;</vh></v>
<v t="josephorr.20171221141558.1"><vh>&lt;&lt; execute viewgrid &gt;&gt;</vh>
<v t="josephorr.20171221172441.1"><vh>&lt;&lt; execute table filters on keydown &gt;&gt;</vh></v>
<v t="josephorr.20171221172501.1"><vh>&lt;&lt; jsgrid &gt;&gt;</vh></v>
</v>
<v t="josephorr.20171223133722.1"><vh>&lt;&lt; dummy &gt;&gt;</vh></v>
</v>
</v>
<v t="josephorr.20171221140617.1"><vh>&lt;&lt; builder &gt;&gt;</vh></v>
<v t="josephorr.20171221140521.1"><vh>&lt;&lt; templates &gt;&gt;</vh></v>
</v>
<v t="josephorr.20171226172416.1"><vh>@clean datamapper.js</vh></v>
<v t="josephorr.20171226191602.1" a="E"><vh>@clean initialize.js</vh>
<v t="josephorr.20171226201424.1" a="E"><vh>&lt;&lt; component &gt;&gt;</vh>
<v t="josephorr.20171226201803.1" a="E"><vh>&lt;&lt; controller &gt;&gt;</vh>
<v t="josephorr.20171226204831.1"><vh>&lt;&lt; scope.execute &gt;&gt;</vh></v>
<v t="josephorr.20171226204934.1"><vh>&lt;&lt; listen for each input component &gt;&gt;</vh></v>
</v>
<v t="josephorr.20171226201828.1"><vh>&lt;&lt; onEdit &gt;&gt;</vh></v>
</v>
<v t="josephorr.20171226201452.1"><vh>&lt;&lt; builder &gt;&gt;</vh></v>
<v t="josephorr.20171226201522.1"><vh>&lt;&lt; templates &gt;&gt;</vh></v>
</v>
</v>
</vnodes>
<tnodes>
<t tx="josephorr.20170905085447.2"></t>
<t tx="josephorr.20170905085604.1">@path ../src/components</t>
<t tx="josephorr.20170905085846.1">@language javascript

var app = angular.module('unQork');
console.log('LEO VERSION')
&lt;&lt; component &gt;&gt;
&lt;&lt; builder &gt;&gt;
&lt;&lt; templates &gt;&gt;






</t>
<t tx="josephorr.20171221140521.1">app.run([
  '$templateCache',
  function($templateCache) {

    // the template for Edit view
    $templateCache.put('formio/formbuilder/viewgrids.html', '&lt;span class="hidden-element-text"&gt;{{ component.label }}&lt;/span&gt;');

    // The property panel (top part)
    $templateCache.put('formio/components/common/viewgrid.html',
      '&lt;div class="row"&gt;' +
      ' &lt;div class="col-md-6"&gt;' +
      '   &lt;form-builder-option property="label" placeholder="Viewgrid Name"&gt;&lt;/form-builder-option&gt;' +
      ' &lt;/div&gt;' +
      ' &lt;div class="col-md-6"&gt;' +
      '   &lt;form-builder-option-key&gt;&lt;/form-builder-option-key&gt;' +
      ' &lt;/div&gt;' +
      '&lt;/div&gt;' +
      '&lt;div class="row"&gt;' +
      ' &lt;div class="col-md-6"&gt;' +
      '  &lt;form-builder-option type="checkbox" property="viewgridData.showTitle" label="Show Title" title="Whether to show a title over the view grid."&gt;&lt;/form-builder-option&gt;' +
      ' &lt;/div&gt;' +
      ' &lt;div class="col-md-6"&gt;' +
      '  &lt;form-builder-option property="viewgridData.showFilters" type="checkbox" label="Show Filters" title="Display grid with column filters."&gt;&lt;/form-builder-option&gt;' +
      ' &lt;/div&gt;' +
      '&lt;/div&gt;' +
      '&lt;div class="row"&gt;' +
              ' &lt;div class="col-md-6"&gt;' +
              '  &lt;form-builder-option property="viewgridData.height" label="Grid Height" title="Grid pixel height."&gt;&lt;/form-builder-option&gt;' +
              ' &lt;/div&gt;' +
              ' &lt;div class="col-md-6"&gt;' +
              '  &lt;form-builder-option property="viewgridData.pageSize" label="Page Size" title="Number of records to display per page."&gt;&lt;/form-builder-option&gt;' +
              ' &lt;/div&gt;' +
              '&lt;/div&gt;' +
      '&lt;div class="row"&gt;' +
      '  &lt;div class="col-md-6"&gt;' +
      '   &lt;form-builder-option property="viewgridData.action" label="Action" title="Add button with specified action."&gt;&lt;/form-builder-option&gt;' +
      '  &lt;/div&gt;' +
      '  &lt;div class="col-md-6"&gt;' +
      '   &lt;form-builder-option property="viewgridData.event" label="Event" title="Optional event to raise if clicked, otherwise uses Action."&gt;&lt;/form-builder-option&gt;' +
      '  &lt;/div&gt;' +
      '&lt;/div&gt;' +
      '&lt;div class="row"&gt;' +
      '  &lt;div class="col-md-6"&gt;' +
      '   &lt;form-builder-option property="viewgridData.noDataText" label="No Data Text" placeholder="Not found" title="Text for when there\'s no data to display"&gt;&lt;/form-builder-option&gt;' +
      '  &lt;/div&gt;' +
      ' &lt;div class="col-md-6"&gt;' +
      '  &lt;form-builder-option property="viewgridData.sourceUrl" label="Data Source URL" placeholder="Data Source URL" title="A URL that returns a JSON array to use as the data source."&gt;&lt;/form-builder-option&gt;' +
      ' &lt;/div&gt;' +
      '&lt;/div&gt;' +
      '&lt;div class="row" style="display:none"&gt;' +
      ' &lt;div class="col-md-6"&gt;' +
      '  &lt;label for="boundPanel" form-builder-tooltip="Panel containing the fields/edit components."&gt;Bound Panel&lt;/label&gt;' +
      '  &lt;select class="form-control" id="boundPanel" name="boundPanel" ng-change="setPanel(component.boundPanel)"  ng-options="field.key as field.key for field in panelFields" ng-model="component.boundPanel"&gt;&lt;/select&gt;' +
      '&lt;/div&gt;' +
      '&lt;/div&gt;' +
      '&lt;div class="row"&gt;' +
      '&lt;/div&gt;' +
      '  &lt;viewgrid-builder viewgrid-data="component.viewgridData" /&gt;' +
      '&lt;/div&gt;' +
      '&lt;div class="row"&gt;' +
      '  &lt;div class="col-md-12"&gt;' +
      '    &lt;form-builder-option-tags&gt;&lt;/form-builder-option-tags&gt;' +
      '  &lt;/div&gt;' +
      '&lt;/div&gt;'
    );
  }
]);

// The View Template
app.run([
  '$templateCache',
  function($templateCache) {
    $templateCache.put('formio/components/viewgrids.html',
      '&lt;h3 class="component-title" ng-show="component.viewgridData.showTitle"&gt;{{ component.label }}&lt;/h3&gt;' +
      '&lt;div id="jsGrid_{{labelId}}"&gt;&lt;/div&gt;' +
      '&lt;div ng-show="dummy()"&gt;&lt;/div&gt;'
    );

  }
]);
</t>
<t tx="josephorr.20171221140617.1">// property panel (lower part)
app.directive('viewgridBuilder', function($parse, FormioUtils) {
  return {
    restrict: 'E',
    scope: {
      viewgridData: '='
    },
    template: '' +
        '&lt;div&gt;' +
        '  &lt;div class="row"&gt;' +
        '    &lt;div class="col-xs-6"&gt;' +
        '      &lt;h5&gt;Inputs&lt;/h5&gt;' +
        '      &lt;div class="hotInputs" /&gt;' +
        '    &lt;/div&gt;' +
        '    &lt;div class="col-xs-6"&gt;' +
        '      &lt;h5&gt;Outputs&lt;/h5&gt;' +
        '      &lt;div class="hotOutputs" /&gt;' +
        '    &lt;/div&gt;' +
        '  &lt;/div&gt;' +
        '  &lt;div class="row"&gt;' +
        '    &lt;div class="col-xs-12"&gt;' +
        '      &lt;h5&gt;Display&lt;/h5&gt;' +
        '      &lt;div class="hotDisplay" /&gt;' +
        '    &lt;/div&gt;' +
        '  &lt;/div&gt;' +
        '&lt;/div&gt;',
    link: function(scope, element, attrs) { // jshint ignore:line
      var viewgridData = scope.viewgridData;
      var components = [];
      var fields = [];
      FormioUtils.eachComponent(scope.$parent.form.components, function(component) {
        // Only add input elements.
        if (['button', 'viewgrid'].indexOf(component.type) === -1 &amp;&amp; component.key.indexOf('panel') !== 0) {
          components.push(component);
          fields.push(component.key);
        }
      }, true);
      scope.saveData = function() {
        if (viewgridData.dataInputObject == undefined) { return; } // jshint ignore:line
        viewgridData.dataOutputObject = getTableData(hotOutputs);
        viewgridData.dataInputObject = getTableData(hotInputs);
        viewgridData.dataDisplayObject = getTableData(hotDisplay);
        scope.viewgridData = viewgridData;
      };
      function getTableData(hotTable) {
        var cellData = hotTable.getData();
        var headerData = hotTable.getColHeader();
        var dataTable = [];
        for (var k=0; k &lt; cellData.length; k++) {
          var dataRow = {};
          if (!hotTable.isEmptyRow(k)) {
            for (var i =0; i &lt; cellData[k].length; i++) {
              var key = headerData[i];
              var cellValue = cellData[k][i];
              if (cellValue === null ) {
                cellValue = '';
              }
              dataRow[key] = cellValue;
            }
            dataTable.push(dataRow);
          }
        }
        return dataTable;
      }
      scope.loadData = function(viewgridData) {
        if (viewgridData.dataInputObject == undefined) { // jshint ignore:line
          return;
        }
        hotInputs.updateSettings({
          data: viewgridData.dataInputObject
        });
        hotOutputs.updateSettings({
          data: viewgridData.dataOutputObject
        });
        hotDisplay.updateSettings({
          data: viewgridData.dataDisplayObject
        });

      };
      var hotInputElement = element[0].querySelector('.hotInputs');
      var hotInputSettings = {
        data: viewgridData.dataInputObject,
        columns: [
          {
            data: 'id',
            type: 'autocomplete',
            source: fields.sort(),
            strict: false
          },
          {
            data: 'required',
            type: 'checkbox'
          }
        ],
        colWidths: [175,160],
        rowHeights: 23,
        // performance tip: turn off calculations
        autoWrapRow: true,
        height: 117,
        rowHeaders: false,
        colHeaders: [
          'id',
          'required'
        ],
        manualColumnResize: true,
        minSpareRows: 4,
        stretchH: 'all'
      };

      var hotInputs = new Handsontable(hotInputElement, hotInputSettings);

      var hotOutputElement = element[0].querySelector('.hotOutputs');
      var hotOutputSettings = {
        data: viewgridData.dataOutputObject,
        columns: [
          {
            data: 'id',
            type: 'autocomplete',
            source: fields.sort(),
            strict: false
          },
          {
            data: 'mapping',
            type: 'text'
          }
        ],
        colWidths: [175, 175],
        rowHeights: 23,
        // performance tip: turn off calculations
        autoWrapRow: true,
        height: 117,
        rowHeaders: false,
        colHeaders: [
          'id',
          'mapping'
        ],
        manualColumnResize: true,
        minSpareRows: 4,
        stretchH: 'all'
      };
      var hotOutputs = new Handsontable(hotOutputElement, hotOutputSettings);
      var hotDisplayElement = element[0].querySelector('.hotDisplay');
      var hotDisplaySettings = {
        data: viewgridData.dataDisplayObject,
        columns: [
          {
            data: 'id',
            type: 'autocomplete',
            source: fields.sort(),
            strict: false
          },
          {
            data: 'formula',
            type: 'text'
          },
          {
            data: 'heading',
            type: 'text'
          }
        ],
        colWidths: [175, 175],
        rowHeights: 23,
        // performance tip: turn off calculations
        autoWrapRow: true,
        height: 117,
        rowHeaders: false,
        colHeaders: [
          'id',
          'formula',
          'heading'
        ],
        manualColumnResize: true,
        minSpareRows: 4,
        stretchH: 'all'
      };

      var hotDisplay = new Handsontable(hotDisplayElement, hotDisplaySettings);

      angular.element(function () {
        hotInputs.render();
        hotOutputs.render();
        hotDisplay.render();
      });
    },

    controller: [
      '$scope',
      function($scope) {
        $scope.$watch('viewgridData', function(newData) {
          $scope.loadData(newData);
        }, true);
      }
    ]

  };
});

</t>
<t tx="josephorr.20171221140714.1">/**
 * viewGrid component, requires API with array of data or object with 'records' array of data.
 */
app.config([
  'formioComponentsProvider',
  function(formioComponentsProvider) {
    formioComponentsProvider.register('viewgrid', {
      fbtemplate: 'formio/formbuilder/viewgrids.html',
      title: 'ViewGrid',
      template: 'formio/components/viewgrids.html',
      group: 'advanced',
      &lt;&lt; controller &gt;&gt;
      icon: 'fa fa-table',
      settings: {
        multiple: true,
        input: false,
        key: 'viewgridField',
        label: '',
        protected: false,
        unique: false,
        persistent: true,
        showTitle: false,
        viewgridData: {
          dataDisplayObject: [],
          dataInputObject: [],
          dataOutputObject: []
        }
      },
      views: [
        {
          name: 'ViewGrid',
          template: 'formio/components/common/viewgrid.html'
        }
      ],
      documentation: ''
    });
  }

]);

</t>
<t tx="josephorr.20171221140937.1">controller: [
  '$scope',
  '$http',
  '$state',
  '$timeout',
  function(
    $scope,
    $http,
    $state,
    $timeout
  ) {
    if ($scope.builder) { return; }     // Don't do calculations in form builder.
    var data = $scope.submission ? $scope.submission.data : {};
    var viewgridData = $scope.component.viewgridData;
    var labelId = $scope.component.key;
    $scope.labelId = labelId;
    var filtering = $scope.component.viewgridData.showFilters;
    var height = $scope.component.viewgridData.height != "" ? $scope.component.viewgridData.height + 'px' : 'auto';
    var pageSize = $scope.component.viewgridData.pageSize || 10;

    // The action for the row button
    var action = $scope.component.viewgridData.action || 'Submit';
    var actionKey = action.replace(/\s/g, '');
    var event = $scope.component.viewgridData.event || actionKey;

    var noDataText = $scope.component.viewgridData.noDataText || 'Not found';

    var keys = viewgridData.dataInputObject;
    var url = viewgridData.sourceUrl || '';
    if (url &amp;&amp; url.substr(0, 1) === '/') {
      url = Formio.getBaseUrl() + url;
    }
    &lt;&lt; the jsGrid loadData function &gt;&gt;
    &lt;&lt; set current row &gt;&gt;
    &lt;&lt; execute viewgrid &gt;&gt;
    &lt;&lt; load data from event &gt;&gt;
    &lt;&lt; data watcher &gt;&gt;
    &lt;&lt; process result &gt;&gt;
    &lt;&lt; dummy &gt;&gt;
  }
],

</t>
<t tx="josephorr.20171221141334.1">var setCurrentRow = function (item, index) {
    // change for demo
    var outputList = $scope.component.viewgridData.dataOutputObject;
    if (outputList.length &gt; 0) {
      for (var j = 0; j &lt; outputList.length; j++) {
          var output = outputList[j];
          var mapping = output.mapping;
          var dataValue = item[mapping];
          output.type = 'value';
          if (dataValue === undefined) {
              dataValue = ''; // reset the value if not found
          }
          setOutputValues(output, dataValue, data,  $scope.$parent.form);
      }
    }
};

</t>
<t tx="josephorr.20171221141452.1">var loadDataFromEvent = function () {
    if ($scope.builder) { return; }
    var data = $scope.submission ? $scope.submission.data : {};
    var viewgridData = $scope.component.viewgridData;
    var hasFormula = setDataValues(viewgridData.dataInputObject, data, false);
    if (hasFormula === undefined ) {
        //console.log('required fields not supplied');
        return;
    }
    return processResult({data:_.get(viewgridData, 'dataInputObject[0].value',[])});
}

</t>
<t tx="josephorr.20171221141558.1">var executeViewgrid = function(fields) {
  if ($scope.builder) { return; }

  if (! viewgridData.dataDisplayObject){
    viewgridData.dataDisplayObject = [];
    viewgridData.dataInputObject = [];
    viewgridData.dataOutputObject = [];
  } // object not saved correctly
  var data = $scope.submission ? $scope.submission.data : {};
  var hasFormula = setDataValues(viewgridData.dataInputObject, data, false);
  if (hasFormula === undefined ) {
      //console.log('required fields not supplied, hasFormula/setDataValues returns undefined');
      return;
  }
  var buttonField = {
    type: 'control',
    width: 100,
    itemTemplate: function (value, item) {
      var commandButton = '&lt;button type="button"  class="btn btn-secondary-3 pull-right"\&gt; ' + action + ' &lt;/button&gt;';
      return commandButton;
    }
  };
  if (action !== 'null') {
    fields.push(buttonField);
  }
  &lt;&lt; jsgrid &gt;&gt;
  &lt;&lt; execute table filters on keydown &gt;&gt;
};

</t>
<t tx="josephorr.20171221141658.1">var processResult =  function(result) {
  if (_.get(result, 'data.records')) {
    result.data = result.data.records
  }
  &lt;&lt; formula fields &gt;&gt;
      return;
  }
  var fields = viewgridData.dataDisplayObject.reduce(function(acc, r){
    if (r.id) {
      acc.push({
        name: r.id,
        title: r.heading,
        type: 'text'
      });
    }
    return acc;
  }, []);      
  &lt;&lt; db records &gt;&gt;
  executeViewgrid(fields);
}

</t>
<t tx="josephorr.20171221171204.1">var formulaFields = [];
_.each (viewgridData.dataDisplayObject, function (r) {
    if (r.formula) {
        // add to list of formula fields
        formulaFields.push(r);
    }
});
if (!result.data.reduce) {

</t>
<t tx="josephorr.20171221171930.1">var fieldIds = fields.reduce(function(acc, f){
  acc.push(f.name);
  return acc
}, [])

db.records = result.data.reduce(function(acc, v){
    var row = {}
    if (v.data) {
       Object.assign(row, v.data); // in case of form data, rows under 'data' subkey
        if (v._id) {
            Object.assign(row, _.pick( v, ['_id', 'modified','created']));
        }
    } else {
      row = Object.assign(v, _.pick(fields));
    }
    Object.assign(row, _.pick(v, fieldIds));

    // debugger
    if (row._id) { row.id = row._id } // normalize
    &lt;&lt; db formula fields &gt;&gt;
    acc.push(row);
    return acc;
}, []);
// debugger

</t>
<t tx="josephorr.20171221172441.1">// execute table filters on keydown
$timeout(function () {
    $('#jsGrid_' + labelId + ' :input').keydown(function () {
        var self = this;
        if (self.timeoutPromise)
            $timeout.cancel(self.timeoutPromise);
        if (self.value.length == 0)
            $('#jsGrid_' + labelId).jsGrid('loadData');

        self.timeoutPromise =
            $timeout(function () {
                $('#jsGrid_' + labelId).jsGrid('loadData');
            }, 200);
    });
});

</t>
<t tx="josephorr.20171221172501.1">$("#jsGrid_" + labelId).jsGrid({
      autoload: true,
      width: "100%",
      height: height,
      filtering: filtering,
      sorting: true,
      paging: true,
      selecting: false,
      controller: db,
      pageSize: pageSize,
      pagerFormat: "{pages}",
      pagePrevText: "Prev",
      pageNextText: "Next",
      pageFirstText: "First",
      pageLastText: "Last",
      pageNavigatorNextText: "...",
      pageNavigatorPrevText: "...",
      noDataContent: noDataText,
      fields: fields,
      rowClick: function(r) {
        setCurrentRow(r.item, r.index);
        if (r.event.target.tagName === 'BUTTON') {
          buttonClick(r.event, event)
          return console.log('Button clicked.')
        }
        // onclick="buttonClick(event, \'' + actionKey + '\')"&gt;' + action + '
        // $state.go('displaySubmission', {formId: formId, submissionId: r.item.id});
      }
  });

</t>
<t tx="josephorr.20171221173502.1">if (formulaFields.length &gt; 0) {
    var parser = new formulaParser.Parser();
    _.each(row, function (value, key) {
        parser.setVariable(key, value);
    });
    _.each(formulaFields, function (r) {
        var result = parser.parse(r.formula.substring(1)).result;
        _.set( row, r.id, result);
    });
}

</t>
<t tx="josephorr.20171223133722.1">var options = { params: {} };
for (var i = 0; i &lt; keys.length; i++) {
  var inputField = keys[i];
  if (_.get(inputField,'exclude') !== true) {
    if (inputField.value) {
      options.params[inputField.mapping] = inputField.value;
    }
  }
};    
$scope.gotIt = false;
// dummy executes after jsGrid element is added to DOM
$scope.dummy = function () {
  if ($scope.gotIt) { return; }
  $scope.gotIt = true;
  if (!url) { return }
  $http.get(url, options)
    .then(processResult)
      .catch(function(e){ console.log(e.message) });
}

</t>
<t tx="josephorr.20171223133830.1">var db = {
  loadData: function(filter) {
    return $.grep(this.records, function(row) {
      var f = true;
      Object.keys(filter).forEach(function (filterName) {
        var colFilter = filter[filterName];
        var colValue = row[filterName];
        if (!colFilter) { return }
        if($.type(colValue) !== "string") {
          return f = (colFilter === colValue);
        }
        if (colFilter &amp;&amp; colValue.toLowerCase().indexOf(colFilter.toLowerCase()) &lt; 0){
          return f = false;
        }
      });
      return f;
    });
  },
  records: []
};

</t>
<t tx="josephorr.20171223133928.1">$scope.component.viewgridData.dataInputObject.forEach(function(key) {
  if (key.id) {
    $scope.$watch('submission.data.' + key.id, loadDataFromEvent, true);
  }
});

</t>
<t tx="josephorr.20171226172416.1">@language javascript

var app = angular.module('unQork');

app.config([
  'formioComponentsProvider',
  function(formioComponentsProvider) {
    formioComponentsProvider.register('datamapper', {
      fbtemplate: 'formio/formbuilder/datamappers.html',
      title: 'DataMapper',
      template: 'formio/components/datamappers.html',
      group: 'data',
      controller: [
        '$scope',
        function(
          $scope
        ) {

          // Don't do calculations in form builder.
          if ($scope.builder) { return; }

        $scope.execute = function () {
            //console.log('begin ' + $scope.component.key + ' ' + new Date());
            if ($scope.component.disabled === true || (!LOADING_COMPLETE &amp;&amp; $scope.component.preventExecuteOnLoad === true)) {
                return;
            }
            var data = $scope.submission ? $scope.submission.data : {};
            // current row is in $scope.data

            var datamapperData = $scope.component.datamapperData;

            var watchField = $scope.component.datamapperData.watchField;
            var watchData;
            var dataInstance = _.cloneDeep(data);
            if (watchField &amp;&amp; watchField !== '') {
                // is it a array
                if (_.has(data,watchField)) {
                    watchData = _.get(dataInstance, watchField);
                } else if ($scope.component.triggerType !== 'manual') {
                    return;
                }
            }
            // set each variable in data as a variable in the parser

            var parser = new formulaParser.Parser();
            _.each ( data, function (value, key) {
                parser.setVariable (key, value);
            });

            // needed to switch to a map to maintain insertion order which is very important
            var newObject = [];

            // cannot use _.each here, it does not maintain the same order which is important for us
            var heading = datamapperData.dataObject[0];
            var keys = Object.keys(heading);
            // start at 1 to bypass the first column
            for (var i = 1; i&lt; keys.length; i++) {
              var obj = heading['col' + i];
              if (!_.isUndefined(obj) &amp;&amp; obj !== '') {
                  newObject.push({'key': obj,'value': 'col' + i});
              }
            }

            var resultRows = [];

            if (watchData) {
              // is it a array
                if (_.isArray(watchData)) {
                    var i = 1;
                    parser.setVariable('last', watchData.length);
                    var iterate = ($scope.component.bottomsUp === true) ? _.eachRight : _.each;
                    iterate (watchData, function (row) {
                      parser.setVariable('position', i);
                      _.each (row, function (value, key) {
                        _.set(dataInstance, key, value);
                        parser.setVariable(key,value);
                      });
                      // add so you can reference itself
                      makePass (datamapperData.dataObject, parser, dataInstance, resultRows, newObject, i-1);
                      _.set(dataInstance, $scope.component.key, resultRows);
                      _.each (row, function (value, key) {
                          _.set(dataInstance, key, '');
                          parser.setVariable(key,'');
                      });
                      i = i + 1;
                  });
                } else {
                    makePass (datamapperData.dataObject, parser, dataInstance, resultRows, newObject, 0);
                }
            } else {
                makePass (datamapperData.dataObject, parser, dataInstance, resultRows, newObject,0);
            }

            if ($scope.component.wrapInTable) {
              var htmlTable = createTableForObject(resultRows);
              data[$scope.component.key] = htmlTable;
            } else {
              data[$scope.component.key] = resultRows;
            }

              console.log('end ' + $scope.component.key + ' ' + new Date());
        };

        var createTableForObject = function(resultRows) {
          var htmlTable ='&lt;table class="table table-hover table-bordered" id="{{ componentId }"&gt;'+
              '&lt;thead&gt;'+
              '&lt;tr&gt;'+
              '&lt;th&gt;Data Element&lt;/th&gt;'+
              '&lt;th&gt;Value&lt;/th&gt;'+
              '&lt;/tr&gt;'+
              '&lt;/thead&gt;'+
              '&lt;tbody&gt;';
            _.each (resultRows, function (row) {
              if (_.isArray(row) || _.isObject(row)) {
                  _.each(row, function (value, key) {
                      htmlTable = htmlTable + '&lt;tr&gt;&lt;td&gt;';
                      htmlTable = htmlTable + key;
                      htmlTable = htmlTable + '&lt;/td&gt;&lt;td&gt;';
                      if (_.isObject(value)) {
                          htmlTable = htmlTable + createTableForObject(value);
                      } else {
                          htmlTable = htmlTable + value;
                      }
                      htmlTable = htmlTable + '&lt;/td&gt;&lt;/tr&gt;';
                  });
              } else {
                  htmlTable = htmlTable + '&lt;tr&gt;&lt;td&gt;';
                  htmlTable = htmlTable + '';
                  htmlTable = htmlTable + '&lt;/td&gt;&lt;td&gt;';
                  htmlTable = htmlTable + row;
                  htmlTable = htmlTable + '&lt;/td&gt;&lt;/tr&gt;';
              }
            });
            htmlTable = htmlTable + '&lt;/tbody&gt;&lt;/table&gt;';
            return htmlTable;
        }

          var makePass = function (dataObject, parser, dataInstance, resultRows, newObject,position) {
              for (var i = 1; i &lt; dataObject.length; i++) {
                  var row = _.cloneDeep( dataObject[i]);
                  var checkCondition = row.col0;
                  if (!checkCondition || checkCondition === '') {
                      break;
                  }
                  checkCondition = checkCondition.replace('true','TRUE');
                  checkCondition = checkCondition.replace('false','FALSE');
                  var newObjectRow = {};
                  for (var j = 0; j &lt; newObject.length; j++) {
                      var key = newObject[j].key
                      var value = newObject[j].value;
                      var rowValue = row[value];
                      if (rowValue &amp;&amp; rowValue !== '') {
                          var result;
                          if (rowValue.indexOf('[position') &gt; -1) {
                              rowValue=rowValue.replace('positionNext', position+1);
                              rowValue=rowValue.replace('positionPrevious', position-1);
                              rowValue=rowValue.replace('position', position);
                          }
                          if (rowValue.startsWith('=')) {
                              result = parser.parse(rowValue.substring(1)).result;
                          } else {
                              if (rowValue.indexOf('[x].') &gt; -1) {
                                  result = explodeArrays(rowValue, dataInstance);
                              } else {
                                  result = _.get(newObjectRow, rowValue, _.get(dataInstance, rowValue, ''));
                              }
                          }
                         // _.set(dataInstance, key, result);
                          _.set(newObjectRow, key, result);
                          parser.setVariable(key, result);
                      } else {
                          _.set(newObjectRow, key, '');
                          parser.setVariable(key, '');
                      }
                  }

                  if (parser.parse(checkCondition.substring(1)).result) {
                      resultRows.push(newObjectRow);
                  }
              }
          }

          // clean up empty rows... should remove prior
          cleanEmptyValues ($scope.component.datamapperData, $scope.$parent.form);

          if ($scope.component.includeAllFields) {
            $scope.component.datamapperData = {dataObject: []};
            var dataObject = $scope.component.datamapperData.dataObject;
            var i = 1;
            var datamapperRow = {
              col0: '=TRUE'
            };
            _.each ($scope.$parent.form.flattenedComponents, function (component) {
                if ((component.type !== 'column') &amp;&amp; (component.type !== 'panel')) {
                    if (component.key !== $scope.component.key) {
                        _.set(datamapperRow, 'col' + i, component.key);
                        i = i + 1;
                    }
                }
            });
            dataObject.push (datamapperRow);
            // need two rows
            dataObject.push (datamapperRow);
          }

          // Listen for each input component.
            if ($scope.component.triggerType !== 'manual') {
                var watchField = $scope.component.datamapperData.watchField;
                if (watchField &amp;&amp; watchField != '') {
                    watchField = 'submission.data.' + watchField;
                } else {
                    watchField = 'submission.data';
                }
                var filterDelayed = function ($scope) {
                    $scope.$apply($scope.execute);
                };
                var filterThrottled = _.debounce(filterDelayed, 500);
                $scope.$watch(watchField, function () {
                    filterThrottled($scope);
                }, true);
            }
        }
      ],
      icon: 'fa fa-random',
      settings: {
        multiple: true,
        input: true,
        tableView: true,
        key: 'datamapperField',
        label: '',
        protected: false,
        unique: false,
        persistent: true,
        datamapperData: {
          dataObject: [],
          dataInputObject: [],
          dataOutputObject: []
        },
        triggerType: 'watch'
      },
      views: [
        {
          name: 'DataMapper',
          template: 'formio/components/common/datamapper.html'
        }
      ],
       onEdit: ['$scope', function($scope) {
            $scope.triggerTypes = [
                {
                    'name': 'watch',
                    'title': 'Watch'
                },
                {
                    'name': 'manual',
                    'title': 'Manual'
                }]
       }]
    });
  }
]);

app.directive('datamapperBuilder', function($parse, FormioUtils) {
  return {
    restrict: 'E',
    scope: {
      datamapperData: '='
    },
    template: '' +
    '&lt;div&gt;' +
    '  &lt;div class="row"&gt;' +
    '    &lt;div class="col-md-12"&gt;' +
    '      &lt;h5&gt;Data Mapper&lt;/h5&gt;' +
    '      &lt;div class="hot"/&gt;' +
    '    &lt;/div&gt;' +
    '  &lt;/div&gt;' +
    '&lt;/div&gt;',
    link: function(scope, element, attrs) { // jshint ignore:line

      var datamapperData = scope.datamapperData;
      if (datamapperData.dataObject.length === 0) {
        for (var i = 0; i &lt; 50; i++) {
          var obj = {};
          for (var k = 0; k &lt; 50; k++ ) {
              _.set(obj, 'col' + k, '');
          }
          datamapperData.dataObject.push(obj);
        }
      }

      function customRenderer(instance, td) {
        Handsontable.renderers.TextRenderer.apply(this, arguments);
        td.style.backgroundColor = '#f8f8ff';
        return td;
      }


      var columns = [];
    columns.push({data: 'col0', type: 'text', renderer: customRenderer});
      for (var i = 1; i &lt; 50; i++) {
          columns.push({data: 'col' + i, type: 'text'});
      }
      var components = [];
      var fields = [];
      FormioUtils.eachComponent(scope.$parent.form.components, function(component) {
        // Only add input elements.
          components.push(component);
          fields.push(component.key);
        //}
      }, true);

      scope.saveData = function() {
        if (!hot) { return; }
        datamapperData.dataObject = getTableData(hot);
        scope.datamapperData = datamapperData;

      };

      function getTableData(hotTable) {
        var cellData = hotTable.getData();
        var headerData = hotTable.getColHeader();
        var dataTable = [];
        for (var k=0; k &lt; cellData.length; k++) {
          var dataRow = {};
          if (!hotTable.isEmptyRow(k)) {
            for (var i =0; i &lt; cellData[k].length; i++) {
              var key = headerData[i];
              var cellValue = cellData[k][i];

              if (cellValue === null ) {
                cellValue = '';
              }

              dataRow[key] = cellValue;
            }
            dataTable.push(dataRow);
          }
        }
        return dataTable;
      }

      scope.loadData = function(datamapperData) {
        hot.updateSettings({
          data: datamapperData.dataObject
        });

      };

      var hotElement = element[0].querySelector('.hot');
      var hotSettings = {
        data: scope.datamapperData.dataObject,
        columns: columns,
        height: 300,
        width: 700,
        colWidths: [150, 150,150,150],
        rowHeights: 23,
        rowHeaders: true,
        colHeaders: true,
        contextMenu: false,
        manualColumnResize: true,
        dropdownMenu: false,
        minSpareRows: 4
      };

      var hot = new Handsontable(hotElement, hotSettings);

      angular.element(function () {
        hot.render();
      });
    },
    controller: [
      '$scope',
      function(
        $scope
      ) {
        $scope.$watch('datamapperData', function(newData) {
          $scope.loadData(newData);
        });
      }
    ]
  };
});

app.run([
  '$templateCache',
  function($templateCache) {
    $templateCache.put('formio/components/datamappers.html', '&lt;span /&gt;');

    $templateCache.put('formio/formbuilder/datamappers.html', '&lt;span class="hidden-element-text"&gt;{{ component.label }}&lt;/span&gt;');
    // Create the common Data Mapper tab markup.
    $templateCache.put('formio/components/common/datamapper.html',
      '&lt;div class="row"&gt;' +
         '&lt;div class="col-md-6"&gt;' +
           '&lt;form-builder-option property="label" placeholder="Mapper Name"&gt;&lt;/form-builder-option&gt;' +
         '&lt;/div&gt;' +
         '&lt;div class="col-md-6"&gt;' +
           '&lt;form-builder-option-key&gt;&lt;/form-builder-option-key&gt;' +
         '&lt;/div&gt;' +
        '&lt;/div&gt;' +
        '&lt;div class="row"&gt;' +
        '&lt;div class="col-md-6"&gt;' +
        '  &lt;form-builder-option property="datamapperData.watchField" label="Watch Field" placeholder="empty watches all fields" title="Which data field to watch to refresh the map"&gt;&lt;/form-builder-option&gt;' +
        '&lt;/div&gt;' +
        '&lt;div class="col-md-6"&gt;' +
          '&lt;form-builder-option property="disabled"&gt;&lt;/form-builder-option&gt;' +
          '&lt;form-builder-option property="persistent"&gt;&lt;/form-builder-option&gt;' +
        '  &lt;form-builder-option type="checkbox" property="includeAllFields" label="Include all fields" title="All fields are automatically added to table"&gt;&lt;/form-builder-option&gt;' +
        '  &lt;form-builder-option type="checkbox" property="wrapInTable" label="Wrap in table" title="Wrap in HTML table"&gt;&lt;/form-builder-option&gt;' +
        '  &lt;form-builder-option type="checkbox" property="bottomsUp" label="Traverse array bottom to top" title="Traverse array bottom to top"&gt;&lt;/form-builder-option&gt;' +

        '&lt;/div&gt;' +
        '&lt;/div&gt;' +
        '&lt;div class="row"&gt;' +
          ' &lt;div class="col-md-6"&gt;' +
          '       &lt;div class="form-group"&gt;' +
          '       &lt;label for="triggerType" form-builder-tooltip="Trigger Type "&gt;Trigger Type&lt;/label&gt;' +
          '       &lt;select class="form-control" id="triggerType" name="triggerType" ng-options="triggerType.name as triggerType.title for triggerType in triggerTypes" ng-model="component.triggerType"&gt;&lt;/select&gt;' +
          '       &lt;/div&gt;' +
          '   &lt;/div&gt;' +
        '   &lt;/div&gt;' +
        '  &lt;datamapper-builder datamapper-data="component.datamapperData" /&gt;' +
        '&lt;div class="row"&gt;' +
        '   &lt;div class="col-md-6"&gt;' +
        '&lt;form-builder-option property="disabled"&gt;&lt;/form-builder-option&gt;' +
        '   &lt;/div&gt;' +
        '   &lt;div class="col-md-6"&gt;' +
        '&lt;form-builder-option type="checkbox" property="preventExecuteOnLoad" label="Prevent execution while loading data" title="Should this component be able to execute while data is loading"&gt;&lt;/form-builder-option&gt;' +
        '   &lt;/div&gt;' +
        '&lt;/div&gt;' +
        '&lt;div class="row"&gt;' +
        '  &lt;div class="col-md-12"&gt;' +
        '    &lt;form-builder-option-tags&gt;&lt;/form-builder-option-tags&gt;' +
        '  &lt;/div&gt;' +
        '&lt;/div&gt;'

    );
  }
]);

</t>
<t tx="josephorr.20171226191602.1">@language javascript
var app = angular.module('unQork');

&lt;&lt; component &gt;&gt;
&lt;&lt; builder &gt;&gt;
&lt;&lt; templates &gt;&gt;
</t>
<t tx="josephorr.20171226201424.1">app.config([
  'formioComponentsProvider',
  function (formioComponentsProvider) {
    formioComponentsProvider.register('initializer', {
      group: 'data',
      fbtemplate: 'formio/formbuilder/initializers.html',
      title: 'Initializer',
      template: 'formio/components/initializers.html',
      &lt;&lt; controller &gt;&gt;
      icon: 'fa fa-sliders',
      settings: {
        input: false,
        tableView: false,
        key: 'initializerField',
        label: '',
        protected: false,
        unique: false,
        persistent: false,
        initializerData: {
          dataInputObject: [],
          dataOutputObject: []
        },
        triggerType: 'watch'
      },
      views: [
        {
          name: 'Initializer',
          template: 'formio/components/common/initializer.html'
        }
      ],
      &lt;&lt; onEdit &gt;&gt;
    });
  }
]);

</t>
<t tx="josephorr.20171226201452.1">app.directive('initializerBuilder', function ($parse, FormioUtils) {
  return {
    restrict: 'E',
    scope: {
      initializerData: '='
    },
    template: '' +
    '&lt;div&gt;' +
    '  &lt;div class="row"&gt;' +
    '    &lt;div class="col-xs-6"&gt;' +
    '      &lt;h5&gt;Inputs&lt;/h5&gt;' +
    '      &lt;div class="hotInputs" /&gt;' +
    '    &lt;/div&gt;' +
    '    &lt;div class="col-xs-6"&gt;' +
    '      &lt;h5&gt;Outputs&lt;/h5&gt;' +
    '      &lt;div class="hotOutputs" /&gt;' +
    '    &lt;/div&gt;' +
    '  &lt;/div&gt;' +
    '&lt;/div&gt;',
    link: function (scope, element) {
      var initializerData = scope.initializerData;
      var components = [];
      var fields = [];
      FormioUtils.eachComponent(scope.$parent.form.components, function (component) {
        // Only add input elements.
        if (['button', 'initializer'].indexOf(component.type) === -1 &amp;&amp; component.key.indexOf('panel') !== 0) {
          components.push(component);
          fields.push(component.key);
        }
      }, true);
      fields.push('buttonClick');
      scope.saveData = function () {
        if (initializerData.dataInputObject == undefined) {
          return;
        } // jshint ignore:line
        initializerData.dataOutputObject = getTableData(hotOutputs);
        initializerData.dataInputObject = getTableData(hotInputs);

        scope.initializerData = initializerData;

      };

      function getTableData(hotTable) {
        var cellData = hotTable.getData();
        var headerData = hotTable.getColHeader();
        var dataTable = [];
        for (var k = 0; k &lt; cellData.length; k++) {
          var dataRow = {};
          if (!hotTable.isEmptyRow(k)) {
            for (var i = 0; i &lt; cellData[k].length; i++) {
              var key = headerData[i];
              var cellValue = cellData[k][i];

              if (cellValue === null) {
                cellValue = '';
              }

              dataRow[key] = cellValue;
            }
            dataTable.push(dataRow);
          }
        }
        return dataTable;
      }

      scope.loadData = function (initializerData) {

        if (initializerData.dataInputObject === undefined) {
          return;
        }
        hotInputs.updateSettings({
          data: initializerData.dataInputObject
        });
        hotOutputs.updateSettings({
          data: initializerData.dataOutputObject
        });
      };

      var hotInputElement = element[0].querySelector('.hotInputs');
      var hotInputSettings = {
        data: initializerData.dataInputObject,
        columns: [
          {
            data: 'id',
            type: 'autocomplete',
            source: fields.sort(),
            strict: false
          },
          {
            data: 'required',
            type: 'checkbox'
          }

        ],
        colWidths: [250, 85],
        rowHeights: 23,
        // performance tip: turn off calculations
        autoWrapRow: true,
        height: 200,
        rowHeaders: false,
        colHeaders: [
          'id', 'required'
        ],
        manualColumnResize: true,
        dropdownMenu: false,
        minSpareRows: 4,
        stretchH: 'all'
      };

      var hotInputs = new Handsontable(hotInputElement, hotInputSettings);

      var hotOutputElement = element[0].querySelector('.hotOutputs');
      var hotOutputSettings = {
        data: initializerData.dataOutputObject,
        columns: [
          {
            data: 'id',
            type: 'autocomplete',
            source: fields.sort(),
            strict: false
          },
          {
            data: 'type',
            type: 'dropdown',
            source: ['value', 'minimum', 'maximum', 'steps', 'visible', 'required', 'disabled', 'message', 'clicked', 'page', 'requiredAndVisible', 'pattern', 'label', 'content', 'customClass', 'trigger']
          },
          {
            data: 'value',
            type: 'text'
          }
        ],
        colWidths: [150, 100, 200],
        rowHeights: 23,
        // performance tip: turn off calculations
        autoWrapRow: true,
        height: 200,
        rowHeaders: false,
        colHeaders: [
          'id',
          'type',
          'value'
        ],
        manualColumnResize: true,
        dropdownMenu: false,
        minSpareRows: 4,
        stretchH: 'all'
      };

      var hotOutputs = new Handsontable(hotOutputElement, hotOutputSettings);

      angular.element(function () {
        hotInputs.render();
        hotOutputs.render();
      });

    },
    controller: [
      '$scope',
      function ($scope) {
        $scope.$watch('initializerData', function (newData) {
          $scope.loadData(newData);
        });
      }
    ]
  };
});
</t>
<t tx="josephorr.20171226201522.1">app.run([
  '$templateCache',
  function ($templateCache) {
    $templateCache.put('formio/formbuilder/initializers.html', '&lt;span class="hidden-element-text"&gt;{{ component.label }}&lt;/span&gt;');
    $templateCache.put('formio/components/initializers.html', '&lt;span /&gt;');
    
    // Create the common Initializers tab markup.
    $templateCache.put('formio/components/common/initializer.html',

      '&lt;div class="row"&gt;' +
      '&lt;div class="col-md-6"&gt;' +
      '&lt;form-builder-option property="label" placeholder="Initializer Name"&gt;&lt;/form-builder-option&gt;' +
      '&lt;/div&gt;' +
      '&lt;div class="col-md-6"&gt;' +
      '&lt;form-builder-option-key&gt;&lt;/form-builder-option-key&gt;' +
      '&lt;/div&gt;' +
      '&lt;/div&gt;' +
      '&lt;div class="row"&gt;' +
      ' &lt;div class="col-md-6"&gt;' +
      '       &lt;div class="form-group"&gt;' +
      '       &lt;label for="triggerType" form-builder-tooltip="Trigger Type "&gt;Trigger Type&lt;/label&gt;' +
      '       &lt;select class="form-control" id="triggerType" name="triggerType" ng-options="triggerType.name as triggerType.title for triggerType in triggerTypes" ng-model="component.triggerType"&gt;&lt;/select&gt;' +
      '       &lt;/div&gt;' +
      '   &lt;/div&gt;' +
      '&lt;div class="col-md-6"&gt;' +
      '        &lt;label for="debounceSetting" form-builder-tooltip="The amount of milliseconds to wait between calls"&gt;Debounce Setting&lt;/label&gt;' +
      '        &lt;input type="text" class="form-control" id="debounceSetting" name="debounceSetting" ng-model="component.debounceSetting" placeholder="" /&gt;' +
      '&lt;/div&gt;' +
      '   &lt;/div&gt;' +
      '  &lt;initializer-builder initializer-data="component.initializerData" /&gt;' +
      '&lt;div class="row"&gt;' +
      '   &lt;div class="col-md-6"&gt;' +
      '&lt;form-builder-option property="disabled"&gt;&lt;/form-builder-option&gt;' +
      '   &lt;/div&gt;' +
      '   &lt;div class="col-md-6"&gt;' +
      '&lt;form-builder-option type="checkbox" property="preventExecuteOnLoad" label="Prevent execution while loading data" title="Should this component be able to execute while data is loading"&gt;&lt;/form-builder-option&gt;' +
      '   &lt;/div&gt;' +
      '&lt;/div&gt;' +
      '&lt;div class="row"&gt;' +
      '  &lt;div class="col-md-12"&gt;' +
      '    &lt;form-builder-option-tags&gt;&lt;/form-builder-option-tags&gt;' +
      '  &lt;/div&gt;' +
      '&lt;/div&gt;'
    );
  }
]);

</t>
<t tx="josephorr.20171226201803.1">controller: [
  '$scope', '$interpolate', '$interval',
  function ($scope, $interpolate, $interval) {
    
    if ($scope.builder) { return } // Don't do calculations in form builder.
    &lt;&lt; scope.execute &gt;&gt;
    cleanEmptyValues($scope.component.initializerData, $scope.$parent.form);
    &lt;&lt; listen for each input component &gt;&gt;
    
  }
],

</t>
<t tx="josephorr.20171226201828.1">onEdit: ['$scope', function ($scope) {
  $scope.triggerTypes = [
    {
      'name': 'watch',
      'title': 'Watch'
    },
    {
      'name': 'manual',
      'title': 'Manual'
    }]
}]

</t>
<t tx="josephorr.20171226204831.1">$scope.execute = function () {
  if ($scope.component.disabled === true || (!LOADING_COMPLETE &amp;&amp; $scope.component.preventExecuteOnLoad === true)) {
    return;
  }
  var data = $scope.submission ? $scope.submission.data : {};
  var initializerData = $scope.component.initializerData;

  var hasFormula = setDataValues(initializerData.dataInputObject, data, false);
  if (hasFormula == undefined) { return }
  if (hasFormula) {
    processFormulas(initializerData.dataInputObject, [], false);
  }

  processFormulas(initializerData.dataInputObject, initializerData.dataOutputObject, true);

  for (var j = 0; j &lt; initializerData.dataOutputObject.length; j++) {
    var output = initializerData.dataOutputObject[j];
    if (_.startsWith(output.id, '{{')) {
      output = _.cloneDeep(output);
      output.id = $interpolate(output.id)({
        data: $scope.submission.data || {},
        row: $scope.row
      });
    }
    setOutputValues(output, output.value, data, $scope.$parent.form);
  }
  console.log('end ' + $scope.component.key + ' ' + new Date());
};</t>
<t tx="josephorr.20171226204934.1">// Listen for each input component.
var firstKey = _.get($scope.component.initializerData.dataInputObject[0], 'id', '');
if (firstKey === $scope.component.key) {
  if (!$scope.loadLoopInitial) {
    $scope.loadLoopInitial = $interval(function () {
      if (SUBMISSION_LOADED &amp;&amp; FORM_LOADED &amp;&amp; LOADING_COMPLETE) {
        console.log('Loading Complete, id:', $scope.submission._id);
        $interval.cancel($scope.loadLoopInitial);
        if (!$scope.submission._id) {
          // angular.element(function () {
            $scope.data[$scope.component.key] = 'loaded';
            $scope.execute();
          // });
        }
      }
    }, 100);
  }
} else if ($scope.component.triggerType !== 'manual') {
  var debounceSetting = 100;
  if ($scope.component.debounceSetting &amp;&amp; !_.isNaN(parseInt($scope.component.debounceSetting))) {
    debounceSetting = parseInt($scope.component.debounceSetting);
  }
  var watchers = {};
  var filterDelayed = function ($scope) {
    $scope.$apply($scope.execute);
  };
  var filterThrottled = _.debounce(filterDelayed, debounceSetting);
  $scope.component.initializerData.dataInputObject.forEach(function (key) {
    var keyId = key.id + '';

    if (keyId.indexOf('.') &gt; 0) {
      var res = keyId.split('.');
      keyId = res[0];
    }
    if (keyId &amp;&amp; !_.has(watchers, keyId) &amp;&amp; !key.silent) {
      _.set(watchers, keyId, '');
      $scope.$watch('submission.data.' + keyId, function () {
        filterThrottled($scope);
      }, true);
    }
  });
}</t>
</tnodes>
</leo_file>

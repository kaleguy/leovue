
var app = angular.module('unQork');
console.log('LEO VERSION')
/**
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
      controller: [
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
          if (url && url.substr(0, 1) === '/') {
            url = Formio.getBaseUrl() + url;
          }
          var db = {
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
                  if (colFilter && colValue.toLowerCase().indexOf(colFilter.toLowerCase()) < 0){
                    return f = false;
                  }
                });
                return f;
              });
            },
            records: []
          };

          var setCurrentRow = function (item, index) {
              // change for demo
              var outputList = $scope.component.viewgridData.dataOutputObject;
              if (outputList.length > 0) {
                for (var j = 0; j < outputList.length; j++) {
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

          var executeViewgrid = function(fields) {
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
                var commandButton = '<button type="button"  class="btn btn-secondary-3 pull-right"\> ' + action + ' </button>';
                return commandButton;
              }
            };
            if (action !== 'null') {
              fields.push(buttonField);
            }
            $("#jsGrid_" + labelId).jsGrid({
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
                    // onclick="buttonClick(event, \'' + actionKey + '\')">' + action + '
                    // $state.go('displaySubmission', {formId: formId, submissionId: r.item.id});
                  }
              });

            // execute table filters on keydown
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

          };

          var loadDataFromEvent = function () {
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

          $scope.component.viewgridData.dataInputObject.forEach(function(key) {
            if (key.id) {
              $scope.$watch('submission.data.' + key.id, loadDataFromEvent, true);
            }
          });

          var processResult =  function(result) {
            if (_.get(result, 'data.records')) {
              result.data = result.data.records
            }
            var formulaFields = [];
            _.each (viewgridData.dataDisplayObject, function (r) {
                if (r.formula) {
                    // add to list of formula fields
                    formulaFields.push(r);
                }
            });
            if (!result.data.reduce) {

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
            var fieldIds = fields.reduce(function(acc, f){
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
                if (formulaFields.length > 0) {
                    var parser = new formulaParser.Parser();
                    _.each(row, function (value, key) {
                        parser.setVariable(key, value);
                    });
                    _.each(formulaFields, function (r) {
                        var result = parser.parse(r.formula.substring(1)).result;
                        _.set( row, r.id, result);
                    });
                }

                acc.push(row);
                return acc;
            }, []);
            // debugger

            executeViewgrid(fields);
          }

          var options = { params: {} };
          for (var i = 0; i < keys.length; i++) {
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

        }
      ],

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

// property panel (lower part)
app.directive('viewgridBuilder', function($parse, FormioUtils) {
  return {
    restrict: 'E',
    scope: {
      viewgridData: '='
    },
    template: '' +
        '<div>' +
        '  <div class="row">' +
        '    <div class="col-xs-6">' +
        '      <h5>Inputs</h5>' +
        '      <div class="hotInputs" />' +
        '    </div>' +
        '    <div class="col-xs-6">' +
        '      <h5>Outputs</h5>' +
        '      <div class="hotOutputs" />' +
        '    </div>' +
        '  </div>' +
        '  <div class="row">' +
        '    <div class="col-xs-12">' +
        '      <h5>Display</h5>' +
        '      <div class="hotDisplay" />' +
        '    </div>' +
        '  </div>' +
        '</div>',
    link: function(scope, element, attrs) { // jshint ignore:line
      var viewgridData = scope.viewgridData;
      var components = [];
      var fields = [];
      FormioUtils.eachComponent(scope.$parent.form.components, function(component) {
        // Only add input elements.
        if (['button', 'viewgrid'].indexOf(component.type) === -1 && component.key.indexOf('panel') !== 0) {
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
        for (var k=0; k < cellData.length; k++) {
          var dataRow = {};
          if (!hotTable.isEmptyRow(k)) {
            for (var i =0; i < cellData[k].length; i++) {
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

app.run([
  '$templateCache',
  function($templateCache) {

    // the template for Edit view
    $templateCache.put('formio/formbuilder/viewgrids.html', '<span class="hidden-element-text">{{ component.label }}</span>');

    // The property panel (top part)
    $templateCache.put('formio/components/common/viewgrid.html',
      '<div class="row">' +
      ' <div class="col-md-6">' +
      '   <form-builder-option property="label" placeholder="Viewgrid Name"></form-builder-option>' +
      ' </div>' +
      ' <div class="col-md-6">' +
      '   <form-builder-option-key></form-builder-option-key>' +
      ' </div>' +
      '</div>' +
      '<div class="row">' +
      ' <div class="col-md-6">' +
      '  <form-builder-option type="checkbox" property="viewgridData.showTitle" label="Show Title" title="Whether to show a title over the view grid."></form-builder-option>' +
      ' </div>' +
      ' <div class="col-md-6">' +
      '  <form-builder-option property="viewgridData.showFilters" type="checkbox" label="Show Filters" title="Display grid with column filters."></form-builder-option>' +
      ' </div>' +
      '</div>' +
      '<div class="row">' +
              ' <div class="col-md-6">' +
              '  <form-builder-option property="viewgridData.height" label="Grid Height" title="Grid pixel height."></form-builder-option>' +
              ' </div>' +
              ' <div class="col-md-6">' +
              '  <form-builder-option property="viewgridData.pageSize" label="Page Size" title="Number of records to display per page."></form-builder-option>' +
              ' </div>' +
              '</div>' +
      '<div class="row">' +
      '  <div class="col-md-6">' +
      '   <form-builder-option property="viewgridData.action" label="Action" title="Add button with specified action."></form-builder-option>' +
      '  </div>' +
      '  <div class="col-md-6">' +
      '   <form-builder-option property="viewgridData.event" label="Event" title="Optional event to raise if clicked, otherwise uses Action."></form-builder-option>' +
      '  </div>' +
      '</div>' +
      '<div class="row">' +
      '  <div class="col-md-6">' +
      '   <form-builder-option property="viewgridData.noDataText" label="No Data Text" placeholder="Not found" title="Text for when there\'s no data to display"></form-builder-option>' +
      '  </div>' +
      ' <div class="col-md-6">' +
      '  <form-builder-option property="viewgridData.sourceUrl" label="Data Source URL" placeholder="Data Source URL" title="A URL that returns a JSON array to use as the data source."></form-builder-option>' +
      ' </div>' +
      '</div>' +
      '<div class="row" style="display:none">' +
      ' <div class="col-md-6">' +
      '  <label for="boundPanel" form-builder-tooltip="Panel containing the fields/edit components.">Bound Panel</label>' +
      '  <select class="form-control" id="boundPanel" name="boundPanel" ng-change="setPanel(component.boundPanel)"  ng-options="field.key as field.key for field in panelFields" ng-model="component.boundPanel"></select>' +
      '</div>' +
      '</div>' +
      '<div class="row">' +
      '</div>' +
      '  <viewgrid-builder viewgrid-data="component.viewgridData" />' +
      '</div>' +
      '<div class="row">' +
      '  <div class="col-md-12">' +
      '    <form-builder-option-tags></form-builder-option-tags>' +
      '  </div>' +
      '</div>'
    );
  }
]);

// The View Template
app.run([
  '$templateCache',
  function($templateCache) {
    $templateCache.put('formio/components/viewgrids.html',
      '<h3 class="component-title" ng-show="component.viewgridData.showTitle">{{ component.label }}</h3>' +
      '<div id="jsGrid_{{labelId}}"></div>' +
      '<div ng-show="dummy()"></div>'
    );

  }
]);







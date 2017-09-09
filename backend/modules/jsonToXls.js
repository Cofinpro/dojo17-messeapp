var json2xls = require('json2xls');
var fs = require('fs');
var moment = require('moment');
var _ = require('lodash');
var nodeExcel = require('excel-export');

var createStyle = function() {
  var conf = {};
  conf.stylesXmlFile = "styles.xml";
  conf.name = "mysheet";
  conf.cols = [{
    caption: 'string',
    type: 'string',
    beforeCellWrite: function (row, cellData) {
      return cellData.toUpperCase();
    },
    width: 28.7109375
  }, {
    caption: 'date',
    type: 'date',
    beforeCellWrite: function () {
      var originDate = new Date(Date.UTC(1899, 11, 30));
      return function (row, cellData, eOpt) {
        if (eOpt.rowNum % 2) {
          eOpt.styleIndex = 1;
        }
        else {
          eOpt.styleIndex = 2;
        }
        if (cellData === null) {
          eOpt.cellType = 'string';
          return 'N/A';
        } else
          return (cellData - originDate) / (24 * 60 * 60 * 1000);
      }
    }()
  }, {
    caption: 'bool',
    type: 'bool'
  }, {
    caption: 'number',
    type: 'number'
  }];
  conf.rows = [
    ['pi', new Date(Date.UTC(2013, 4, 1)), true, 3.14],
    ["e", new Date(2012, 4, 1), false, 2.7182],
    ["M&M<>'", new Date(Date.UTC(2013, 6, 9)), false, 1.61803],
    ["null date", null, true, 1.414]
  ];

  return conf;
};

var SaveJsonAsXls = function(jsonArr)
{

  _.forEach(jsonArr, (value) => {
    if (value.internship === false)
      value.internship = "";
    else
      value.internship = "Ja";

    if (value.exam === false)
      value.exam = "";
    else
      value.exam = "Ja";

    if (value.student === false)
      value.student = "";
    else
      value.student = "Ja";

    if (value.dhbw === false)
      value.dhbw = "";
    else
      value.dhbw = "Ja";//

    if (value.boarding === false)
      value.boarding = "";
    else
      value.boarding = "Ja";

    //Datum parsen
    var graduationDate = new Date(value.graduationDate);
    var m = moment(graduationDate);
    value.graduationDate = m.format("DD.MM.YYYY HH:MM");

    var timestamp = new Date(value.timestamp);
    m = moment(timestamp);
    value.timestamp = m.format("DD.MM.YYYY HH:MM");

    //id && _v
    delete(value._id);
    delete(value.__v);
  });

  var xls = json2xls(jsonArr,{
    fields: { salutation : 'string'}
  });

  fs.writeFileSync('../export/data.xlsx', xls, 'binary');

  return("\backend\modules\data.xlsx");
};

module.exports.JsonToXls = SaveJsonAsXls;




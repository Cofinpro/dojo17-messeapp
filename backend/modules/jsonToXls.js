var json2xls = require('json2xls');
var fs = require('fs');
var moment = require('moment');
_ = require('lodash');

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

  var xls = json2xls(jsonArr);
  fs.writeFileSync('./export/data.xlsx', xls, 'binary');

  return "./export/data.xlsx";
};

module.exports.JsonToXls = SaveJsonAsXls;




const _ = require('lodash');
const fs = require('fs');
const file = './helpers/dummy-object.json';
const objectTemplate = JSON.parse(fs.readFileSync(file, 'utf8'));

compareWithTemplate = function(dataObject) {
    if (_.isEqual(Object.keys(objectTemplate), Object.keys(dataObject))) return true;
}

module.exports.isValid = compareWithTemplate;
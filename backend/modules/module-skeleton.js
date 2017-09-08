myFunction = function (string) {
    console.log('Hallo ' + string);
};

secondFunction = function (string) {
    console.log('Bye ' + string);
};

myPrivateFunction = function() {
    // asdasd
}

module.exports.f1 = myFunction;
module.exports.f2 = secondFunction;

// Call in main Class:
// let mod = require('skeleton.js');
// mod.f1('Person');
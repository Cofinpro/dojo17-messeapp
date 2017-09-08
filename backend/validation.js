var fomularData = {
        //Anrede
        firstName:  "John",
        lastName:   "Doe",
        university: "Hochschule Darmstadt",
        course:     "Informatik",
        lastDegree: "Bachelor of Science Informatik",
        lastDegreeDate:"01.01.2017",
        eMail:      "John@doe.com",
        telephoneNumber: "0177/3432432424"
    };

var validatorFunction = function(fomularData) {

    //Check for empty values
    for (var o in fomularData){
        o.tri
    }
        if (fomularData[o] === "") return false;

    var testString = "woword";

    //Values that should only be alphabetic
    if(/[^a-zA-z ]/.test(fomularData.lastDegree))
        console.log("incorrect");

    return true;
};


module.exports.validateData = validatorFunction;
console.log(validatorFunction(fomularData));
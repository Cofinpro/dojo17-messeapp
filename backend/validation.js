var fomularData = {
  //Anrede
  firstName: "Joe",
  lastName: "Doe",
  university: "Hochschule Darmstadt",
  course: "Informatik",
  lastDegree: "Bachelor of Science Informatik",
  lastDegreeDate: "01.01.2017",
  eMail: "John@doe.com",
  telephoneNumber: "0177/3432432424"
};

var validatorFunction = function (fomularData) {

  //Check for empty values
  for (var o in fomularData) {
    if (fomularData[o].trim() === "" || String(fomularData[o]).length < 3) return false;
  }

  //Values that should only be alphabetic
  if (/[^a-zA-z ]/.test(fomularData.lastDegree))
    console.log("incorrect");

  return true;
};


module.exports.validateData = validatorFunction;
console.log(validatorFunction(fomularData));

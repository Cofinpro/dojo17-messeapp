var fomularData = {
  salutation: "Herr",
  first_name: "Joe",
  name: "Doe",
  university: "Hochschule Darmstadt",
  course: "Informatik",
  graduation: "Bachelor of Science Informatik",
  graduation_date: "01.01.2017",
  email: "John@doe.com",
  telephone: "0177/3432432424",
  interest: "Praktikum"
};

var validatorFunction = function (fomularData) {

  //Check for empty values
  for (var o in fomularData) {
    if (fomularData[o].trim() === "" || String(fomularData[o]).length < 3)
      return false;
  }

  //Values that shouldn´t contain numbers
  if (/[0-9]/.test(fomularData.salutation) ||
      /[0-9]/.test(fomularData.first_name) ||
      /[0-9]/.test(fomularData.name) ||
      /[0-9]/.test(fomularData.university) ||
      /[0-9]/.test(fomularData.course) ||
      /[0-9]/.test(fomularData.graduation) ||
      /[0-9]/.test(fomularData.interest)) {
    return false;
  }

  //Check Email
  if(!(/[@]/.test(fomularData.email))) {
    return false;
  }

  //Check number
  if(/[a-zA-Z]/.test(fomularData.graduation_date) || /[a-zA-Z]/.test(fomularData.telephone))
  {
    return false;
  }

  return true;
};


module.exports.validateData = validatorFunction;
console.log(validatorFunction(fomularData));

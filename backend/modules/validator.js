var validatorFunction = function (fomularData) {
  console.log('validiere');
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
      /[0-9]/.test(fomularData.interest.exam ||
      /[0-9]/.test(fomularData.interest.student) ||
      /[0-9]/.test(fomularData.interest.dhbw) ||
      /[0-9]/.test(fomularData.boarding))) {
    return false;
  }

  //Check Email
  if(!(/[@]/.test(fomularData.email))) {
    return false;
  }

  //Check number
  if(/[a-zA-Z]/.test(fomularData.graduation_date) || /[a-zA-Z]/.test(fomularData.telephone)) {
    return false;
  }

  return true;
};


module.exports.validateData = validatorFunction;
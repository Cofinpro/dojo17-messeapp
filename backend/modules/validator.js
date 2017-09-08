var validatorFunction = function (fomularData) {
  console.log('validiere');
  //Check for empty values
  if(fomularData.first_name.trim() === "" ||  /[0-9]/.test(fomularData.first_name) ||
    fomularData.name.trim() === "" || /[0-9]/.test(fomularData.name) ||
    fomularData.email.trim() === "")
  {
    return false;
  }

  //Values that shouldn´t contain numbers
  //Not used because the fields doesnt need to be filled
  //if (/[0-9]/.test(fomularData.salutation) ||
  //    /[0-9]/.test(fomularData.first_name) ||
  //    /[0-9]/.test(fomularData.name) ||
  //    /[0-9]/.test(fomularData.university) ||
  //    /[0-9]/.test(fomularData.course) ||
  //    /[0-9]/.test(fomularData.graduation) ||
  //    /[0-9]/.test(fomularData.interest.exam ||
  //    /[0-9]/.test(fomularData.interest.student) ||
  //    /[0-9]/.test(fomularData.interest.dhbw) ||
  //    /[0-9]/.test(fomularData.boarding))) {
  //  return false;
  //}

  //Check Email
  if(!(/[@]/.test(fomularData.email))) {
    return false;
  }

  //Check number
  //Not used because the fields doesnt need to be filled
  //if(/3[a-zA-Z]/.test(fomularData.graduation_date) || /[a-zA-Z]/.test(fomularData.telephone)) {
  //  return false;
  //}//

  console.log(validatorFunction(fomularData));
  return true;
};


module.exports.validateData = validatorFunction;

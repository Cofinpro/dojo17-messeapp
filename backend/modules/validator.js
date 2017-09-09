var validatorFunction = function (fomularData) {
  //Check for empty values
  if(fomularData.firstname.trim() === "" ||  /[0-9]/.test(fomularData.firstname) ||
    fomularData.name.trim() === "" || /[0-9]/.test(fomularData.name) ||
    fomularData.email.trim() === "")
  {
    return false;
  }

  //Check Email
  if(!(/[@]/.test(fomularData.email))) {
    return false;
  }

  return true;
};


module.exports.validateData = validatorFunction;

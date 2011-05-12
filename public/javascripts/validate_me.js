$(document).ready(function(){
  //global variables
  var email = $(".valid_email");
  
  HideAllWarnings();
  ClearAllTextboxes();
  
  //onChanged
  email.change(validate_email(email));
  
  
  
});


function validate_email() {
  var email = $(".valid_email");
  var filter = /^[a-zA-Z0-9]+[a-zA-Z0-9_.-]+[a-zA-Z0-9_-]+@[a-zA-Z0-9]+[a-zA-Z0-9.-]+[a-zA-Z0-9]+.[a-z]{2,4}$/;
  
  //if it's valid email
  if(filter.test(email)) {
    alert("valid");
  }
  
  //if it's NOT valid
  else {
    email.css("border","2px solid red");
  }		
}



function HideAllWarnings() {
  $(".valid_email_warning").hide();
  $(".valid_username_warning").hide();
  $(".valid_first_name_warning").hide();
  $(".valid_last_name_warning").hide();
  $(".valid_birth_warning").hide();
  $(".valid_pass1_warning").hide();
  $(".valid_pass2_warning").hide();
}



function ClearAllTextboxes() {
  $(".valid_email").empty();
}
















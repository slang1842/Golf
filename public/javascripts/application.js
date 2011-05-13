// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(document).ready(function() {
  bindHitFormPlan();
});
$(document).ready(function() {
  bindHitSwitch();
});
function bindHitFormPlan() {
  $('.hole_switch').live('click', function() {
    $('#nexthole').val($(this).attr('rel')); 
    $('#hit_form').submit(); 
    return false;
  });
}
function bindHitSwitch() {
  $('.hit_switch').live('click', function() {
    $('#nexthit').val($(this).attr('rel')); 
    $('#hit_form').submit(); 
    return false;
  });
}

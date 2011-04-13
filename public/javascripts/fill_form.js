$(document).ready(function(){

});

function fill_sticks_form(a) {
 
 //dabonam selected id
  var sel_id = ($(a).val() );
  //alert(sel_id);

  //dabonam info no id ar json
  $.getJSON('/sticks/' + sel_id + '.json', function(data) {
    
     $(a).parent().find('.distance').val(data.stick.distance);
     $(a).parent().find('.degrees').val(data.stick.degrees);
     $(a).parent().find('.shaft').val(data.stick.shaft);
     $(a).parent().find('.shaft_strength').val(data.stick.shaft_strength);
  });
};
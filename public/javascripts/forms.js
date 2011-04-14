$(document).ready(function(){
  datapicker();
});

function fill_sticks_form(a) {
  var sel_id = ($(a).val() );
  $.getJSON('/sticks/' + sel_id + '.json', function(data) {
     $(a).parent().find('.distance').val(data.stick.distance);
     $(a).parent().find('.degrees').val(data.stick.degrees);
     $(a).parent().find('.shaft').val(data.stick.shaft);
     $(a).parent().find('.shaft_strength').val(data.stick.shaft_strength);
  });
};

function datapicker() {
  $( "#datepicker" ).datepicker({
          changeMonth: true,
          changeYear: true,
          dateFormat: 'dd-mm-yy',
          yearRange: '1900:2011'
  });
}

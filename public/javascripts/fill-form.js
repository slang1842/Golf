$(document).ready(function(){
//
});

function fill_form(a) {
  
  alert('aaa')
  $.getJSON('/sticks/' + a.id + '.json', function(data) {
    var items = [];

    $.each(data, function(key, val) {
    alert(key + ': ' + val)
    };
    
  }
}
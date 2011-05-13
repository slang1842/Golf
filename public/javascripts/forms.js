$(document).ready(function(){
    datapicker();
    timepicker();
    init_dropdown();
});



function fill_sticks_form(a) {
    var sel_id = ($(a).val() );
    $.getJSON('/sticks/' + sel_id + '.json', function(data) {
        $(a).parent().parent().find('.distance').val(data.stick.distance);
        $(a).parent().parent().find('.degrees').val(data.stick.degrees);
        $(a).parent().parent().find('.shaft').val(data.stick.shaft);
        $(a).parent().parent().find('.shaft_strength').val(data.stick.shaft_strength);
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

function timepicker(){
    $('#timepicker').datetimepicker({
        currentText: 'Now',
        closeText: 'Done',
        ampm: false,
        timeFormat: 'hh:mm tt',
        timeOnlyTitle: 'Choose Time',
        timeText: 'Time',
        hourText: 'Hour',
        minuteText: 'Minute',
        secondText: 'Second'
    });
}



function init_dropdown() {		
    $('.dropdown1').selectmenu({
        style:'popup',
        width:120
    
    });
  
    $('.dropdown2').selectmenu({
        style:'popup',
        width:50
    
    });
  
    $('.dropdown3').selectmenu({
        style:'popup',
        width:110
    
    });
  
 
    $('.dropdown4').selectmenu({
        style:'popup',
        width:140
    });
  
    $('.dropdown5').selectmenu({
        style:'popup',
        width:130
    
    });
        
    $('.speedAa').selectmenu({
        style:'popup', 
        maxHeight: 300,
        wrapperElement: "<div class='wrap' />"
    });
  
    $('.speedB').selectmenu({
        style:'popup', 
        width: 300,
        format: addressFormatting
    });
  
    $('.speedC').selectmenu();
  
    $('.speedD').selectmenu({
        menuWidth: 400,
        format: addressFormatting
    });
  
    $('select#filesC').selectmenu({
        style:'popup', 
        positionOptions: {
            my: "left center",
            at: "right center",
            offset: "10 0"
        }
    });	
}		

//a custom format option callback
var addressFormatting = function(text){
    var newText = text;
    //array of find replaces
    var findreps = [
        {find:/^([^\-]+) \- /g, rep: '<span class="ui-selectmenu-item-header">$1</span>'},
        {find:/([^\|><]+) \| /g, rep: '<span class="ui-selectmenu-item-content">$1</span>'},
        {find:/([^\|><\(\)]+) (\()/g, rep: '<span class="ui-selectmenu-item-content">$1</span>$2'},
        {find:/([^\|><\(\)]+)$/g, rep: '<span class="ui-selectmenu-item-content">$1</span>'},
        {find:/(\([^\|><]+\))$/g, rep: '<span class="ui-selectmenu-item-footer">$1</span>'}
    ];
  
    for(var i in findreps){
        newText = newText.replace(findreps[i].find, findreps[i].rep);
    }
    return newText;
}	

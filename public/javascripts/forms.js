$(document).ready(function(){
    datapicker();
    timepicker();
   
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

function check_bag_form() {
    big_textboxes = $(".dropdown4")
    small_textboxes = $(".dropdown2")
    
    $("input[type=text]").each(function() {
        if (textEntered && $(this).val().length == 0) {
            textEntered = false;
        }
        else {
             textEntered = true;
        }
    });
                
                
    if (textEntered) {
        alert("ir ok");
        return true
        //$("#btnSubmit").attr("disabled", "");
    } else {
        alert("NAV ok");
        return false
        //$("#btnSubmit").attr("disabled", "disabled");
    }
                
/*
    $.each(big_textboxes, function(value) {
        if (value == "") {
            alert("empy value")
        }        
    }); 
    
    $.each(small_textboxes, function(value) {
        if (value == "") {
            alert("empy value")
        }        
    }); 
    */
}
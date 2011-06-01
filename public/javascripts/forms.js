$(document).ready(function(){
    datapicker();
    timepicker();
    gamedatepicker();
});



function render_sticks() {
    
}

function fill_sticks_form(a) {
    var sel_id = ($(a).val() );
    $.getJSON('/sticks/' + sel_id + '.json', function(data) {
        $(a).parent().parent().find('.distance').val(data.stick.distance);
        $(a).parent().parent().find('.degrees').val(data.stick.degrees);
        $(a).parent().parent().find('.shaft').val(data.stick.shaft);
        $(a).parent().parent().find('.shaft_strength').val(data.stick.shaft_strength);
    });
};

function gamedatepicker() {
    $( ".gamedatepicker" ).datetimepicker({
        changeMonth: true,
        changeYear: true,
        dateFormat: 'dd.mm.y',
        yearRange: '1900:2011',
        firstDay :1
    });
}


function datapicker() {
    $( "#datepicker" ).datepicker({
        changeMonth: true,
        changeYear: true,
        dateFormat: 'dd.mm.y',
        yearRange: '1900:2011',
         firstDay: 1
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
        secondText: 'Second',
        firstDay: 1
    });
}

function check_bag_form() {
    textEntered = true

    $("input").each(function() {
        if (textEntered && $(this).val().length == 0) {
            textEntered = false;
        }
    });

    $("select").each(function() {
        if (textEntered && $(this).val() == "") {
            textEntered = false;
        }
    });
                
    if (textEntered) {
        return true
    } else {
        $(".error").slideUp('fast').slideDown('slow');
        return false
    }
   
}

function check_user_form() {
    textEntered = true

    $(".user_text_field").each(function() {
        if (textEntered && $(this).val().length == 0) {
            textEntered = false;
        }
    });

    $(".user_select_field").each(function() {
        if (textEntered && $(this).val() == "") {
            textEntered = false;
        }
    });
                
    if (textEntered) {
        return true
    } else {
        $(".error").slideDown('slow');
        return false
    }
   
}

function check_game_form() {
    textEntered = true

   

    $(".game_input_select").each(function() {
        if (textEntered && $(this).val() == "") {
            textEntered = false;
        }
    });
                
    if (textEntered) {
        return true
    } else {
        $(".error").slideDown('slow');
        return false
  
}

}
function golf_club_checkbox(){
    if ($("#golf_club_label").is(":hidden")) {
        $("#golf_club_label").slideDown("fast");
    } else {
        $("#golf_club_label").slideUp("fast");
    }
    
    if ($("#user_golf_club_id").is(":hidden")) {
        $("#user_golf_club_id").slideDown("fast");
        
    } else {
        $("#user_golf_club_id").slideUp("fast", function() {
            $("#user_golf_club_id").val("");
        });
        
    }        
}


function showHideElement(whichLayer){
  if ($(whichLayer).css("display") == 'block' ) {
    $(whichLayer).hide();
  } else {
    $(whichLayer).show();
  }
}
    
    
function check_admin_pay_banner(x){
    $("#timepicker").val("")
};
  


function hint_delete_text_field(x) {
  $(x).Parent().find("textarea").val() = "";
}






















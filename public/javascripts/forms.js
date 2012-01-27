    $(document).ready(function(){
  datapicker();
  userdatapicker();
  timepicker();
  admintimepicker();
  gamedatepicker();
  serialScroll();
a();
});

function a() {

        if ( $("#user_add_club").attr('checked') )
        {
            $("#user_golf_club_id").hide();
        }
        else
        {
            $("#user_golf_club_id").show();
        }
}


function serialScroll() {
  $('#slideshow').serialScroll({
    items:'li',
    prev:'.link_left_wrap a.prev',
    next:'.link_right_wrap a.next',
    offset:0, //when scrolling to photo, stop 230 before reaching it (from the left)
    start:0, //as we are centering it, start at the 2nd
    duration:400,
    force:true,
    stop:true,
    lock:false,
    cycle:true, //don't pull back once you reach the end
    easing:'easeOutQuart', //use this easing equation for a funny effect
    jump: false //click on the images to scroll to them
  });
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

function userdatapicker() {
  $( "#userdatapicker" ).datepicker({
    changeMonth: true,
    changeYear: true,
    dateFormat: 'yy-mm-dd',
    yearRange: '1900:2011',
    firstDay: 1
  });
}

function admintimepicker() {
  $( "#admintimepicker" ).datepicker({
    changeMonth: true,
    changeYear: true,
    dateFormat: 'yy-mm-dd',
    yearRange: '2011:2015',
    firstDay: 1
  });
}


function timepicker(){
  $('#timepicker').datetimepicker({
    currentText: 'Now',
    closeText: 'Done',
    ampm: false,
    dateFormat: 'yy-mm-dd',
    timeFormat: 'hh:mm tt',
    timeOnlyTitle: 'Choose Time',
    timeText: 'Time',
    hourText: 'Hour',
    minuteText: 'Minute',
    secondText: 'Second',
    firstDay: 1
  //2011-06-14 00:00:00
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
    $(".messages_error").slideUp('fast').slideDown('slow');
    return false
  }
   
}
/*
function check_user_form() {
  textEntered = true

  $(".user_text_field").each(function() {
    if ($(this).val().length == 0) {
      textEntered = false;
    }
    else {
      textEntered = true
    }

    $(".user_select_field").each(function() {
      if ($(this).val() == "") {
        textEntered = false;
      }
      else {
        textEntered = true
      }
    
    });

    if (textEntered) {
      return true
    } else {
      $(".messages_error").slideDown('slow', function(){
        $sleep(3, function(){
          $(".messages_error").sideUp('slow')
        })
      });
      return false
    }
  }
 */

function check_user_form() {
  var textEntered = true
  
  
  $(".user_text_field").each(function(){
    if ($(this).val() == "") {
      textEntered = false
    }
  })

  $(".user_select_field").each(function(){
    if ($(this).val() == "") {
      textEntered = false
    }
  })

  if ($("#user_first_name").val() == "") {
    textEntered = false
  }

  if ($("#userdatapicker").val() == "") {
    textEntered = false
  }


  if (textEntered == false) {    
    if ($(".messages_error").css("display") == 'block' ) {
      $(".messages_error").slideUp("fast").slideDown('slow');
    } else {
      $(".messages_info").slideUp("fast");
      $(".messages_error").slideDown('slow');
    }
    return false
  }
  else {
    return true
  }


}



function check_game_form() {
  var textEntered = true

  $(".game_input_select").each(function(){
    if ($(this).val() == "") {
      textEntered = false
    }
  })

  if ($("#game_field_id").val() == "") {
    textEntered = false
  }

  if (textEntered == false) {
    if ($(".messages_error").css("display") == 'block' ) {
      $(".messages_error").slideUp("fast").slideDown('slow');
    } else {
      $(".messages_error").slideDown('slow');
    }
    return false
  }
  else {
    return true
  }

}

function golf_club_checkbox(){
  $("#user_golf_club_id").toggle();
  $("#user_golf_club_id").val("");
}


function showHideElement(whichLayer){
	var api = $("#stats_div").data('jsp');
		api.destroy();
  if ($(whichLayer).css("display") == 'block' ) {
    $(whichLayer).hide();
  } else {
    $(whichLayer).show();
  }
	$("#stats_div").jScrollPane({hideFocus: true});
	//scrollpane.reinitialise({contentWidth: 812});
}
    
    
function check_admin_pay_banner(x){
  $("#timepicker").val("")
};
  


function hint_delete_text_field(x) {
  $(x).Parent().find("textarea").val() = "";
}


function user_place_in_golf_club() {
  //$("#table_result_wrap_box").hide();
  $("#user_place_in_golf_club").submit();
};



/* === custom methodes ===*/

$.wait = function(time) {
  return $.Deferred(function(dfd) {
    setTimeout(dfd.resolve, time);
  });
}

//to use it
//
//  $.wait(3000).then(function()
//  {
//    alert("I slept for 3 seconds!");
//  });

/* === custom methodes ===*/

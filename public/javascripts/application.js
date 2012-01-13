// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(document).ready(function() {
  bindHitFormPlan();
});
$(document).ready(function() {
  bindHitSwitch();
});
$(document).ready(function() {
  bindSaveSwitch();
  });



function bindHitFormPlan() {

  $('.hole_switch').live('click', function() {
    textEntered = true
    $(".game_input_select").each(function() {
        if (textEntered && $(this).val() == "") {
            textEntered = false;
        }
    });
                
    if (textEntered) {
      $('.messages_error').hide();
     $('#nexthole').val($(this).attr('rel'));
    $('.single_hole').replaceWith('<img src="/images/ajax-loader-small.gif" style="position:relative; top:18px; margin-left:7px;" />');
    var i = $('#stick_type_old').val();
    $('.stick_type_real').val(i);
    $('#hit_form').submit(); 
    return false;
    }
    else {
        if ($(".messages_error").css("display") == 'block' ) {
      $(".messages_error").slideUp("fast").slideDown('slow');
    } else {
      $(".messages_info").slideUp("fast");
      $(".messages_error").slideDown('slow');
    }
        return false}
  });
    
   
  
  
}
function bindHitSwitch() {
  $('.hit_switch').live('click', function() {
    textEntered = true
    $(".game_input_select").each(function() {
        if (textEntered && $(this).val() == "") {
            textEntered = false;
        }
    });
                
    if (textEntered) {
      $('.messages_error').hide();
     $('#nexthit').val($(this).attr('rel')); 
    $('.gif_placeholder').empty();
    $('.gif_placeholder').append('<img src="/images/ajax-loader.gif" />');
     var i = $('#stick_type_old').val();
    $('.stick_type_real').val(i);

    $('#hit_form').submit(); 
    return false;
   
    }
    else {
        if ($(".messages_error").css("display") == 'block' ) {
      $(".messages_error").slideUp("fast").slideDown('slow');
    } else {
      $(".messages_info").slideUp("fast");
      $(".messages_error").slideDown('slow');
    }
        return false}
  });

    
}

function bindSaveSwitch() {
  $('.saveswitch').live('click', function() {
    
    textEntered = true
     $(".game_input_select").each(function() {
        if (textEntered && $(this).val() == "") {
            textEntered = false;
        }
    });
                
    if (textEntered) {
      $('.messages_error').hide();
     $('#nexthit').val($(this).attr('rel')); 
      var i = $('#stick_type_old').val();
    $('.stick_type_real').val(i);
    $('.save_gif').replaceWith('<img src="/images/ajax-loader.gif" />');
    $('#hit_form').submit(); 
    return false;
    }
    else {
      if ($(".messages_error").css("display") == 'block' ) {
      $(".messages_error").slideUp("fast").slideDown('slow');
    } else {
      $(".messages_info").slideUp("fast");
      $(".messages_error").slideDown('slow');
    }
       
        return false}
  });
}

function checkFieldName() {
  textEntered = true
     $(".field_name_field").each(function() {
        if (textEntered && $(this).val() == "") {
            textEntered = false;
        }
    });
 if (textEntered) {
      $('.messages_error').hide();
        $('form').submit(); 
      }
       else {
        if ($(".messages_error").css("display") == 'block' ) {
      $(".messages_error").slideUp("fast").slideDown('slow');
    } else {
      $(".messages_info").slideUp("fast");
      $(".messages_error").slideDown('slow');
    }
        return false}
  
}

function swap_dropdowns(i) {
  
  if  (i == 1 || i == 7) {
    $(".deselect option:selected").removeAttr("selected");
    $(".direction_dropdown").css({"display":"none"});
    $(".slipums_dropdown").css({"display":"block"});
    var options_green = {
       
      5 : "Normal",
      12 : "Upwards right",
      13 : "Downwards right",
      14 : "Upwards left",
      15 : "Downwards left",
			16 : "Upwards straight",
			17 : "Downwards straight"

    };
    var options_land_green = {
      
      11 : "Hole",
      1 : "Green"
          };
    $(".land_place_dropdown").empty();
    $(".direction_swap").empty();
    $.each(options_green, function(val, text) {
     $('.direction_swap').append(
        $('<option></option>').val(val).html(text)
    );
});
     $.each(options_land_green, function(val, text) {
    $('.land_place_dropdown').append( new Option(text,val) );
});
  }
  else {
    $(".deselect option:selected").removeAttr("selected");
    $(".direction_dropdown").css({"display":"block"});
    $(".slipums_dropdown").css({"display":"none"});
    var options_green = {
     5 : "Normal",
     4 : "Fade", 
     3 : "Drow", 
     2 : "Slice",
     1 : "Hook",
		 9 : "Low",
		 10 : "High" 
         };
    var options_land_green = {
     1 : "Green",
     3 : "Fairway",
     4 : "Next fairway",
     6 : "Raf",
     7 : "For green",
     8 : "Fairway sand",
     9 : "Green sand",
     11 : "Hole",
     5 : "Semi raf",
		 10 : "Wood" 
          };
    $(".land_place_dropdown").empty();
    $(".direction_swap").empty();
    $.each(options_green, function(val, text) {
     $('.direction_swap').append(
        $('<option></option>').val(val).html(text)
    );
});
     $.each(options_land_green, function(val, text) {
    $('.land_place_dropdown').append( new Option(text,val) );
});
  }
  }


function switchStartPlaceValues(field_id){
			$.ajax('/games/switch_colors/' + field_id);

}

function swapDirectionValue(sel_val){
	switch (sel_val){
			case '1': res_val = 1; break;
			case '2': res_val = 3; break;
			case '3': res_val = 2; break;
			case '4': res_val = 5; break;
			case '5': res_val = 4; break;
			}
	$('.direction_val_swap').val(res_val);
}

function setDistanceByClub(sel_val){
		$.getJSON('/sticks/' + sel_val + '.json', function(data) {
    if ($('.distance_plan').val().length == 0 ){$('.distance_plan').val(data.stick.distance);}
		if ($('.distance_result').val().length == 0){ $('.distance_result').val(data.stick.distance);}
	  });
}

function swapDistanceColor(color_no, distance_type){
	var header = "." + distance_type + "_distance_header";
	var textfield = "." + distance_type + "_distance";
	if (color_no == 1){ $(header).text("Red");
										 $(header + "," +  textfield).show();}
	if (color_no == 2){ $(header).text('Green'); 
										 $(header + "," + textfield).show();}
	if (color_no == 3){ $(header).text('Black'); 
										 $(header + "," + textfield).show();}
	if (color_no == 4){ $(header).text('Yellow');
										 $(header).show();}
	if (color_no == 0){ $(header + "," +  textfield).hide(); }
		
}

function toggleDistanceColor(distance_type, enable){
	var header = "." + distance_type + "_distance_header";
	var textfield = "." + distance_type + "_distance";
	var dropdown = "." + distance_type + "_dropdown";
	if (enable == true) {
		$(dropdown).attr("disabled", false);
		}
	else {
		$(header).hide();
		$(textfield).hide();
		$(dropdown).attr("disabled", true);
		$(dropdown).val(0);
	}
}

function clearGreenTrajectoryDropdown() {
	$('.green_trajectory').children(':first').attr("selected", "selected");

}

function clearFairwayTrajectoryDropdown() {
	$('.fairway_trajectory').children(':first').attr("selected", "selected");

}		
// function check_game_form() {
//     textEntered = true
//        $(".game_input_select").each(function() {
//         if (textEntered && $(this).val() == "") {
//             textEntered = false;
//         }
//     });
//                 
//     if (textEntered) {
//         return true
//     } else {
//         $(".error").slideDown('slow');
//         return false}
//   
// 
// 
// }

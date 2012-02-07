// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(document).ready(function() {
  bindHitFormPlan();
  bindHitSwitch();
  bindSaveSwitch();
  bindAddSwitch();
  bindRemoveSwitch();
  bindDistanceFields();
  //$("#sticks_row").jScrollPane({hideFocus: true});
//	$("#stats_div").jScrollPane({hideFocus: true});
  bindScrollTriangles();
	bindBagCheckboxes();
  });

function alterClubDropdownValues() {	
	$(".club_id_dropdown").each(function() {
		var i = $(this).val();
		var option_name = '.new_stick_dropdown option[value="' + i + '"]:not(:selected)';
		$(option_name).remove();
	});
	$(".new_stick_dropdown").each(function() {
		var i = $(this).val();
		var option_name = '.new_stick_dropdown option[value="' + i + '"]:not(:selected)';
		$(option_name).remove();
	});
	return true
}

function bindBagCheckboxes() {
	$(".keep_in_bag_checkbox").live('click', function(){
			var z = $(this).attr("checked");
			var i = 0;
			var return_value = 0
			$(".keep_in_bag_checkbox").each(function(){
				var k = $(this).attr("checked");
				if (k == true){ i++;};
			});
			if (i < 14) { return_value = true;}
			else if (i == 14) {
				if (z == true){return_value = false;}
				else {return_value = true;}
			}
			else {return_value = false;}
			if (return_value == true){ return true;}
			else {$(".messages_error").text("You may have only 13 clubs in your bag.");
					$(".messages_error").show();
					return false;}		
	});
}

function bindDistanceFields() {
	$(".distance_result").keyup( function(){
		var diff = $(".distance_result").val() - $(".distance_plan").val();
		if (diff > 0 ) {diff = 3;}
		if (diff == 0 ) {diff = 2;}
		if (diff < 0) {diff = 1;}
		$(".mistake").val(diff);
		});
	$(".distance_plan").keyup( function(){
		var diff = $(".distance_result").val() - $(".distance_plan").val();
		if (diff > 0 ) {diff = 3;}
		if (diff == 0 ) {diff = 2;}
		if (diff < 0) {diff = 1;}
		$(".mistake").val(diff);
		});
}

function bindScrollTriangles() {
	$("#triangle_left").live('click', function(){
		var diff = $("#stats_div_inner").css("left");
		diff = parseInt(diff.substr(0, diff.length - 2)) + 111 + "px";
		if (diff != "111px"){
			$("#stats_div_inner").css("left", diff);
			var api1 = $("#sticks_row").data('jsp');
			api1.scrollByX(-111);
			$("#triangle_right").css("visibility", "visible");
		}	else { $("#triangle_left").css("visibility", "hidden");}	
		return false;
		});
	$("#triangle_right").live('click', function(){
		var total_length = "-" + (parseInt($("#length_stats_div").css("width")) - 666 ) + "px";
		var diff = $("#stats_div_inner").css("left");
		diff = parseInt(diff.substr(0, diff.length - 2)) - 111 + "px";
		if (parseInt(diff) > parseInt(total_length)){
			$("#stats_div_inner").css("left", diff);
			var api1 = $("#sticks_row").data('jsp');
			api1.scrollByX(111);
			$("#triangle_left").css("visibility", "visible");
		}	else { $("#triangle_right").css("visibility", "hidden");}			
		return false;
		});
}

function bindAddSwitch(){
	$("#add_hit").live('click', function() {
			$('#formid').val("add_hit");
			$('#hit_form').submit();
			});
}

function bindRemoveSwitch(){
	$("#remove_hit").live('click', function() {
			$('#formid').val("remove_hit");
			$('#hit_form').submit();
			});
}

function bindHitFormPlan() {

  $('.hole_switch').live('click', function() {
    textEntered = true
    //$(".game_input_select").each(function() {
    //    if (textEntered && $(this).val() == "") {
    //        textEntered = false;
     //   }
    //});
                
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
   // $(".game_input_select").each(function() {
    //    if (textEntered && $(this).val() == "") {
     //       textEntered = false;
      //  }
    //});
                
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
    // $(".game_input_select").each(function() {
      //  if (textEntered && $(this).val() == "") {
            //textEntered = false;
       // }
   // });
                
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

function closeExpandedAnnouncement(article_id) {
	var exp_div = "#announcement_" + article_id + " .expanded";
	var small_div = "#announcement_" + article_id + " .small_article";
	$(exp_div).empty();
	$(small_div).show();	
}


function maxlen(class_name, field_class) {
	var fieldname = "." + field_class;
	$(fieldname).live('keyup', function(e) {
				var status_div = "." + class_name;
        var maxCharacters = $(fieldname).attr('maxlen');
        charactersLength = $(fieldname).val().length;
   			if (charactersLength > maxCharacters) {
				var new_val = $(fieldname).val().slice(0, maxCharacters);
				$(fieldname).val(new_val);
				}
				var chars_left = maxCharacters - charactersLength;
				if (chars_left < 0 ){chars_left = 0;}
		$(status_div).text("You have " + chars_left + " characters left");		
  });

}

function maxlen_without_deleting(class_name, field_class) {
	var fieldname = "." + field_class;
	$(fieldname).live('keyup', function(e) {
				var status_div = "." + class_name;
        var maxCharacters = $(fieldname).attr('maxlen');
        charactersLength = $(fieldname).val().length;		
				var chars_left = maxCharacters - charactersLength;
				if (chars_left < 0 ){chars_left = 0;}
		$(status_div).text("You have " + chars_left + " characters left for the heading part.");		
  });
}

function showHideHitSwitch(sel_val){
	if (sel_val == 11) { $(".next_stroke_switch").hide();}
	else {$(".next_stroke_switch").show();}
}

function check_link(class_name, field_class) {
		var fieldname = "." + field_class;
		$(fieldname).live('keyup', function(e) {
				var status_div = "." + class_name;
        var link = $(fieldname).val();
				if ( link.substring(0, 7) != "http://"){
		$(status_div).text("You have to enter link that starts with http://");}
				else {$(status_div).text("");}		
  });
}

function switchHit(rel_value, game_id){
	$("#nexthit").val(rel_value);
	$("#hit_form").submit();
}

function swapActiveStick(stick_id) {
	$(".single_club_wrap").each(function(){
		$(this).removeClass("club_active");
	});
	$("#stick_box_" + stick_id).addClass("club_active");
}







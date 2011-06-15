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
      $('.error').hide();
        $('form').submit(); 
      }
       else {
        $(".error").slideDown('slow');
        return false}
  
}

function swap_dropdowns(i) {
  
  if  (i == 1 || i == 7) {
    $(".direction_dropdown").css({"display":"none"});
    $(".slipums_dropdown").css({"display":"block"});
  }
  else {
    $(".direction_dropdown").css({"display":"block"});
    $(".slipums_dropdown").css({"display":"none"});
  }
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

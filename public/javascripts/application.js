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
     $('#nexthole').val($(this).attr('rel'));
    $('.single_hole').replaceWith('<img src="/images/ajax-loader-small.gif" style="position:relative; top:18px; margin-left:7px;" />');
    $('#hit_form').submit(); 
    return false;
    }
    else {
        $(".error").slideDown('slow');
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
     $('#nexthit').val($(this).attr('rel')); 
    $('.gif_placeholder').empty();
    $('.gif_placeholder').append('<img src="/images/ajax-loader.gif" />');
    $('#hit_form').submit(); 
    return false;
   
    }
    else {
        $(".error").slideDown('slow');
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
     $('#nexthit').val($(this).attr('rel')); 
    $('#hit_form').submit(); 
    return false;
    }
    else {
        $(".error").slideDown('slow');
        return false}
  });
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

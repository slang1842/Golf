/**
 * jQuery Maxlength plugin
 * @version   $Id: jquery.maxlength.js 18 2009-05-16 15:37:08Z emil@anon-design.se $
 * @package   jQuery maxlength 1.0.5
 * @copyright Copyright (C) 2009 Emil Stjerneman / http://www.anon-design.se
 * @license   GNU/GPL, see LICENSE.txt
 */

(function($) 
{

  $.fn.live_maxlen = function(options)
  {
    var settings = jQuery.extend(
    {
      maxCharacters:      10, // Characters limit
      status:             true, // True to show status indicator bewlow the element
      prefix:             "You have",
      postfix:            "symbols left",
      statusClass:        "status", // The class on the status div
      statusElement:      ".chars_left",
      notificationClass:  "notification", // Will be added to the emement when maxlength is reached
      slider:             false // Use counter slider
    }, options );
    
    // Add the default event
      $(this).live('keyup', function(e) {
        var item = $(this);
        var maxCharacters = $(this).attr('maxlen');
        var place = $(this).attr('comment');
        charactersLength = item.val().length;
        
				$.fn.live_maxlen.checkChars(settings, charactersLength, maxCharacters, item);
       
        if (maxCharacters > 0) {
          
          var charactersLength = $(this).val().length;

          // Validate
          if(!$.fn.live_maxlen.validateElement(item)) 
          {
            return false;
          }
          
          // Loop through the events and bind them to the element
   
    
          // Insert the status div
          if(settings.status) 
          {
            //item.after($("<div/>").addClass(settings.statusClass).html('-'));
            $.fn.live_maxlen.updateStatus(settings, charactersLength, maxCharacters, item);
          }
   
          // Remove the status div
          if(!settings.status) 
          {
            var removeThisDiv = item.next("div."+settings.statusClass);
          
            if(removeThisDiv) {
              removeThisDiv.remove();
            }
          }
          // Slide counter
          if(settings.slider) {
            item.next().hide();
            
            item.focus(function(){
              item.next().slideDown('fast');
            });
    
            item.blur(function(){
              item.next().slideUp('fast');
            }); 
          }
        }
      });
  };


	$.fn.live_maxlen.checkChars = function(settings, charactersLength, maxCharacters, item) 
  {
    var valid = true;
    
    // Too many chars?
    if(charactersLength >= maxCharacters) 
    {
      // Too may chars, set the valid boolean to false
      valid = false;
      // Add the notifycation class when we have too many chars
      item.addClass(settings.notificationClass);
      // Cut down the string
      item.val(item.val().substr(0,maxCharacters));
    } 
    else 
    {
      // Remove the notification class
      if(item.hasClass(settings.notificationClass)) 
      {
        item.removeClass(settings.notificationClass);
      }
    }

    if(settings.status)
    {
      $.fn.live_maxlen.updateStatus(settings, charactersLength, maxCharacters, item);
    }
  }
	
	$.fn.live_maxlen.updateStatus = function(settings, charactersLength, maxCharacters, item)
	{
		var place = item.attr('comment');
		var charactersLeft = maxCharacters - charactersLength;

		if(charactersLeft < 0) 
		{
			charactersLeft = 0;
		}

		if ( place == "yes"){		
			 item.parent().parent().parent().find(settings.statusElement).html('<p>' + settings.prefix + ' ' + charactersLeft + ' ' + settings.postfix + '</p>');
		} else {
			item.prev().find(settings.statusElement).html('<p>' + settings.prefix + ' ' + charactersLeft + ' ' + settings.postfix + '</p>');
		}
			
		if ( place == "request"){
			item.parent().find(settings.statusElement).html('<p>' + settings.prefix + ' ' + charactersLeft + ' ' + settings.postfix + '</p>');
		}
	}

  // Check if the element is valid.
  $.fn.live_maxlen.validateElement = function(item) 
  {
    var ret = false;
    
    if(item.is('textarea')) {
      ret = true;
    } else if(item.filter("input[type=text]")) {
      ret = true;
    } else if(item.filter("input[type=password]")) {
      ret = true;
    }

    return ret;
  }






})(jQuery);

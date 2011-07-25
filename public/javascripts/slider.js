$(document).ready(function() {
$('#carousel_ul li:first').before($('#carousel_ul li:last'));
$('#slider_wrap').bind('mouseover',function(e){
var position = e.pageX - this.offsetLeft;
var width = 980;
if (position <= 21){
var inetrval = 2 * position + 100;
var speed = 3 * position + 150;
hover('left', 300, 500)
} else if(position >= 969) {
hover('right', 300, 500)
}
});
});
function hover(where, interval, speed) {
timer = setInterval('slide("' + where + '", ' + speed + ')', interval);
$(this).mouseleave(function(){
clearInterval(timer);
//$(this).stop();
});
}
function slide(where, speed){
var item_width = $('#carousel_ul li').outerWidth();
if(where == 'left'){
var left_indent = parseInt($('#carousel_ul').css('left')) + item_width;
}else{
var left_indent = parseInt($('#carousel_ul').css('left')) - item_width;
}
$('#carousel_ul:not(:animated)').animate({'left' : left_indent}, speed ,function(){
if(where == 'left'){
$('#carousel_ul li:first').before($('#carousel_ul li:last'));
}else{
$('#carousel_ul li:last').after($('#carousel_ul li:first'));
}
$('#carousel_ul').css({'left' : '-85px'});
});
}

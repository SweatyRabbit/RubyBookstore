var showChar = 250;
var ellipsesText = "...";
var moreText = "Read more";
var lessText = "Read less";

$('#minus').click(function(e){
  var currentValue = $('.input-count-book').val();
  if (currentValue >= 2) {
    var newValue = Number(currentValue) - 1;
    $('.input-count-book').val(newValue);
  }
});

$('#plus').click(function(e){
  var currentValue = $('.input-count-book').val();
  if (currentValue < 10) {
    var newValue = Number(currentValue) + 1;
    $('.input-count-book').val(newValue);
  }
});

$('.textControl').each(function() {
  var content = $(this).html();
  if(content.length > showChar) {
    var c = content.substr(0, showChar);
    var h = content.substr(showChar, content.length - showChar);
    var html = c + '<span class="moreellipses">' + ellipsesText+ '&nbsp;</span><span class="morecontent"><span>' + h + '</span>&nbsp;&nbsp;<a href="" class="morelink">' + lessText + '</a></span>';
    $(this).html(html);
  }
});

$(".morelink").click(function(){
  if($(this).hasClass("less")) {
    $(this).removeClass("less");
    $(this).html(lessText);
  } else {
    $(this).addClass("less");
    $(this).html(moreText);
  }
  $(this).parent().prev().toggle();
  $(this).prev().toggle();
  return false;
});

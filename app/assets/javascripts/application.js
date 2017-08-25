//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require_tree .

if($('#records-list').length > 0) {
  $('#searchbar input').css('border-bottom', '0px solid');
  $(window).scroll(function(event) {
    if($(window).scrollTop() > 5) {
      $('#searchbar input').css('border-bottom', '3px solid');
    } else {
      $('#searchbar input').css('border-bottom', '0px solid');
    }
  });
}
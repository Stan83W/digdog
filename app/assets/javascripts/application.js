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

$('#searchbar').find('input').on('input', function (e) {
  $(e.currentTarget).attr('data-empty', !e.currentTarget.value);
});
$('#searchbar').find('input').each(function(index, el) {
  $(el).trigger('input');
});

$("[data-target='toggle-list']").click(function(event) {
  $('body').toggleClass('diglist');
});
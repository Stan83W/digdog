//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require plyr
//= require_tree .
var players;

function loadContent(url, target) {
    target.load(url + " #page-content .inner", function(response, status, xhr) {
        if (status == "success") {
            $('body').addClass('page-content').removeClass('loading');
            history.pushState(null, "Digdog", url);
            // plyr.setup();
        }
    });
}
$(document).ready(function() {
    if ($('#records-list').length > 0) {
        $('#searchbar input').css('border-bottom', '0px solid');
        $(window).scroll(function(event) {
            if ($(window).scrollTop() > 5) {
                $('#searchbar input').css('border-bottom', '3px solid');
            } else  {
                $('#searchbar input').css('border-bottom', '0px solid');
            }
        });
    }
    $('#searchbar').find('input').on('input', function(e) {
        $(e.currentTarget).attr('data-empty', !e.currentTarget.value);
    });
    $('#searchbar').find('input').each(function(index, el) {
        $(el).trigger('input');
    });
    $("[data-target='toggle-list']").click(function(event) {
        $('body').toggleClass('diglist');
    });
    $('body').on('click', '[data-video-id]:not(.opened)', function(event) {
        event.preventDefault();
        $(this).addClass('opened').after('<div class="c12 mb1"><div class="plyr c8"><div data-video-id="'+$(this).data("video-id")+'" data-type="youtube"></div></div></div>');
        players = plyr.setup({
            controls: ['play', 'progress', 'current-time', 'mute']
        });
    });
    $('body').on('click', "[data-target='close-panel']", function(event) {
        event.preventDefault();
        $('body').removeClass('page-content');
        if ($('.plyr--playing').length > 0) {
            for (var i = players.length - 1; i >= 0; i--) {
                if (!players[i].isPaused()) {
                    players[i].pause();
                }
            }
        }
        setTimeout(function() {
            $('#page-content').empty();
        }, 900);
    });
    $('body').on('click', "a[data-recordtarget]", function(event) {
        event.preventDefault();
        $('body').addClass('loading');
        loadContent($(this).attr('href'), $('#page-content'));
    });
    // plyr.setup(); 
});
// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

function TweetPick() {
  var modal_backdrop = $('.modal-backdrop');
  if (document.getElementById('tweet_tweet_text_tweet_1').checked) {
      var word = document.getElementById('tweet_tweet_text_tweet_1').value;
      document.getElementById('tweet_option').value = word;
    modal_backdrop.fadeIn(300);
  }
  else if
  (document.getElementById('tweet_tweet_text_tweet_2').checked) {
    var word = document.getElementById('tweet_tweet_text_tweet_2').value;
    document.getElementById('tweet_option').value = word;
    modal_backdrop.fadeIn(300);
  }
  else if
  (document.getElementById('tweet_tweet_text_tweet_3').checked) {
    var word = document.getElementById('tweet_tweet_text_tweet_3').value;
    document.getElementById('tweet_option').value = word;
    modal_backdrop.fadeIn(300);
  }
  else if
  (document.getElementById('tweet_tweet_text_tweet_4').checked) {
    var word = document.getElementById('tweet_tweet_text_tweet_4').value;
    document.getElementById('tweet_option').value = word;
    modal_backdrop.fadeIn(300);
  }
  else if
  (document.getElementById('tweet_tweet_text_tweet_5').checked) {
    var word = document.getElementById('tweet_tweet_text_tweet_5').value;
    document.getElementById('tweet_option').value = word;
    modal_backdrop.fadeIn(300);
  }
  else document.getElementById('tweet_option').value = '';
}

var main = function() {
  var modal_backdrop = $('.modal-backdrop');
  // hide the modal unless we shouldn't
  modal_backdrop.hide();
  if (modal_backdrop.hasClass('nohide')) {
    modal_backdrop.fadeIn(300);
  }
  // allow users to click out of it
  else {
    var cancel_button = $('.modal-button-cancel');
    cancel_button.click(function(event) {
      modal_backdrop.fadeOut(300);
      event.preventDefault();
    });
  }
}

$(document).ready(main);

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
//= require turbolinks
//= require_tree .


function TweetPick() {
            if (document.getElementById('tweet_tweet_text_tweet_1').checked) {
                var word = document.getElementById('tweet_tweet_text_tweet_1').value;
                document.getElementById('tweet_option').value = word;

                // window.location.replace("/reps/:id/posts/new");
            }
            else if
            (document.getElementById('tweet_tweet_text_tweet_2').checked) {
              var word = document.getElementById('tweet_tweet_text_tweet_2').value;
              document.getElementById('tweet_option').value = word;
            }
            else if
            (document.getElementById('tweet_tweet_text_tweet_3').checked) {
              var word = document.getElementById('tweet_tweet_text_tweet_3').value;
              document.getElementById('tweet_option').value = word;
            }
            else if
            (document.getElementById('tweet_tweet_text_tweet_4').checked) {
              var word = document.getElementById('tweet_tweet_text_tweet_4').value;
              document.getElementById('tweet_option').value = word;
            }
            else if
            (document.getElementById('tweet_tweet_text_tweet_5').checked) {
              var word = document.getElementById('tweet_tweet_text_tweet_5').value;
              document.getElementById('tweet_option').value = word;
            }
            else document.getElementById('tweet_option').value = '';
        }

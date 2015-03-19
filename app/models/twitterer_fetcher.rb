class TwittererFetcher
  attr_accessor :twitterer

def initialize(user)
  @twitterer = Twitter::REST::Client.new do |config|
    config.consumer_key = ENV['TWITTER_API_KEY']
    config.consumer_secret = ENV['TWITTER_API_SECRET']
    config.access_token = user.user_token
    config.access_token_secret = user.user_token_secret
  end
end

  def send_tweet(tweet)
    @twitterer.update(tweet.tweet_text)
  end

end

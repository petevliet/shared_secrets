class TweetsController < ApplicationController

  def create
    @user_tweeter = TwittererFetcher.new(current_user)
    @tweet = Tweet.new(params.require(:tweet).permit(:tweet_text, :user_id))
    if @tweet.save
      @user_tweeter.send_tweet(@tweet)
      redirect_to reps_path, notice: "Your tweet has been tweeted."
    else
      redirect_to reps_path
    end
  end

end

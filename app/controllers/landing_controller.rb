class LandingController < ApplicationController

  def dashboard
    @user = User.find_by(twitter_id: session[:user_id])
    if current_user.nil?
      render :visitors
    else
      render :dashboard
  end
end

end

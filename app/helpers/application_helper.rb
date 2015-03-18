module ApplicationHelper

  def current_user
        if session[:user_id]
          @current_user = @current_user || User.find_by(twitter_id: session[:user_id])
        end
    end

end

class LandingController < ApplicationController

  def visitors
    if logged_in?
      redirect_to reps_path
    end
  end

end

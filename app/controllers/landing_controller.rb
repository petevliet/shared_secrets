class LandingController < ApplicationController
  before_action :user_set_state, only: []

  def visitors
    if logged_in?
      redirect_to reps_path
    end
  end

  def set_state
  end

end

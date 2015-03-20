class LandingController < ApplicationController
  before_action :user_set_state, only: []

  def visitors
    if logged_in?
      if current_user.state
        redirect_to reps_path
      else
        @show_modal = true
      end
    end
  end

  def set_state
    # TODO: error checking
    current_user.update(state: params[:state])
    redirect_to reps_path;
  end

end

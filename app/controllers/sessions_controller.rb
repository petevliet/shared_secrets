class SessionsController < ApplicationController

def new
end

def create
  session[:user_token] = env['omniauth.auth']['credentials']['token']
  session[:user_secret] = env['omniauth.auth']['credentials']['secret']
  uid = env['omniauth.auth']['uid']
  session[:user_id] = uid
  user = User.find_or_create_by(twitter_id: uid)

  user.update_attributes(name: env['omniauth.auth']['info']['name'],
                          email: env['omniauth.auth']['info']['email'])

  redirect_to reps_path, notice: "You're logged in!"
end


def destroy
  session[:user_id] = nil
  session[:user_token] = nil
  session[:user_secret] = nil
  redirect_to visitors_path, notice: "Logged out."
end

end
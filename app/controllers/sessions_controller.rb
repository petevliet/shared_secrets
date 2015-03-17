class SessionsController < ApplicationController

def new
end

def create
  user_token = env['omniauth.auth']['credentials']['token']
  session[:user_token] = user_token
  user_secret = env['omniauth.auth']['credentials']['secret']
  session[:user_secret] = user_secret
  uid = env['omniauth.auth']['uid']
  session[:user_id] = uid
  user = User.find_or_create_by(twitter_id: uid)

  user.update_attributes(name: env['omniauth.auth']['info']['name'],
                          email: env['omniauth.auth']['info']['email'])

  redirect_to root_path, notice: "You're logged in!"
end

def destroy
  session[:user_id] = nil
  redirect_to root_path, notice: "Logged out."
end

end

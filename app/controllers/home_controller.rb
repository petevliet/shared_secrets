class HomeController < ApplicationController

def index
  @df = DataFetcher.new
  @reps = []

  if params[:state]
    @rep_info_results = @df.rep_info(params[:state])
    @rep_info_results["response"]["legislator"].each_with_index do |rep, index|
      @reps << @rep_info_results["response"]["legislator"][index]["@attributes"]["firstlast"]
    end
  end

  @user = User.find_by(twitter_id: session[:user_id])

end

end

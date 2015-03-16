class HomeController < ApplicationController

def index
  @df = DataFetcher.new
  @reps = []
  if params[:state]
    @rep_info_results = @df.rep_info(params[:state])
    # @name = @rep_info_results["response"]["legislator"][0]["@attributes"]["firstlast"]
    @rep_info_results["response"]["legislator"].each_with_index do |rep, index|
      @reps << @rep_info_results["response"]["legislator"][index]["@attributes"]["firstlast"]
    end
    @rep_info_results.map {|rep| "rep"}
  end
end

end

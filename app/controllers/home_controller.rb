class HomeController < ApplicationController

def index
  @df = DataFetcher.new
  @rep_info_results = @df.rep_info
  @name = @rep_info_results["response"]["legislator"][0]["@attributes"]["firstlast"]
end

end

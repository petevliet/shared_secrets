class DataFetcher

  def initialize
    @rep_search = Faraday.new(:url => 'http://www.opensecrets.org') do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
  end

 def state_info(state)
   response = @rep_search.get do |req|
     req.url "/api/"
     req.params['method'] = "getLegislators"
     req.params['id'] = state
     req.params['apikey'] = ENV["API_KEY"]
     req.params['output'] = 'json'
   end
   JSON.parse(response.body)
 end
  
 def rep_info(cid)
   response = @rep_search.get do |req|
     req.url "/api/"
     req.params['method'] = "candSummary"
     req.params['cid'] = cid
     req.params['apikey'] = ENV["API_KEY"]
     req.params['output'] = 'json'
   end
   JSON.parse(response.body)
 end


end

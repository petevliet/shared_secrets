class DataFetcher

  def initialize
   @rep_search = Faraday.new(:url => 'http://www.opensecrets.org') do |faraday|
     faraday.request  :url_encoded             # form-encode POST params
     faraday.response :logger                  # log requests to STDOUT
     faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
     end
   end

 def rep_info
   response = @rep_search.get do |req|
     req.url "/api/"
     req.params['method'] = "getLegislators"
     req.params['id'] = "NJ"
     req.params['apikey'] = ENV["API_KEY"]
     req.params['output'] = 'json'
   end
   JSON.parse(response.body)
 end


end

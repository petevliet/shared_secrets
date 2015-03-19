class DataFetcher

  def initialize
    @rep_search = Faraday.new(:url => 'http://www.opensecrets.org') do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
  end

 def state_info(state)
   Rails.cache.fetch("DataFetcher#state_info(#{state})", expires_in: 12.hours) do
     response = @rep_search.get do |req|
       req.url "/api/"
       req.params['method'] = "getLegislators"
       req.params['id'] = state
       req.params['apikey'] = ENV["API_KEY"]
       req.params['output'] = 'json'
     end
     JSON.parse(response.body)
   end
 end
  
 def rep_info(cid)
   Rails.cache.fetch("DataFetcher#rep_info(#{cid})", expires_in: 12.hours) do
     response = @rep_search.get do |req|
       req.url "/api/"
       req.params['method'] = "candSummary"
       req.params['cid'] = cid
       req.params['apikey'] = ENV["API_KEY"]
       req.params['output'] = 'json'
       req.params['cycle'] = '2014'
     end
     JSON.parse(response.body)
   end
 end

 def contrib_info(cid)
   Rails.cache.fetch("DataFetcher#contrib_info(#{cid})", expires_in: 12.hours) do
     response = @rep_search.get do |req|
       req.url "/api/"
       req.params['method'] = "candContrib"
       req.params['cid'] = cid
       req.params['apikey'] = ENV["API_KEY"]
       req.params['output'] = 'json'
       req.params['cycle'] = '2014'
     end
     JSON.parse(response.body)
   end
 end

 def industry_info(cid)
   Rails.cache.fetch("DataFetcher#industry_info(#{cid})", expires_in: 12.hours) do
     response = @rep_search.get do |req|
       req.url "/api/"
       req.params['method'] = "candIndustry"
       req.params['cid'] = cid
       req.params['apikey'] = ENV["API_KEY"]
       req.params['output'] = 'json'
       req.params['cycle'] = '2014'
     end
     JSON.parse(response.body)
   end
 end

end

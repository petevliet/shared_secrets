class RepsController < ApplicationController

  def index
    @states = ["AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY"]

    df = DataFetcher.new
    @reps = {}

    if params[:state]
      state_info_results = df.state_info(params[:state])
      state_info_results["response"]["legislator"].each_with_index do |rep, index|
        @reps[state_info_results["response"]["legislator"][index]["@attributes"]["cid"]] = state_info_results["response"]["legislator"][index]["@attributes"]["firstlast"]
      end
    end
  end

  def show
    df = DataFetcher.new

    rep_info_results = df.rep_info(params[:cid])
    @name = rep_info_results["response"]["summary"]["@attributes"]["cand_name"].split(', ').reverse.join(' ')

    case rep_info_results["response"]["summary"]["@attributes"]["party"]
    when "D"
      @party = "Democrat"
    when "R"
      @party = "Republican"
    when "L"
      @party = "Libertarian"
    when "3"
      @party = "3rd Party"
    else
      @party = "Unknown"
    end

    case rep_info_results["response"]["summary"]["@attributes"]["chamber"]
    when "H"
      @chamber = "House"
    when "S"
      @chamber = "Senate"
    else
      @chamber = "Unknown"
    end

    @state = rep_info_results["response"]["summary"]["@attributes"]["state"]

    @first_elected = rep_info_results["response"]["summary"]["@attributes"]["first_elected"]

    @total = rep_info_results["response"]["summary"]["@attributes"]["total"].split('.').tap{|ds, _| ds.replace ds.reverse.scan(/\d{1,3}/).join(',').reverse}.join('.')

    @spent = rep_info_results["response"]["summary"]["@attributes"]["spent"].split('.').tap{|ds, _| ds.replace ds.reverse.scan(/\d{1,3}/).join(',').reverse}.join('.')

    @cash_on_hand = rep_info_results["response"]["summary"]["@attributes"]["cash_on_hand"].split('.').tap{|ds, _| ds.replace ds.reverse.scan(/\d{1,3}/).join(',').reverse}.join('.')

    @last_updated = rep_info_results["response"]["summary"]["@attributes"]["last_updated"]

    state_info_results = df.state_info(@state)["response"]["legislator"]
    state_info_results.each_with_index do |rep, index|
      if state_info_results[index]["@attributes"]["cid"] == params[:cid]
        @twitter_url = "https://twitter.com/" + state_info_results[index]["@attributes"]["twitter_id"]
        @youtube_url = state_info_results[index]["@attributes"]["youtube_url"]
        @facebook_url = "https://facebook.com/" + state_info_results[index]["@attributes"]["facebook_id"]
      end
    end
  end

end

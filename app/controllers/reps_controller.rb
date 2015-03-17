class RepsController < ApplicationController

  def index
    @states = ["AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY"]

    df = DataFetcher.new
    @reps = {}

    if params[:state]
      state_info_results = df.state_info(params[:state])
      state_info_results["response"]["legislator"].each do |rep|
        @reps[rep["@attributes"]["cid"]] = rep["@attributes"]["firstlast"]
      end
    end
  end

  def show
    df = DataFetcher.new

    rep_info_results = df.rep_info(params[:cid])
    summary = rep_info_results["response"]["summary"]["@attributes"] 
    @name = summary["cand_name"].split(', ').reverse.join(' ')

    case summary["party"]
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

    case summary["chamber"]
    when "H"
      @chamber = "House"
    when "S"
      @chamber = "Senate"
    else
      @chamber = "Unknown"
    end

    @state = summary["state"]

    @first_elected = summary["first_elected"]

    @total = add_commas(summary["total"])

    @spent = add_commas(summary["spent"])

    @cash_on_hand = add_commas(summary["cash_on_hand"])

    @last_updated = summary["last_updated"]

    state_info_results = df.state_info(@state)["response"]["legislator"]
    state_info_results.each do |rep|
      if rep["@attributes"]["cid"] == params[:cid]
        @twitter_url = "https://twitter.com/" + rep["@attributes"]["twitter_id"]
        @youtube_url = rep["@attributes"]["youtube_url"]
        @facebook_url = "https://facebook.com/" + rep["@attributes"]["facebook_id"]
      end
    end

    # query the server
    contrib_info_results = df.contrib_info(params[:cid])\
      ["response"]["contributors"]["contributor"]
    # pull out the attributes of each contributor
    unsorted_contributors = contrib_info_results.map do |contributor|
      contributor['@attributes']
    end
    # sort and take the top 5
    @contributors = unsorted_contributors.sort_by do |contributor|
      contributor["total"].to_i
    end.reverse.take(5)
    # add commas to the monetary values
    @contributors.each do |contributor|
      %w[total pacs indivs].each do |key|
        contributor[key].replace add_commas(contributor[key])
      end
    end
  end

  private
  def add_commas(str)
    str.split('.').tap do |ds, _| 
      ds.replace ds.reverse.scan(/\d{1,3}/).join(',').reverse
    end.join('.')
  end

end

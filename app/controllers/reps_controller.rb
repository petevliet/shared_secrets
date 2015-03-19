class RepsController < ApplicationController

  before_action :authorize

  def index
    @states = ["AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY"]

    df = DataFetcher.new
    @reps = {}
    @sens = {}

    if params[:state]
      state_info_results = df.state_info(params[:state])
      state_info_results["response"]["legislator"].each do |rep|
        if rep["@attributes"]["office"][-2] != "S"
          @reps[rep["@attributes"]["cid"]] = [rep["@attributes"]["firstlast"], rep["@attributes"]["party"]]
        elsif rep["@attributes"]["office"][-2] == "S"
          @sens[rep["@attributes"]["cid"]] = [rep["@attributes"]["firstlast"], rep["@attributes"]["party"]]
        end
      end
    end
  end

  def show
    @posts = Post.where(cid:(params[:cid]))
    df = DataFetcher.new

    rep_info_results = df.rep_info(params[:cid])

    @rep_cid = rep_info_results["response"]["summary"]["@attributes"]["cid"]
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
      @chamber = "House of Representatives"
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
        @twitter_handle = rep["@attributes"]["twitter_id"]
        @twitter_url = "https://twitter.com/" + rep["@attributes"]["twitter_id"]
        @youtube_url = rep["@attributes"]["youtube_url"]
        @facebook_url = "https://facebook.com/" + rep["@attributes"]["facebook_id"]
      end
    end

    # query the server
    contrib_info_results = df.contrib_info(params[:cid])\
      ["response"]["contributors"]["contributor"]
    @contributors = top_five(contrib_info_results)
    industry_info_results = df.industry_info(params[:cid])\
      ["response"]["industries"]["industry"]
    @industries = top_five(industry_info_results)

    @tweet = Tweet.new

  #  if @twitter_handle != ""
      @tweet_1 = "Hey " + "@demullane" + " it's great that you've raked in $" + @total + " since " + @first_elected + "!"
  #   else
  #     @tweet_1 = "Hey " + @name +
  #   end
  #   @tweet_2 =
  #   @tweet_3 =
  end

  private
  def add_commas(str)
    str.split('.').tap do |ds, _|
      ds.replace ds.reverse.scan(/\d{1,3}/).join(',').reverse
    end.join('.')
  end

  def top_five(donors)
    # pull out the attributes of each donor
    unsorted_donors = donors.map do |donor|
      donor['@attributes']
    end
    # sort and take the top 5
    @donors = unsorted_donors.sort_by do |donor|
      donor["total"].to_i
    end.reverse.take(5)
    # add commas to the monetary values
    @donors.each do |donor|
      %w[total pacs indivs].each do |key|
        donor[key].replace add_commas(donor[key])
      end
    end
  end

  def authorize
    if !logged_in?
      redirect_to '/visitors', notice: "Please log in for full access."
    end
  end

end

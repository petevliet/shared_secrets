class RepsController < ApplicationController

  before_action :authorize

  def index
    df = DataFetcher.new
    @reps = {}
    @sens = {}
    state = (params[:state] or current_user.state)
    @state_name = states_by_abbrev[state]

    if state
      state_info_results = df.state_info(state)
      state_info_results["response"]["legislator"].each do |rep|
        # find the name
        cid = rep["@attributes"]["cid"]
        if rep["@attributes"]["office"][-2] != "S"
          hash_to_use = @reps
        else
          hash_to_use = @sens
        end
        hash_to_use[cid] = {name: rep["@attributes"]["firstlast"]}
        # find the class to use for the overlay image
        hash_to_use[cid][:img_class] = 'rep-img-' +
          case rep["@attributes"]["party"]
          when 'D'; 'dem'
          when 'R'; 'gop'
          else    ; 'oth'
          end
      end
      @reps = @reps.sort_by {|_, rep| rep[:name].split.last.downcase}
      @sens = @sens.sort_by {|_, sen| sen[:name].split.last.downcase}
    end
  end

  def show
    @posts = Post.where(cid:(params[:cid]))
    @new_post = Post.new
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


    #TWEETING STUFF
    @tweet = Tweet.new

    @tweets = [
      "Hey " + "@demullane" + " it's great that you raked in $" + @total + " during the last election cycle!",
      "Hey " + "@demullane" + ", you spent $" + @spent + " during the last election cycle. But did the people of " + @state + " benefit?",
      "Hey " + "@demullane" + ", nice to know you're sitting on $" + @cash_on_hand + " from the last election cycle... ",
      "@demullane" + " raked in " + "#{@contributors.first["total"]}" + " from " + "#{@contributors.first["org_name"]} just in the last election cycle!",
      "@demullane" + " raked in " + "#{@industries.first["total"]}" + " from " + "#{@industries.first["industry_name"]} just in the last election cycle!"
    ]

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

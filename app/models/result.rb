class Result < ActiveRecord::Base

require 'indico'

# model vars
Indico.api_key = "dd5e35044234093be537186e304d0531"

  def self.get_tweets(term = "banks")
    Result.delete_all

    client = Twitter::REST::Client.new do |config|
      config.consumer_key    = "vYjNKR8TyCYEfJpDM1Dro4aiM"
      config.consumer_secret = "CJhHRTELfXXr2Ud2nGcc3hPeQTiUx6dfQ0CAEGO6LGRRoHQdmf"
    end

    tweet_array = []

    client.search(term, geocode: "43.6521,79.3832,1000mi").each do |tweet|

      puts check_for_keywords(tweet.text)
      puts filter_emotions(tweet.text)

      if check_for_keywords(tweet.text) && filter_emotions(tweet.text)
        tweet_array << {message: tweet.text, date: tweet.created_at, username: tweet.user.name}
      end
    end

    puts tweet_array
    save_relevent_messages(tweet_array)
  end

  def self.check_for_keywords(string)
    # get result from indico

    begin
      result = Indico.keywords(string, {version: 2})
    rescue
      puts "could not parse that (keywords)"
    else
      puts 'end'
      puts result

      # get keywords
      keywords = ["banks", "finance"]

      # return true if the keyword exists, else return false
      result.each do |key, value|
        if keywords.include?(key)
          return true
        end
      end
      return false
    end
  end

  def self.check_for_politics(string)
    # get result from indico
    begin
      result = Indico.political(string)
    rescue
      puts "could not parse that (politics)"
    else
      if result["liberal"]
        return true
      end
      return false
    end
  end

  def self.filter_emotions(string)
    begin
      result = Indico.emotion(string, {top_n: 3});
    rescue
      puts "could not parse that (emotions)"
    else
      if result["anger"]
        return true
      else
        return false
      end
    end
  end


  def self.save_relevent_messages(messages)
    messages.each do |x|
        Result.create(message: x[:message], date: x[:date], username: x[:username])
        puts 'stored'
    end
  end


end

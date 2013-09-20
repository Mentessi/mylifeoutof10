require 'sinatra'
require 'twitter'
# require "sinatra/reloader"

get '/' do 
  erb "index.html".to_sym
end


Twitter.configure do |config|
  config.consumer_key = ENV['LIFETEN_KEY']
  config.consumer_secret = ENV['LIFETEN_SECRET']
  config.oauth_token = ENV['LIFETEN_OAUTH_TOKEN']
  config.oauth_token_secret = ENV['LIFETEN_OAUTH_TOKEN_SECRET']
end


get '/tweets' do 
  request.xhr?
  @average = Tweets.new.average
  erb "tweet_score.html".to_sym
end


# https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=mylifeoutof10&count=200
class Tweets 
  
  def average
    tweets = Twitter.user_timeline("mylifeoutof10", options = {count: 200})
    scores = []

    tweets.each do |message| 
      scores << message[:text]
    end

    scores.map! {|score| score.gsub "/10", "" }
    scores.map! { |x| x.to_f }
    puts "scores: #{scores}"
    total = scores.inject{|sum, x| sum + x}
    average = (total / (scores.length)).round(1)
    average
  end
end



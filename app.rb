require "sinatra"
require_relative "sentiment_classifier"

get "/" do
  erb :index, layout: :default_layout
end

post "/classify" do
  @data = params.fetch(:data)
  @sentiment = SentimentClassifier.new.predict(@data)
  erb :classified, layout: :default_layout, locals: {sentiment: @sentiment}
end

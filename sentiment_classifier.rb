require "classifier"
require "csv"

class SentimentClassifier
  def initialize
    @sentiment_classifier = Classifier::Bayes.new("Negative", "Positive")
    @positive_data = []
    @negative_data = []
  end

  def preprocess
    data = CSV.read("data.csv", headers: true)
    data.each do |row|
      row["Label"] == "1" ? @positive_data.push(row["Text"]) : @negative_data.push(row["Text"])
    end
  end

  def train_classifier
    @negative_data.map do |n|
      @sentiment_classifier.train_negative(n)
    end
    @positive_data.map do |p|
      @sentiment_classifier.train_positive(p)
    end
  end
  
  def predict(text)
    preprocess
    train_classifier
    @sentiment_classifier.classify(text)
  end
end

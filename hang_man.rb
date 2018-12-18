require 'sinatra'

get "/hangman" do
  @title = "Hangman"
  erb :hangman
end

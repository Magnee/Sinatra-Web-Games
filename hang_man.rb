require 'sinatra'


get "/hangman" do
  @title = "Hangman"
  erb :hangman
end

post "/hangman" do
  @character = params[:character]
  erb :hangman
end

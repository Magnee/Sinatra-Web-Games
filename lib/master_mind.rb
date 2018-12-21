require 'sinatra'

enable :sessions

get "/mastermind" do
  @title = "Mastermind"
  erb :mastermind
end

post "/hangman" do
  redirect "/mastermind"
end

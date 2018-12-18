require 'sinatra'

enable :sessions

get "/hangman" do
  @title = "Hangman"
  @guess = session.delete(:char)
  erb :hangman
end

post "/hangman" do
  session[:char] = params[:guess]
  redirect "/hangman"
end

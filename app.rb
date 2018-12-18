require "sinatra"
require_relative "caesar_cipher"
require_relative "hang_man"


get '/' do
  redirect :index
end


get "/index" do
  @title = "Sinatra Web Games"
  erb :index
end

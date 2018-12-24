require "sinatra"
require_relative "lib/caesar_cipher"
require_relative "lib/hang_man"
require_relative "lib/master_mind"

enable :sessions

get '/' do
  redirect :index
end

get "/index" do
  @title = "Sinatra Web Games"
  erb :index
end

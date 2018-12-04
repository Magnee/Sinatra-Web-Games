require 'sinatra'

get '/' do
  "Salve munde!"
end

get "/index" do
  erb :index
end

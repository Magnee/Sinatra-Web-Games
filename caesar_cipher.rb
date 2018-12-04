require 'sinatra'

get '/' do
  "Salve munde!"
end

get "/index" do
  erb :index
end

post "/index" do
  @string = params[:string]
  @cipher = @string
  erb :index
end

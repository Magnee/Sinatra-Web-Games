require 'sinatra'

get '/' do
  "Salve munde!"
  redirect :index
end

get "/index" do
  erb :index
end

post "/index" do
  @string = params[:string]
  @shift = params[:shift].to_s.empty? ? 0 : params[:shift].slice(/\d+/).to_i
  @cipher = caesar_cipher(@string, @shift)
  erb :index
end


def caesar_cipher(string, shift)
  up_cases = ("A".."Z").to_a
  down_cases = ("a".."z").to_a
  text_array = string.to_s.split("")
  text_array.map! do |character|
    if up_cases.include? character
      character = up_cases[(up_cases.index(character) + shift)%26]
    elsif down_cases.include? character
      character = down_cases[(down_cases.index(character) + shift)%26]
    else
      character
    end
  end
  text_array.join
end

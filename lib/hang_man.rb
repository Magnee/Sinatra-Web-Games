require 'sinatra'

enable :sessions

get "/hangman" do
  @title = "Hangman"
  session[:setup_done] == true ? play : setup
  erb :hangman
end

post "/hangman" do
  session[:setup_done] = false if params[:reset] == "true"
  session[:character] = params[:guess]
  redirect "/hangman"
end


def setup
  dictionary = File.read("public/5desk.txt").split(" ")
  @secret_word = dictionary.select{ |word| (5..12) === word.length }.sample.downcase
  session[:secret_word] = @secret_word
  @preview = @secret_word.gsub(/./, "_")
  @guesslist = ""
  @wrongs = 0
  @win = false
  @defeat = false
  @image = "images/hangman#{@wrongs}.png"
  save_session
  session[:setup_done] = true
end

def play
  load_session
  if @guess != nil
    update_guesslist
    update_preview
    update_wrongs
    check_win
    check_defeat
    update_image
  end
  save_session
end

def load_session
  @secret_word = session[:secret_word]
  @preview = session[:preview]
  @guess = session.delete(:character)
  @guesslist = session[:guesslist]
  @wrongs = session[:wrongs]
  @win = session[:win]
  @defeat = session[:defeat]
  @image = session[:image]
end

def update_guesslist
  @guesslist += @guess
  @guesslist = @guesslist.split("").sort.join("")
end

def update_preview
  @secret_word.split("").each_with_index{ |char, index| @preview[index] = @guess if char == @guess }
end

def update_wrongs
  wrong = true
  @secret_word.split("").each{ |char| wrong = false if char == @guess }
  @wrongs += 1 if wrong == true
end

def update_image
  @image = @win == true ? "images/hangmanwin.png" : "images/hangman#{@wrongs}.png"
end

def check_win
  @win = true if @secret_word == @preview
end

def check_defeat
  @defeat = true if @wrongs >= 9
end

def save_session
  session[:guesslist] = @guesslist
  session[:preview] = @preview
  session[:wrongs] = @wrongs
  session[:win] = @win
  session[:defeat] = @defeat
  session[:image] = @image
end

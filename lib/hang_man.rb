get "/hangman" do
  @title = "Hangman"
  if session[:hm_setup_done] == "yes"
    load_session_hangman
    Hangmangame.play
  else
    Hangmangame = Hangman.new
    session[:hm_setup_done] = "yes"
  end
  save_session_hangman
  erb :hangman
end

post "/hangman" do
  session[:hm_setup_done] = "no" if params[:reset] == "true"
  session[:hm_character] = params[:guess]
  redirect "/hangman"
end


class Hangman
  attr_accessor :defeat, :guess, :guesslist, :image, :preview, :secret_word, :win, :wrongs

  def initialize
    dictionary = File.read("public/5desk.txt").split(" ")
    @secret_word = dictionary.select{ |word| (5..12) === word.length }.sample.downcase
    @preview = @secret_word.gsub(/./, "_")
    @guesslist = ""
    @wrongs = 0
    @win = false
    @defeat = false
    @image = "images/hangman#{@wrongs}.png"
  end

  def play
    if @guess != nil
      update_guesslist
      update_preview
      update_wrongs
      check_win
      check_defeat
      update_image
    end
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

end

get "/mastermind" do
  @title = "Mastermind"
  if session[:mm_setup_done] == "yes"
    load_session_mastermind
    Mastermindgame.play
  else
    Mastermindgame = Mastermind.new
    session[:mm_setup_done] = "yes"
  end
  save_session_mastermind
  erb :mastermind
end

post "/mastermind" do
  session[:mm_airun]    = params[:airun]    if params[:airun]    != nil
  session[:mm_color1]   = params[:color1]   if params[:color1]   != nil
  session[:mm_color2]   = params[:color2]   if params[:color2]   != nil
  session[:mm_color3]   = params[:color3]   if params[:color3]   != nil
  session[:mm_color4]   = params[:color4]   if params[:color4]   != nil
  session[:mm_gametype] = params[:gametype] if params[:gametype] != nil
  session[:mm_setup_done] = "no" if params[:reset] == "true"
  redirect "/mastermind"
end



class Mastermind
  attr_accessor :airun, :code, :color1, :color2, :color3, :color4, :colors, :combopool,
                :defeat, :gametype, :guess, :guesses, :hints, :win

  def initialize
    @code = []
    @colors = ["blue", "green", "orange", "purple", "red", "yellow"]
    @gametype = "none"
    @guesses = []
    @hints = []
  end

  def play
    play_breaker if @gametype == "b"
    play_maker if @gametype == "m"
  end

  def play_breaker
    if @color1 != nil
      set_code_breaker if @code == []
      get_guess_player
      get_hint
      check_win
      check_defeat
    end
  end

  def play_maker
    if @code == []
      set_code_maker if @color1 != nil
    elsif @win != true && @defeat != true && @airun == "true"
      get_guess_ai
      get_hint
      check_win
      check_defeat
    end
  end

  def set_code_breaker
    4.times{ @code << @colors.sample }
  end

  def set_code_maker
    @code = [@color1, @color2, @color3, @color4]
  end

  def get_guess_player
    @guess = [@color1, @color2, @color3, @color4]
    @guesses << @guess
  end

  def get_guess_ai
    @guess = []
    if @guesses.length == 0
      4.times{ @guess << @colors.sample }
    else
      @guesses.last.each_with_index do |color, index|
        if @guesses.last[index] == @code[index]
          @guess << @code[index]
        else
          @guess << @colors.reject{ |c| c == color }.sample
        end
      end
    end
    @guesses << @guess
  end

  def get_hint
    hint = []
    @guess.each_index do |index|
      if @guess[index] == @code[index]
        hint << "V"
      end
    end
    nomatch = @code.clone
    @guess.each do |color|
      position = nomatch.index(color)
      if position
        nomatch.delete_at(position)
      end
    end
    missmatch = 4 - hint.length - nomatch.length
    missmatch.times { hint << "x" }
    nomatch.length.times { hint << "." }
    @hints << hint
  end

  def check_win
    @win = true if @code == @guess
  end

  def check_defeat
    @defeat = true if @guesses.length >= 12 && @win != true
  end

end

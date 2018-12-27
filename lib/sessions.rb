enable :sessions

def save_session_hangman
  session[:hm_defeat]       = Hangmangame.defeat
  session[:hm_guesslist]    = Hangmangame.guesslist
  session[:hm_image]        = Hangmangame.image
  session[:hm_preview]      = Hangmangame.preview
  session[:hm_secret_word]  = Hangmangame.secret_word
  session[:hm_win]          = Hangmangame.win
  session[:hm_wrongs]       = Hangmangame.wrongs
end

def load_session_hangman
  Hangmangame.defeat      = session[:hm_defeat]
  Hangmangame.guess       = session.delete(:hm_character)
  Hangmangame.guesslist   = session[:hm_guesslist]
  Hangmangame.image       = session[:hm_image]
  Hangmangame.preview     = session[:hm_preview]
  Hangmangame.secret_word = session[:hm_secret_word]
  Hangmangame.win         = session[:hm_win]
  Hangmangame.wrongs      = session[:hm_wrongs]
end

def save_session_mastermind
  session[:mm_code]       = Mastermindgame.code
  session[:mm_gametype]   = Mastermindgame.gametype
  session[:mm_guess]      = Mastermindgame.guess
  session[:mm_guesses]    = Mastermindgame.guesses
  session[:mm_hints]      = Mastermindgame.hints
end

def load_session_mastermind
  Mastermindgame.airun     = session.delete(:mm_airun)
  Mastermindgame.color1    = session.delete(:mm_color1)
  Mastermindgame.color2    = session.delete(:mm_color2)
  Mastermindgame.color3    = session.delete(:mm_color3)
  Mastermindgame.color4    = session.delete(:mm_color4)
  Mastermindgame.code      = session[:mm_code]
  Mastermindgame.gametype  = session[:mm_gametype]
  Mastermindgame.guess     = session[:mm_guess]
  Mastermindgame.guesses   = session[:mm_guesses]
  Mastermindgame.hints     = session[:mm_hints]
end

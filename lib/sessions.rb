enable :sessions

def save_session
  session[:hm_defeat]       = Hangmangame.defeat
  session[:hm_guesslist]    = Hangmangame.guesslist
  session[:hm_image]        = Hangmangame.image
  session[:hm_preview]      = Hangmangame.preview
  session[:hm_secret_word]  = Hangmangame.secret_word
  session[:hm_win]          = Hangmangame.win
  session[:hm_wrongs]       = Hangmangame.wrongs
end

def load_session
  Hangmangame.defeat      = session[:hm_defeat]
  Hangmangame.guess       = session.delete(:hm_character)
  Hangmangame.guesslist   = session[:hm_guesslist]
  Hangmangame.image       = session[:hm_image]
  Hangmangame.preview     = session[:hm_preview]
  Hangmangame.secret_word = session[:hm_secret_word]
  Hangmangame.win         = session[:hm_win]
  Hangmangame.wrongs      = session[:hm_wrongs]
end

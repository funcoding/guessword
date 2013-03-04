class HomeController < ApplicationController
  
  def index
      
  end

   
  #Get word/game
  def game
    if params[:guess] == nil
      choose_word
    else
      letter= params[:guess]
      choice(letter)
    end

  end
  
  protected
  def choose_word
    choose = (2 .. 4).to_a.sample
    @word_choose = Word.select("value").where("id = ?",choose)
    @word_array = {}
    @word_to_display = {}
    @word_choose.each do |word_choose|
      @word_choose = word_choose.value
    end
    @word_choose.split("").each do |keys|
      @word_array[keys]=0
      @word_to_display[keys]="_"
    end
    session[:count] = 0
    session[:word] = @word_array
    session[:word_to_display]=@word_to_display
  end
  
  protected
  def choice(letter)
    if session[:count] < 5
      result = false
      session[:word].each do |key, value|
        if key == letter
          session[:word][key]=1
          session[:word_to_display][key]=key
          result = true
        end
      end
      if(!result)
        session[:count]+=1
      end
      
    end
  end
end
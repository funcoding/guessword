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
    choose = (2 .. 10).to_a.sample #A number is selected in random between 2 to 10
    @word_choose = Word.select("value").where("id = ?",choose) #Appropiate word is fetched from database
    @word_array = {}
    @word_to_display = {}
    @word_choose.each do |word_choose|
      @word_choose = word_choose.value
    end
    i=0
    @word_choose.split("").each do |keys|
      @word_array[i]=keys
      @word_to_display[i]="_"
      i=i+1
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
        if value == letter
          session[:word_to_display][key]=value
          result = true
        end
      end
      if(!result)
        session[:count]+=1
      end
      
    end
  end
end
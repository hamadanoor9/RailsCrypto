class HomeController < ApplicationController
  
  def index
    @crypto_coins =  get_coins
  end
  
  def show
    
    @show_coins = get_coins
    
    
    @symbol = params[:sym]
    if @symbol
      @symbol = @symbol.downcase
    end
    @currency = "No such currency"
    for x in @show_coins
      if @symbol == x["symbol"]
        @currency = x
        
      end
    end
    
  end
  
  
  private 
  def get_coins
    require "net/http"
    require "json"
    @url = 'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false'
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    JSON.parse(@response)
  end
end

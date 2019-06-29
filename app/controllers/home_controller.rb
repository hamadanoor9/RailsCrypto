class HomeController < ApplicationController
  require "net/http"
  require "json"
  def index
    @url = 'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false'
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    
    
  end
  
  def about
    
  end
  
  def lookup
    @url = 'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false'
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    @lookup_coins = JSON.parse(@response)
    
    @symbol = params[:sym]
    if @symbol
      @symbol = @symbol.downcase
    end
    
    if @symbol == ""
      @symbol = "Empty symbol"
    end
    
  end
end

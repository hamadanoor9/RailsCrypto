class CryptosController < ApplicationController
  before_action :set_crypto, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update, :destroy, :show]
  # GET /cryptos
  # GET /cryptos.json
  def index
    @cryptos = Crypto.all
    require "net/http"
    require "json"
    @url = 'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false'
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    @lookup_crypto = JSON.parse(@response)
    @crypto_symbols = []
    for x in @lookup_crypto
      @crypto_symbols << x["symbol"]
    end
    @profit_loss = 0
  end

  # GET /cryptos/1
  # GET /cryptos/1.json
  def show
    require "net/http"
    require "json"
    @url = 'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false'
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    @show_crypto = JSON.parse(@response)
  end

  # GET /cryptos/new
  def new
    @crypto = Crypto.new
    require "net/http"
    require "json"
    @url = 'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false'
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    @new_crypto = JSON.parse(@response)
    @crypto_symbols = []
    for x in @new_crypto
      @crypto_symbols << x["symbol"]
    end
  end

  # GET /cryptos/1/edit
  def edit
  end

  # POST /cryptos
  # POST /cryptos.json
  def create
    @crypto = Crypto.new(crypto_params)

    respond_to do |format|
      if @crypto.save
        format.html { redirect_to @crypto, notice: 'Crypto was successfully created.' }
        format.json { render :show, status: :created, location: @crypto }
      else
        format.html { render :new }
        format.json { render json: @crypto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cryptos/1
  # PATCH/PUT /cryptos/1.json
  def update
    respond_to do |format|
      if @crypto.update(crypto_params)
        format.html { redirect_to @crypto, notice: 'Crypto was successfully updated.' }
        format.json { render :show, status: :ok, location: @crypto }
      else
        format.html { render :edit }
        format.json { render json: @crypto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cryptos/1
  # DELETE /cryptos/1.json
  def destroy
    @crypto.destroy
    respond_to do |format|
      format.html { redirect_to cryptos_url, notice: 'Crypto was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_crypto
      @crypto = Crypto.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def crypto_params
      params.require(:crypto).permit(:symbol, :user_id, :cost_per, :amount_owned)
    end
    
    def correct_user
      @correct = current_user.cryptos.find_by(id: params[:id])
      redirect_to cryptos_path, notice: "Not Authorized to edit this entry" if @correct.nil?
    end
end

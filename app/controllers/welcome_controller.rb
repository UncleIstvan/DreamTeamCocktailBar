class WelcomeController < ApplicationController

  before_filter :find_item, only: [:show]

  def index
    @cocktails = Cocktail.all #_with_includes
  end

  def show

  end

  def search_by_product
    @cocktails = Cocktail.filter_by_product_with_includes(params[:product_name])
    puts @cocktails
    puts 11111111111111111111111111111111111
    render :index
  end

  private
  def find_item
    @cocktail = Cocktail.find_with_includes(params[:id])
  end

end

class WelcomeController < ApplicationController

  before_filter :find_item, only: [:show]

  def index
    @cocktails = Cocktail.all_with_includes
  end

  def show

  end

  def search_by_product
    @cocktails = Cocktail.filter_by_product_with_includes(params[:product_name])
    render :index
  end

  def search_by_name
      if  params[:name].length>1
      @cocktails_with_name = Cocktail.includes(ingredients: [:product]).where('name like?', "%#{params[:name]}%")
      @cocktails_with_product = Cocktail.filter_by_product_with_includes(params[:name])

      else
        flash[:warning] = 'wrong input, query must be 2 symbols or longer'
        redirect_to root_url
      end

  end

  private
  def find_item
    @cocktail = Cocktail.find_with_includes(params[:id])
  end

end

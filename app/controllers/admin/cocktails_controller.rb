class Admin::CocktailsController < Admin::SignedApplicationController



  before_filter :find_item, only: [:edit, :update, :destroy, :show]

  INGREDIENT_MAX_COUNT = 5

  before_action :before_action, only: [:new]

  def index
    @cocktails = Cocktail.all
  end

  def new

    @cocktail = Cocktail.new

    @cocktail.ingredients.build('product_id' => @product_id ) unless @product_id.blank?

    prepare_ingredient_items

  end

  def create
    @cocktail = Cocktail.create item_params
    if @cocktail.errors.empty?
      # if params[:continue].blank?
      #   redirect_to action: :index
      # else
      #   redirect_to action: :new
      # end

      flash[:success] = "Cocktail ' #{@cocktail.name.humanize} ' was created successflulyy"
      redirect_to @cocktail

    else
      flash[:warning] = @cocktail.errors.full_messages.to_sentence
      prepare_ingredient_items
      render :new
    end
  end

  def update
    @cocktail.update_attributes item_params
    if @cocktail.errors.empty?
      flash[:success] = "Cocktail \' #{@cocktail.name.humanize} \' was updated successflulyy"
      redirect_to action: :index
    else
      flash[:warning] = @cocktail.errors.full_messages.to_sentence
      prepare_ingredient_items
      render :edit
    end
  end

  def item_params
    params.require(:cocktail).permit(:id, :name, :image, :remove_image, :description, ingredients_attributes: [:id, :value, :product_id, :cocktail_id])
  end

  def edit
    prepare_ingredient_items
  end

  #DELETE
  def destroy
    @cocktail.destroy
    if @cocktail.errors.empty?
      flash[:success] = "Cocktail '#{@cocktail.name}' was removed successfully "
      redirect_to action: 'index'
    else
      flash[:warning] = @cocktail.errors.full_messages.to_sentence
      redirect_to action: 'index'
    end
  end

  def redirect_to_back error_message
    flash[:warning] = error_message
    redirect_to request.referer.blank? ? root_url : request.referer
  end

  def show

  end


  private
  def find_item
    @cocktail = Cocktail.find_with_includes(params[:id])

  end

  def prepare_ingredient_items

    (INGREDIENT_MAX_COUNT - @cocktail.ingredients.size).times {@cocktail.ingredients.build}

  end

  def before_action

    @cocktail = Cocktail.new
    product_id = params[:product_id]
    if validate_product_id? product_id
      @cocktail.ingredients.build(product_id: product_id)
    else
      redirect_to_back "Can not find product with id #{product_id}"
    end

end


  def validate_product_id? id
    result = true
    unless id.blank?
      product = Product.find_by(id: id)
      if product.blank?
        result = false
      end
    end
    result
  end

end

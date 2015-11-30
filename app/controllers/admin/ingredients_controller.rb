class Admin::IngredientsController < Admin::SignedApplicationController

  before_filter :find_item, only: [:edit, :update, :destroy]

  def index
    @ingredient = Ingredient.all
  end


  def new
    cocktail = Cocktail.find_by(id: params[:cocktail_id])
    if cocktail
    @ingredient = Ingredient.new
      @ingredient.cocktail = cocktail
      session[:redirect_to]= request.referer
    else
      flash[:warning] = '@ingredient.errors.full_messages.to_sentence'
      redirect_to request.referer.blank? ? root_url : request.referer
    end

  end

  def create
    @ingredient = Ingredient.create item_params
    if @ingredient.errors.empty?
      # if params[:continue].blank?
      #   redirect_to action: :index
      # else
      #   redirect_to action: :new
      # end

      flash[:success] = "ingredient was created successflulyy"
      redirect_to session.delete(:redirect_to)
    else
      flash[:warning] = @ingredient.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    @ingredient.update_attributes item_params
    if @ingredient.errors.empty?
      flash[:success] = 'ingredient was updated successfully'
    else
      flash[:warning] = @ingredient.errors.full_messages.to_sentence
      render :edit
    end
  end

  def item_params
    params.require(:ingredient).permit(:id, :product_id, :cocktail_id, :value)
  end

  def edit

 session[:return_to] ||= request.referer unless request.referer.blank?
  end


  def destroy
    session[:return_to] ||= request.referer
    Ingredient.destroy(params[:id])
    if @ingredient.errors.empty?
      flash[:success] = 'ingredient was removed successfully '
      redirect_to session.delete(:return_to)
    else
      flash[:warning] = @ingredient.errors.full_messages.to_sentence
      redirect_to session.delete(:return_to)
    end
  end

  def show

  end


  private
  def find_item
    @ingredient = Ingredient.find_by(params[:id])
  end



end

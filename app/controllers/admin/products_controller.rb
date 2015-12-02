class Admin::ProductsController < Admin::SignedApplicationController

  before_filter :find_item, only: [:edit, :update, :destroy, :show]

  # GET
  def index
    @products = Product.all
  end

  # GET
  def new
    @product = Product.new
  end

  #POST
  def create
    @product = Product.create item_params
    redirect_to action: 'index'
  end

  def item_params
    params.require(:product).permit(:id, :name, :cost_price,:image, :remove_image, :min_value, :product_type)
  end

  #GET
  def edit
    # @product = Product.where(id: params[:id]).first
  end

  #PUT
  def update
    # @product = Product.find_by(id: params[:id]).first
    # @product = Product.where(id: params[:id]).first
    @product.update_attributes item_params
    if @product.errors.empty?
      redirect_to action: 'index'
    else
      render 'edit'
    end
  end

  #DELETE
  def destroy
    @product.destroy
    redirect_to action: 'index'
  end

  #GET
  def show

  end

  def search
    # redirect_to action: 'search'
    @products = Product.where('name like?', "%#{params[:name]}%")
    # @product = Product.where(name: )
  end

  def sort_by

    if params[:type] == 'name'
      if params[:order] == 'asc'
        @products = Product.order(name: :asc)
        render :index
      else
          @products = Product.order(name: :desc)
          render :index
        end

    else
      if params[:type] == 'price'

        if params[:order] == 'asc'
          @products = Product.all.sort_by(&:price)
        else
          @products = Product.all.sort_by(&:price).reverse
        end
        render :index
      end

    end

  end


  private
  def find_item
    @product = Product.find_by(id: params[:id])
  end

end

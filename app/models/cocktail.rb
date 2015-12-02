class Cocktail < ActiveRecord::Base

  mount_uploader :image, CocktailImageUploader

  has_many :ingredients, dependent: :destroy
  has_many :products, through: :ingredients
  # accepts_nested_attributes_for :ingredients
  accepts_nested_attributes_for :ingredients, reject_if: lambda { |attributes| attributes[:value].blank? && attributes[:product_id].blank? }

  before_save { self.name = name.titleize}

  validates :name, presence: true, acceptance: false

  validate :validate_ingredients

  def validate_ingredients
    if ingredients.size < 2
      errors.add(:ingredients, 'quantity must be greater than one')
    elsif ingredients.select { |ingredient| ingredient.product.product_type == 'drink' }.size < 1
      errors.add(:ingredients, 'with product type \'drink\' must be present in cocktail (minimum is 1) ')
    end
  end



  def value
    # ingredients.joins(:product).where('products.product_type = ?', 'drink').sum(:value)
    ingredients.inject(0) { |sum, ingredient|
      sum + (ingredient.product.product_type == 'drink' ? ingredient.value : 0)
    }
  end

  def price
    # ingredients.all.inject(0) { |price, ingredient|
    #   price + (ingredient.value / ingredient.product.min_value) * ingredient.product.price
    # }
    ingredients.inject(0) { |price, ingredient|
      price + (ingredient.value / ingredient.product.min_value) * ingredient.product.price
    }.ceil
  end

  def volume_type
    unless self.value < 150
    'long'
    else
      'short'
    end
  end

  def self.find_with_includes (id)
    self.includes(ingredients: [:product]).find(id)
  end

  def all_with_includes

  end

  def self.filter_by_product_with_includes product_name
   # self.joins(:products).includes(ingredients: [:product]).where('products.name = ?', product_name)
   # self.joins(:products).includes(ingredients: [:product]).where('products.name like ?', "%#{product_name}%")
    self.joins(:products).includes(ingredients: [:product]).where('products.name like ?', "%#{product_name}%")
  end



end

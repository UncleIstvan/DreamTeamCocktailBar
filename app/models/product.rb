class Product < ActiveRecord::Base

  mount_uploader :image, ProductImageUploader

  has_many :ingredients
  has_many :cocktails, through: :ingredients, dependent: :destroy

  before_save {self.name = name.titleize}

  @@product_types = ['drink', 'not drink']
  @@tax = 0.04
  @@markup_percent = 0.5

  def price
    cost_price + markup + (markup * @@tax)
  end

  def self.product_types
    @@product_types
  end

  # validates :name, :cost_price, :min_value, :product_type, presence: true
  # validates :cost_price, :min_value, numericality: {:greater_than => 0}
  validates :cost_price, :min_value, :product_type, presence: true
  validates :name, presence: true, allow_blank: false, length: {maximum: 50}
  validates :cost_price, :min_value, numericality: {:greater_than => 0}

  def combined_name

    "#{name} - #{product_type}"

  end

  private
  def markup
    cost_price * @@markup_percent
  end


end

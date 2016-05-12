class LineItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product
  accepts_nested_attributes_for :product
  
  def total_price
    product.price * quantity
  end
  
end

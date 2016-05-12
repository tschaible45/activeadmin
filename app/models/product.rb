class Product < ActiveRecord::Base
    belongs_to :category
    has_and_belongs_to_many :line_items
    has_many :orders, through: :line_items
    accepts_nested_attributes_for :line_items
    
    # Named Scopes
  scope :available, lambda{ where("available_on < ?", Date.today) }
  scope :drafts, lambda{ where("available_on > ?", Date.today) }

  # Validations
  validates_presence_of :title
  validates_presence_of :price
  validates_presence_of :image_file_name
end

class Category < ActiveRecord::Base
  # no foreign key - no special column needed
  # uses plural of child model
   has_many :products
   has_many :requests
    accepts_nested_attributes_for :products
    
# Named Scopes
  scope :available, lambda{ where(enabled: true) }
  
  # Validations
  validates_presence_of :name
  def is_active
      self.active
  end
end

class Recipe < ApplicationRecord
  belongs_to :user
  has_many :ingredient_lists
  has_many :ingredients, through: :ingredient_lists, :dependent => :destroy

  scope :rating, -> { where(rating: 5)}

  validates_presence_of :name, :rating, :instructions 
  
  accepts_nested_attributes_for :ingredients, reject_if: proc {|attributes| attributes['name'].blank?}, allow_destroy: true

  def ingredients_attributes=(ingredient_attributes)
    ingredient_attributes.values.each do |ingredient_attribute|
      if !ingredient_attribute.empty?
        new_ingredient = Ingredient.find_or_create_by(ingredient_attribute)
        self.ingredients << new_ingredient
      end
    end
  end
end

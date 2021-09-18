class Category < ApplicationRecord
  belongs_to :parent_category, class_name: "Category", optional: true, foreign_key: 'category_id'
  has_many :children_categories, class_name: "Category", dependent: :destroy
  
  belongs_to :type
  has_many :markers, dependent: :destroy

  def to_s
    name
  end
  

  def self.all_the_child_categories
    children_categories = []
    self.children_categories.each do |child_category|
        children_categories << child_category.name
    end
    children_categories
  end

  def self.parent_category
    where(category_id: nil)
  end

  def name_type
    Type.references(:category).where(id: type_id).pluck :name
  end

  def public_options
    if public == true
        'Publico'
    else
        'Privado'
    end
  end

end

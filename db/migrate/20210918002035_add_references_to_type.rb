class AddReferencesToType < ActiveRecord::Migration[5.2]
  def change
    add_reference :types, :category, foreign_key: true
  end
end

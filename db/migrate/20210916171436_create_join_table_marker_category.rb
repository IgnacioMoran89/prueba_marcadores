class CreateJoinTableMarkerCategory < ActiveRecord::Migration[5.2]
  def change
    create_join_table :markers, :categories do |t|
      t.index [:marker_id, :category_id]
      t.index [:category_id, :marker_id]
    end
  end
end

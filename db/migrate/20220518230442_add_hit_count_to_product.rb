class AddHitCountToProduct < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :hit_count, :integer
  end
end

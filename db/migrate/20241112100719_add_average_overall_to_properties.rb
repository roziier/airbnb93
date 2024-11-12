class AddAverageOverallToProperties < ActiveRecord::Migration[7.1]
  def change
    add_column :properties, :average_overall, :decimal
  end
end

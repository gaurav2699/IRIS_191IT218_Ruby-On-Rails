class AddBroughtByToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :brought_by, :integer
  end
end

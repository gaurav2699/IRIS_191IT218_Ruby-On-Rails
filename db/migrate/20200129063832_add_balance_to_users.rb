class AddBalanceToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :balance, :integer, :default=>500
  end
end

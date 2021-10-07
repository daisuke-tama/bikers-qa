class AddUserIdToMyBikes < ActiveRecord::Migration[6.1]
  def change
    add_column :my_bikes, :user_id, :bigint
  end
end

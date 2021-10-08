class ChangeColumnsAddNotnullOnMyBikes < ActiveRecord::Migration[6.1]
  def change
    change_column_null :my_bikes, :user_id, false
  end
end

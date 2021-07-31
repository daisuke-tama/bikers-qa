class NotHaveUserForeignKey < ActiveRecord::Migration[6.1]
  def change
    drop_table :messages
    drop_table :entries
  end
end

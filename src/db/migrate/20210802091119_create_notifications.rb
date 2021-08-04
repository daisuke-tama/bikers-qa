class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.integer :visitor_id, null: false
      t.integer :visited_id, null: false
      t.integer :article_id
      t.integer :comment_id
      t.integer :question_id
      t.integer :answer_id
      t.integer :message_id
      t.integer :entry_id
      t.string :action, default: '', null: false
      t.boolean :checked, default: false, null: false

      t.timestamps
    end

    add_index :notifications, :visitor_id
    add_index :notifications, :visited_id
    add_index :notifications, :article_id
    add_index :notifications, :comment_id
    add_index :notifications, :question_id
    add_index :notifications, :answer_id
    add_index :notifications, :message_id
    add_index :notifications, :entry_id
  end
end
class RenameEntryIdColumnToNotifications < ActiveRecord::Migration[6.1]
  def change
    rename_column :notifications, :entry_id, :room_id
  end
end

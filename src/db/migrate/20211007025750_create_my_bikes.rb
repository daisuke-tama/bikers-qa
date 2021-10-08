class CreateMyBikes < ActiveRecord::Migration[6.1]
  def change
    create_table :my_bikes do |t|
      t.string :picture
      t.string :name
      t.date :purchase_date
      t.text :description

      t.timestamps
    end
  end
end

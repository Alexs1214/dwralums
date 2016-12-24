class CreateAlums < ActiveRecord::Migration
  def change
    create_table :alums do |t|
      t.string :name
      t.integer :class
      t.string :major
      t.string :location
      t.string :industry
      t.string :company
      t.string :title
      t.string :website
      t.text :other
      t.string :email

      t.timestamps

    end
  end
end

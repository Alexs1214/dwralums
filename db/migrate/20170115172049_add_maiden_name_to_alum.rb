class AddMaidenNameToAlum < ActiveRecord::Migration
  def change
    add_column :alums, :maiden_name, :string
  end
end

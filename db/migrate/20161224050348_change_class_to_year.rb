class ChangeClassToYear < ActiveRecord::Migration
  def change
    rename_column :alums, :class, :year
  end
end

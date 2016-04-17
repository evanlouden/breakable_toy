class RenameVillainColumn < ActiveRecord::Migration
  def change
    rename_column :matches, :villian_id, :villain_id
  end
end

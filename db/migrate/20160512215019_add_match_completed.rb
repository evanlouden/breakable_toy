class AddMatchCompleted < ActiveRecord::Migration
  def change
    add_column :matches, :match_completed, :boolean, default: :false 
  end
end

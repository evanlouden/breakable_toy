class AddHandicapToUsers < ActiveRecord::Migration
  def change
    add_column :users, :handicap, :integer, default: 0
  end
end

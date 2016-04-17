class CreateHoles < ActiveRecord::Migration
  def change
    create_table :holes do |t|
      t.integer :hole_number, null: false
      t.integer :par, null: false
      t.integer :difficulty, null: false
      t.belongs_to :course, null: false 
    end
  end
end

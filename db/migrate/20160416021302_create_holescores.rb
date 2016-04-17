class CreateHolescores < ActiveRecord::Migration
  def change
    create_table :holescores do |t|
      t.integer :strokes, null: false
      t.integer :gross_score, null: false
      t.integer :net_score, null: false
      t.belongs_to :user, null: false
      t.belongs_to :hole, null: false
      t.belongs_to :match, null: false 
    end
  end
end

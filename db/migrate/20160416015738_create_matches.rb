class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :match_status, null: false, default: 0
      t.references :hero, index: true, null: false
      t.references :villain, index: true, null: false
      t.integer :hero_adj_handicap, null: false 
      t.integer :villain_adj_handicap, null: false
      t.belongs_to :course, null: false

      t.timestamps
    end
  end
end

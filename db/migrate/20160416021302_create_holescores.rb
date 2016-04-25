class CreateHolescores < ActiveRecord::Migration
  def change
    create_table :holescores do |t|
      t.integer :strokes, default: 0
      t.integer :gross_score
      t.integer :net_score
      t.belongs_to :user, null: false
      t.belongs_to :hole, null: false
      t.belongs_to :match, null: false
    end
  end
end

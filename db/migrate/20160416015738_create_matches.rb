class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :match_status, null: false
      t.references :hero, null: false
      t.references :villian, null: false
      t.belongs_to :course, null: false 

      t.timestamps
    end
  end
end

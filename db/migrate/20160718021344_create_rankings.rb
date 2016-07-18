class CreateRankings < ActiveRecord::Migration
  def change
    create_table :rankings do |t|
      t.references :rankee, polymorphic: true, index: true
      t.references :ranker, polymorphic: true, index: true
      t.integer :score

      t.timestamps null: false
    end
  end
end

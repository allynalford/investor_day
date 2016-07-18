class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.references :scheduling_block, index: true, foreign_key: true
      t.references :company, index: true, foreign_key: true
      t.references :investor, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

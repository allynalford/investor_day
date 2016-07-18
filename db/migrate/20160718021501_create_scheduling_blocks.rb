class CreateSchedulingBlocks < ActiveRecord::Migration
  def change
    create_table :scheduling_blocks do |t|
      t.string :start_time
      t.boolean :bookable

      t.timestamps null: false
    end
  end
end

class AddScoreToMatch < ActiveRecord::Migration
  def change
    add_reference :matches, :ranking, index: true, foreign_key: true
  end
end

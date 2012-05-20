class AddScoreToEvents < ActiveRecord::Migration
  def change
    add_column :events, :score, :string

    add_index :events, :score
  end
end

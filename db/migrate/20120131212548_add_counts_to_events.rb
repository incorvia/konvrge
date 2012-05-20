class AddCountsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :friend_count, :string

    add_column :events, :friend_score, :string

  end
end

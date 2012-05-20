class RemoveScoreColumnsFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :friend_count
    remove_column :events, :friend_score
  end
end

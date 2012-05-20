class ChangeColumnTypeVotesFbId < ActiveRecord::Migration
  def up
    change_column :votes, :fb_id, :string
  end

  def down
    change_column :votes, :fb_id, :integer
  end
end

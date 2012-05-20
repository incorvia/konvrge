class AddNameToEvents < ActiveRecord::Migration
  def change
    add_column :events, :user_name, :string
  end
end

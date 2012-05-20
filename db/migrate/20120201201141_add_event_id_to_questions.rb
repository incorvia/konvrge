class AddEventIdToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :event_id, :integer

    add_index :questions, :event_id
  end
end

class CreateRakeLogs < ActiveRecord::Migration
  def change
    create_table :rake_logs do |t|

      t.timestamps
    end
  end
end

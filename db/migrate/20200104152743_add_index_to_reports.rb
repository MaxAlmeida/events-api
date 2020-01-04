class AddIndexToReports < ActiveRecord::Migration[5.2]
  def change
    add_index :reports, [:user_id, :comment_id], unique: true
  end
end

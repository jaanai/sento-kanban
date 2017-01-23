class AddsCommentIdColumnToActivitiesTables < ActiveRecord::Migration[5.0]
  def change
    add_column :sento_kanban_activities, :comment_id, :integer
    add_index :sento_kanban_activities, :comment_id
  end
end

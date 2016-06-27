class DeleteEventColumn < ActiveRecord::Migration
  def change
    remove_column :ratings, :event_id
  end
end

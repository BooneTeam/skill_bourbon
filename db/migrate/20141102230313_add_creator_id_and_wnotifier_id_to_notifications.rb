class AddCreatorIdAndWnotifierIdToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :to_notify_id, :integer
    add_column :notifications, :to_notify_type, :string, default: "User"
  end
end

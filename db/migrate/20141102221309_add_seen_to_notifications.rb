class AddSeenToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :seen, :boolean, default: false
    add_column :notifications, :item_changed, :string
  end
end

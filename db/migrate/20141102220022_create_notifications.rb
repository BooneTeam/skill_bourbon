class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string  :description
      t.string  :title

      t.string  :notifiable_type
      t.integer :notifiable_id
      t.timestamps
    end
  end
end

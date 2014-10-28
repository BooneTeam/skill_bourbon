class AddUserIdToPath < ActiveRecord::Migration
  def change
    add_column :paths, :user_id, :integer
  end
end

class AddPathIdToSkills < ActiveRecord::Migration
  def change
    add_column :skills, :path_id, :integer
  end
end

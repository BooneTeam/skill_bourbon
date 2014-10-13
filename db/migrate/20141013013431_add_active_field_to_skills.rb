class AddActiveFieldToSkills < ActiveRecord::Migration
  def change
    add_column :skills, :is_active, :boolean, default: false
  end
end

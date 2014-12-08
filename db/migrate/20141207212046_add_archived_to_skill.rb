class AddArchivedToSkill < ActiveRecord::Migration
  def change
    add_column :skills, :archived, :boolean, :default => false
  end
end

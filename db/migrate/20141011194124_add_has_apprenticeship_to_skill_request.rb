class AddHasApprenticeshipToSkillRequest < ActiveRecord::Migration
  def change
    add_column :skill_requests, :has_apprenticeship, :boolean
  end
end

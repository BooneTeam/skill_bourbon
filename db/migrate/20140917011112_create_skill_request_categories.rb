class CreateSkillRequestCategories < ActiveRecord::Migration
  def change
    create_table :skill_request_categories do |t|
      t.references :category
      t.references :skill_request

      t.timestamps
    end
  end
end

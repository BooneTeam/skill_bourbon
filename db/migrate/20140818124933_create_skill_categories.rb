class CreateSkillCategories < ActiveRecord::Migration
  def change
    create_table :skill_categories do |t|
      t.references :category
      t.references :skill
      t.timestamps
    end
  end
end

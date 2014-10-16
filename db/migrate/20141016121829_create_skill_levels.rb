class CreateSkillLevels < ActiveRecord::Migration
  def change
    create_table :skill_levels do |t|
      t.string     :title
      t.string     :description
      t.integer    :level_num

      t.timestamps
    end
  end
end

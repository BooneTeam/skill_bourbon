class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.text    :description
      t.string  :name

      t.string  :creator_type
      t.integer :creator_id
      t.integer :creator_level

      t.timestamps
    end
  end
end

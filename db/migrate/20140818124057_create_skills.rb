class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.string  :title
      t.string  :subtitle
      t.text    :full_description

      t.string  :creator_type
      t.integer :creator_id
      t.integer :creator_level

      t.references :location

      t.timestamps
    end
  end
end

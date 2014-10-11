class CreateSkillRequests < ActiveRecord::Migration
  def change
    create_table :skill_requests do |t|
      t.string  :title
      t.string  :subtitle
      t.text    :full_description

      t.string     :accepted_status, default: "pending"
      t.references :location
      t.references :user

      t.timestamps
    end
  end
end

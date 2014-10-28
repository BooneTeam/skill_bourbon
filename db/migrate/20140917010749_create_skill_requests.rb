class CreateSkillRequests < ActiveRecord::Migration
  def change
    create_table :skill_requests do |t|
      t.string  :title
      t.string  :subtitle
      t.text    :full_description
      # t.integer :apprentice_level
      t.datetime   :meeting_date_scheduled
      t.datetime   :meeting_date_requested

      t.string     :accepted_status, default: "pending"
      t.references :location
      t.references :user
      t.references :skill_level


      t.timestamps
    end
  end
end

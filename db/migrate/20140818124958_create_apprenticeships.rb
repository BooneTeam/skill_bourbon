class CreateApprenticeships < ActiveRecord::Migration
  def change
    create_table :apprenticeships do |t|
      t.references :user
      t.references :skill
      t.references :location

      t.text       :request_description
      t.string     :completion_status
      t.string     :accepted_status, default: "pending"
      t.integer    :apprentice_level
      t.datetime   :meeting_date_scheduled
      t.datetime   :meeting_date_requested

      t.timestamps
    end
  end
end

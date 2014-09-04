class CreateApprenticeships < ActiveRecord::Migration
  def change
    create_table :apprenticeships do |t|
      t.references :user
      t.references :skill
      t.references :location

      t.text       :request_description
      t.string     :completion_status
      t.string     :accepted_status
      t.integer    :apprentice_level
      t.datetime   :date_scheduled
      t.datetime   :date_requested

      t.timestamps
    end
  end
end

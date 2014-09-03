class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.references :apprenticeship
      t.references :user

      t.text       :note
    end
  end
end

class AddUserAndCreatorDateAcceptField < ActiveRecord::Migration
  def change
    add_column :apprenticeships, :apprentice_accept_date, :boolean, :default => false
    add_column :apprenticeships, :creator_accept_date,    :boolean, :default => false
  end
end

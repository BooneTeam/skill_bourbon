class AddPriceToSkills < ActiveRecord::Migration
  def change
    add_column :skills, :price, :decimal, :precision => 8, :scale => 2, default: 0.00
  end
end

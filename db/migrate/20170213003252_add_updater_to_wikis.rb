class AddUpdaterToWikis < ActiveRecord::Migration[5.0]
  def change
    add_column :wikis, :updated_by, :integer
  end
end

class AddTestToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :test, :boolean, default: true
  end
end

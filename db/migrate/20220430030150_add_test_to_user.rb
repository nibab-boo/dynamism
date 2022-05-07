class AddTestToUser < ActiveRecord::Migration[6.1]
  def up
    add_column :users, :test, :boolean, default: true
  end

  def down
    remove_column :users, :test
  end
end

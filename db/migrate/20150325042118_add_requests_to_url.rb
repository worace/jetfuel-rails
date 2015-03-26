class AddRequestsToUrl < ActiveRecord::Migration
  def change
    add_column :urls, :requests, :integer
  end
end

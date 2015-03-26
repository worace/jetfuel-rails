class AddDefaultToUrlRequests < ActiveRecord::Migration
  def change
    change_column :urls, :requests, :integer, :default => 1
  end
end

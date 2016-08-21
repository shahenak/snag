class AddUrlToResults < ActiveRecord::Migration
  def change
    add_column :results, :url, :string
  end
end

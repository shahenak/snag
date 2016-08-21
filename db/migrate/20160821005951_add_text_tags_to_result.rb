class AddTextTagsToResult < ActiveRecord::Migration
  def change
    add_column :results, :text_tags, :string
  end
end

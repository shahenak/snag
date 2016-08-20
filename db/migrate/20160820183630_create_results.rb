class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.text :message
      t.datetime :date
      t.string :username

      t.timestamps null: false
    end
  end
end

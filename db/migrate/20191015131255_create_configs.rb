class CreateConfigs < ActiveRecord::Migration[6.0]
  def change
    create_table :configs do |t|
      t.string  :title
      t.string  :hotfolder
      t.integer :max_time
      t.integer :day
      t.string  :unique_id
      t.string  :firstname
      t.string  :lastname
      t.string  :entry_class
      t.string  :gender
      t.string  :classifier
      t.string  :time
      t.string  :school
      t.string  :team
      t.string  :jrotc
      t.timestamps
    end
  end
end

class CreateConfigs < ActiveRecord::Migration[6.0]
  def change
    create_table :configs do |t|
      t.string :title
      t.string :hotfolder
      t.integer :max_time

      t.timestamps
    end
  end
end

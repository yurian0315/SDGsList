class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :content
      t.timestamps null: false
      t.string :image
    end
    
  end
end

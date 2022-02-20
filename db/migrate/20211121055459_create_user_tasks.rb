class CreateUserTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :user_tasks do |t|
      t.references :user
      t.references :task
      t.integer :count, default: 0
      t.boolean :check, default: false
      t.timestamps null: false
    end
  end
end

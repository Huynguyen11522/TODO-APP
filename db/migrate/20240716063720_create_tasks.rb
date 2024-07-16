class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks, id: false do |t|
      t.text :id
      t.text :title
      t.text :content
      t.text :status
      t.datetime :startDate
      t.datetime :endDate

      t.index :id, unique: true
      t.timestamps
    end
  end
end

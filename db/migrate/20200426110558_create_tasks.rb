class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string     :name
      t.boolean    :completed, default: false
      t.references :project, index: true
      t.timestamps
    end
  end
end

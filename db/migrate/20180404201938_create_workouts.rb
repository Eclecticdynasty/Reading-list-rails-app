class CreateWorkouts < ActiveRecord::Migration[5.1]
  def change
    create_table :workouts do |t|
      t.string :workout
      t.string :length
      t.datetime :date
      
      t.timestamps
    end
  end
end

class CreateSdlSchedules < ActiveRecord::Migration
  def change
    create_table :sdl_schedules do |t|
      t.date :date, null: false
      t.integer :open_period, null: false
      t.integer :close_period, null: false
    end
    add_index :sdl_schedules, :date, unique: true
  end
end

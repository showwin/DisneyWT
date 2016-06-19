class CreateTdsSchedules < ActiveRecord::Migration
  def change
    create_table :tds_schedules do |t|
      t.date :date, null: false
      t.integer :open_period, null: false
      t.integer :close_period, null: false
    end
    add_index :tds_schedules, :date, unique: true
  end
end

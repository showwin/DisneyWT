class CreateTdsPasts < ActiveRecord::Migration
  def change
    create_table :tds_pasts do |t|
      t.string :name, null: false
      t.integer :waittime, null: false
      t.boolean :status, null: false, defalut: false
      t.string :fastpass, null: false, default: ''
      t.integer :period, null: false, default: 0
      t.date :date, null: false
    end
    add_index :tds_pasts, :date
  end
end

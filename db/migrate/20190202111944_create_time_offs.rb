class CreateTimeOffs < ActiveRecord::Migration[5.2]
  def change
    create_table :time_offs do |t|
      t.datetime :from_date
      t.datetime :to_date
      t.string :note
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :name
      t.string :description
      t.decimal :latitude
      t.decimal :longitude

      t.timestamps
    end
  end
end

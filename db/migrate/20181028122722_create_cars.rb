class CreateCars < ActiveRecord::Migration[5.0]
  def change
    create_table :cars do |t|
      t.string :make
      t.string :model
      t.integer :year
      t.float :engine_size
      t.string :description

      t.timestamps
    end
  end
end

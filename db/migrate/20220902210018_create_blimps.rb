class CreateBlimps < ActiveRecord::Migration[7.0]
  def change
    create_table :blimps do |t|
      t.string :name
      t.integer :altitude

      t.timestamps
    end
  end
end

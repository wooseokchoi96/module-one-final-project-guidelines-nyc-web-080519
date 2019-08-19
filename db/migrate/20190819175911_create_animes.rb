class CreateAnimes < ActiveRecord::Migration[5.0]
  def change
    create_table :animes do |t|
      t.string :name
      t.text :synopsis
      t.timestamps
    end
  end
end

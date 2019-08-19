class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.integer :user_id
      t.integer :anime_id
      t.text :review
      t.float :rating
      t.timestamps
    end
  end
end

class AddMalIdToAnimesAndReviews < ActiveRecord::Migration[5.0]
  def change
    add_column :animes, :mal_id, :integer
    add_column :reviews, :mal_id, :integer  
  end
end

class CreateAssetHistories < ActiveRecord::Migration[6.1]
  def change
    create_table :asset_histories do |t|
      t.bigint :asset_id
      t.bigint :user_id
      t.datetime :borrowed_at
      t.datetime :returned_at
    end
    add_index :asset_histories, :asset_id
    add_index :asset_histories, :user_id
  end
end

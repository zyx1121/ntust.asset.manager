class AssetHistory < ActiveRecord::Base
  belongs_to :asset
  belongs_to :user
  validates :user_id, presence: true
  validates :borrowed_at, presence: true
end

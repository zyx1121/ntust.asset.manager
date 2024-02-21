class Asset < ActiveRecord::Base
  validates :name, presence: true
  validates :status, inclusion: { in: %w[Available CheckedOut UnderMaintenance] }
end

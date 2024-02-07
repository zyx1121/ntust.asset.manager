class Asset < ActiveRecord::Base
  validates :name, presence: true
  validates :status, inclusion: { in: %w[Available CheckedOut UnderMaintenance] }

  def is_available?
    status == 'Available'
  end
end

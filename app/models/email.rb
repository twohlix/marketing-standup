class Email < ActiveRecord::Base
  validates :address, presence: true, uniqueness: { case_sensitive: false }

  def address=(addy)
    self[:address] = addy.downcase
  end
end

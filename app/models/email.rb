class Email < ActiveRecord::Base
  require 'digest/md5'

  validates :address, presence: true, uniqueness: { case_sensitive: false }

  def address=(addy)
    self[:address] = addy.downcase
  end

  def confirm
    return false unless persisted?

    md5 = Digest::MD5.new

    self[:confirmation_key] = md5.hexdigest "#{address}#{Time.now.usec.to_s}"
  
    return false if changes.count > 1
    save
  end 
end

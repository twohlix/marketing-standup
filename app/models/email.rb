class Email < ActiveRecord::Base
  require 'digest/md5'

  after_initialize :default_values
  def default_values
    self.confirmation_attempts = 0 if self.confirmation_attempts.nil?
  end

  validates :address, presence: true, uniqueness: { case_sensitive: false }


  def address=(addy)
    self[:address] = addy.downcase
  end

  def send_confirmation
    return false unless persisted?

    md5 = Digest::MD5.new

    self[:confirmation_key] = md5.hexdigest "#{address}#{Time.now.usec.to_s}"
  
    return false if changes.count > 1
    self[:confirmation_attempts] += 1
    save
  end

  def confirm(key=nil)
    return false unless persisted? 
    return false if confirmed? #no need to confirm again
    return false if key.blank?
    return false if self[:confirmation_key].blank?

    if key.eql? self[:confirmation_key]
      self[:confirmed] = true
      self[:confirmation_date] = DateTime.now
      return true
    end

    false
  end


end

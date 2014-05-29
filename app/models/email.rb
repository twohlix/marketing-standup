class Email < ActiveRecord::Base
  require 'digest/md5'

  after_initialize :default_values
  def default_values
    self.confirmed = false if self.confirmed.nil?
    self.confirmation_attempts = 0 if self.confirmation_attempts.nil?
  end

  validates :base_address, presence: true, uniqueness: { case_sensitive: false }
  validates :address, presence: true, uniqueness: { case_sensitive: false }
  

  validate :address_does_not_change, on: :update
  def address_does_not_change
    errors.add(:address, "cannot be changed once saved") if address_changed?||base_address_changed?
  end

  def address=(addy)
    self[:address] = addy.downcase

    # make this into our standard email with no spam tags
    # so we can compare example+marketing@domain.com with example@domain.com
    base = addy.downcase
    base.slice! /\+[a-z0-9_]*/
    self[:base_address] = base 
  end

  def send_confirmation
    return false unless persisted?

    md5 = Digest::MD5.new

    self[:confirmation_key] = md5.hexdigest "#{address}#{Time.now.usec.to_s}"
    self[:confirmation_attempts] += 1
    self[:confirmation_send_date] = DateTime.now
    return false if changes.count != 3
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
      save if changes.count == 2
      return true
    end

    false
  end
end

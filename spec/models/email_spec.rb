require 'spec_helper'

describe Email do
  context "new object" do
    before(:each) do
      @email = Email.new
      expect(@email.new_record?).to eq(true)
      expect(@email.persisted?).to eq(false)
    end

    it "requires an address" do
      expect(@email.respond_to? :address).to eq(true)
      expect(@email.valid?).to eq(false)
      
      @email.address = 'test@example.com'
      expect(@email.valid?).to eq(true)
    end

    it "lowercases all addresses" do
      upper_address = 'UpperCase@Example.com'
      @email.address = upper_address
      expect(@email.address).to eq(upper_address.downcase)
    end
  end

  context "persisted object" do
    before(:each) do
      @new_email = Email.new
    end

    it "is recallable" do
      @new_email.address = "warghawle@example.com"
      @new_email.save

      @recalled_email = Email.last
      expect(@recalled_email.address).to eq(@new_email.address)      
    end

    it "does not allow duplicate addresses" do
      @new_email.address = "test2@example.com"
      @new_email.save

      @newer_email = Email.new
      @newer_email.address = @new_email.address
      expect(@newer_email.save).to eq(false)
    end

    it "has lowercase addresses" do
      @new_email.address = "Upper@lowercaseme.com"
      @new_email.save
      
      @last_email = Email.last
      expect(@last_email.address).to eq(@last_email.address.downcase)
    end
  end
end

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

  context "confirmation" do
    before(:each) do
      @new_email = Email.new
      @new_email.address = 'confirm@example.com'
    end

    it "responds to confirmed?" do
      expect(@new_email.respond_to? :confirmed?).to eq(true)
    end

    it "has not been confirmed by default" do
      expect(@new_email.confirmed?).to eq(false)
    end

    describe "send_confirmation" do
      it "responds to send_confirmation" do
        expect(@new_email.respond_to? :send_confirmation).to eq(true)
      end

      it "has 0 confirmation attempts by default" do
        expect(@new_email.confirmation_attempts).to eq(0)
      end

      it "does not send confirmations if the object is not persisted" do
        expect(@new_email.persisted?).to eq(false)
        expect(@new_email.send_confirmation).to eq(false)
      end

      it "creates a confirmation key" do
        expect(@new_email.confirmation_key).to eq(nil)
        @new_email.save
        expect(@new_email.send_confirmation).to eq(true)
        expect(@new_email.confirmation_key).to_not eq(nil)
      end

      it "generates a new confirmation key every time" do
        @new_email.save
        @new_email.send_confirmation
        old_key = @new_email.confirmation_key
        @new_email.send_confirmation
        expect(@new_email.confirmation_key).to_not eq(old_key)
        expect(old_key).to_not eq(nil)
        expect(@new_email.confirmation_key).to_not eq(nil)
      end

      it "increases the confirmation attempts on success" do
        attempts = @new_email.confirmation_attempts
        expect(@new_email.send_confirmation).to eq(false)
        expect(@new_email.confirmation_attempts).to eq(attempts)
        @new_email.save
        expect(@new_email.send_confirmation).to eq(true)
        expect(@new_email.confirmation_attempts).to eq(attempts+1)
      end
    end

    describe "confirm" do
      it "responds to confirm" do
        expect(@new_email.respond_to? :confirm).to eq(true)
      end

      it "does not confirm if the object is not persisted" do
        expect(@new_email.persisted?).to eq(false)
        confirm_key = @new_email.confirmation_key
        expect(@new_email.confirm).to eq(false)
        expect(@new_email.confirm confirm_key).to eq(false)
      end

      it "does not confirm when given a nil/emtpy/blank key" do
        @new_email.save
        nil_key = nil
        empty_key = ''
        blank_key = '  '
        expect(@new_email.confirm).to eq(false)
        expect(@new_email.confirm nil_key).to eq(false)
        expect(@new_email.confirm empty_key).to eq(false)
        expect(@new_email.confirm blank_key).to eq(false)
      end

      it "does confirm when given the matching key" do
        @new_email.save
        @new_email.send_confirmation
        @new_email.save

        confirm_key = @new_email.confirmation_key
        expect(@new_email.confirmed?).to eq(false)
        expect(@new_email.confirm confirm_key).to eq(true)
        expect(@new_email.confirmed?).to eq(true)
      end
    end
  end
end

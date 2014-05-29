class HomeController < ApplicationController
  def index
    @email = Email.new
  end

  def confirm
  end

  def unsubscribe
  end

  def thanks
  end
end

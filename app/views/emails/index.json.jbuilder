json.array!(@emails) do |email|
  json.extract! email, :id, :address, :confirmed, :confirmation_key, :confirmation_send_date, :confirmation_date, :confirmation_attempts, :signup_date
  json.url email_url(email, format: :json)
end

json.extract! time_off, :id, :from_date, :to_date, :note, :user_id, :created_at, :updated_at
json.url time_off_url(time_off, format: :json)

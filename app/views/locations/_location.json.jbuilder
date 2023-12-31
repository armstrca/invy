# frozen_string_literal: true

json.extract!(location, :id, :name, :description, :address, :created_at, :updated_at)
json.url(location_url(location, format: :json))

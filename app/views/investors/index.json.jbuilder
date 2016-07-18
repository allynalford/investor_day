json.array!(@investors) do |investor|
  json.extract! investor, :id, :name
  json.url investor_url(investor, format: :json)
end

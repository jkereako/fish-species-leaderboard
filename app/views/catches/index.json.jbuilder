json.array!(@catches) do |catch|
  json.extract! catch, :id
  json.url catch_url(catch, format: :json)
end

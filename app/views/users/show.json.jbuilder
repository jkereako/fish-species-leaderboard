json.status :success
json.data do
  json.notice do
    json.title notice
  end
  json.user do
    json.modified user.updated_at
    json.is_active user.active?
  end
end

json.status :success
json.data do
  json.notice do
    json.title notice
  end
  json.competition do
    json.modified competition.updated_at
  end
end

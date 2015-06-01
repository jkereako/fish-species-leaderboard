json.status :success
json.data do

# Print a notice if it exists
  if notice
    json.notice do
      json.title notice
    end
  end
  json.competition do
    json.name competition.name
    json.begins competition.begins_at
    json.ends competition.ends_at
    json.prize competition.prize
    json.competitors competition.users do |user|
      json.name user.name
      json.catch_count user.catches_count
    end

  end
end

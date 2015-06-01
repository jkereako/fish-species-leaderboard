json.status :success
json.data do
  # Print a notice if it exists
  if notice
    json.notice do
      json.title notice
    end
  end
  json.species a_catch.species
  json.bait_used a_catch.bait_used
  json.date a_catch.caught_at
  json.location a_catch.location_description
  json.angler (User.find a_catch.user_id).name
  if a_catch.length_in_inches > 0
    json.length "#{a_catch.length_in_inches}\""
  end

end

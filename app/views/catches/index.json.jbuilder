json.status :success
json.data do
  json.array! @catches do |a_catch|
    json.species a_catch.species
    json.bait_used a_catch.bait_used
    json.date a_catch.caught_at
    json.location a_catch.location_description
    json.angler (User.find a_catch.user_id).name
    if a_catch.length_in_inches > 0
      json.length "#{a_catch.length_in_inches}\""
    end
    json.url catch_url(a_catch, format: :json)
  end
end

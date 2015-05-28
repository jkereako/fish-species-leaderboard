json.status :success
json.data do
  json.species @catch.species
  json.bait_used @catch.bait_used
  json.date @catch.caught_at
  json.location @catch.location_description
  json.angler (User.find @catch.user_id).name
  if @catch.length_in_inches > 0
    json.length "#{@catch.length_in_inches}\""
  end

end

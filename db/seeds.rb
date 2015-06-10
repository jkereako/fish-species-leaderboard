# Administrator
admin = User.new
admin.email = 'admin@developmentuser.com'
admin.name = 'Admin User'
admin.password = 'password'
admin.password_confirmation = 'password'
admin.role = User.administrator_role
admin.invitation_created_at = Time.zone.now
admin.invitation_sent_at = Time.zone.now
admin.invitation_accepted_at = Time.zone.now
admin.save

# User
user = User.new
user.email = 'user@developmentuser.com'
user.name = 'Regular user'
user.password = 'password'
user.password_confirmation = 'password'
user.role = User.user_role
user.invitation_created_at = Time.zone.now
user.invitation_sent_at = Time.zone.now
user.invitation_accepted_at = Time.zone.now
user.save

# 2014 competition
competition = Competition.new
competition.name = '2014 Fish Species Contest'
competition.begins_at = Time.zone.parse '2014-01-01'
competition.ends_at = Time.zone.parse '2014-12-31'
competition.prize = 'Loser pays winner $50 plus $5 for each unique catch of the winner.'
competition.has_expired = true
competition.users = [admin, user]
competition.winner = admin
competition.save(validate: false)

# 2015 competition
competition = Competition.new
competition.name = '2015 Fish Species Contest'
competition.begins_at = Time.zone.parse '2015-01-01'
competition.ends_at = Time.zone.parse '2015-12-31'
competition.prize = 'Loser pays winner $50 plus $5 for each unique catch of the winner.'
competition.users = [admin, user]
competition.save(validate: false)

#-- Admin catches
Catch.create(species: 'Blue Gill',
             user: admin, competition: competition,
             caught_at: Time.zone.parse('2015-04-23'),
             bait_used: 'Live worm',
             location_description: 'Rock Pond',
             image: File.open('Blue Gill - 4-23-15.JPG'))

Catch.create(species: 'Brook Trout',
             user: admin, competition: competition,
             caught_at: Time.zone.parse('2015-05-20'),
             bait_used: 'Tiger rooster tail',
             location_description: 'Off shoot of Parker River',
             image: File.open('Brook Trout - 5-20-2015.JPG'))

Catch.create(species: 'Chain Pickerel',
             user: admin, competition: competition,
             caught_at: Time.zone.parse('2015-04-25'),
             bait_used: 'Minnow spoon',
             location_description: 'Lake Attitash',
             image: File.open('Blue Gill - 4-23-15.JPG'))

Catch.create(species: 'Lamprey',
             user: admin, competition: competition,
             caught_at: Time.zone.parse('2015-05-22'),
             bait_used: 'Net',
             location_description: 'Parker River',
             image: File.open('Lamprey - 5-22-2015.JPG'))

Catch.create(species: 'Largemouth Bass',
             user: admin, competition: competition,
             caught_at: Time.zone.parse('2015-04-25'),
             bait_used: 'Minnow spoon',
             location_description: 'Lake Attitash',
             image: File.open('Large Mouth - 4-25-15.JPG'))

Catch.create(species: 'Pumpkin Seed',
             user: admin, competition: competition,
             caught_at: Time.zone.parse('2015-04-23'),
             bait_used: 'Live worm',
             location_description: 'Rock Pond',
             image: File.open('Blue Gill - 4-23-15.JPG'))

Catch.create(species: 'Rainbow Trout',
             user: admin, competition: competition,
             caught_at: Time.zone.parse('2015-05-20'),
             bait_used: 'Tiger rooster tail',
             location_description: 'Off shoot of Parker River',
             image: File.open('Rainbow Trout - 5-20-2015.JPG'))

Catch.create(species: 'Redfin Pickerel',
             user: admin, competition: competition,
             caught_at: Time.zone.parse('2015-05-18'),
             bait_used: 'Minnow spoon',
             location_description: 'Wheeler Brook',
             image: File.open('Blue Gill - 4-23-15.JPG'))

Catch.create(species: 'Redeye Bass',
             user: admin, competition: competition,
             caught_at: Time.zone.parse('2015-04-18'),
             bait_used: 'White rooster tail',
             location_description: 'Chattanooga River',
             image: File.open('Blue Gill - 4-23-15.JPG'))

Catch.create(species: 'Rock Bass',
             user: admin, competition: competition,
             caught_at: Time.zone.parse('2015-05-15'),
             bait_used: 'Live worm',
             location_description: 'Wachusett River',
             image: File.open('Rock Bass - 5-15-2015.JPG'))

Catch.create(species: 'Smallmouth Bass',
             user: admin, competition: competition,
             caught_at: Time.zone.parse('2015-05-15'),
             bait_used: 'Minnow spoon',
             location_description: 'Wachusett River',
             image: File.open('Small Mouth 2 - 5-15-2015.JPG'))

# This is the only catch that's saving: why?
Catch.create(species: 'White Perch',
             user: admin, competition: competition,
             caught_at: Time.zone.parse('2015-05-23'),
             bait_used: 'Rainbow rooster tail',
             location_description: 'Trawling Lake Attitash',
             image: File.open('White Perch - 5-23-2015.jpg'))

Catch.create(species: 'Yellow Perch',
             user: admin, competition: competition,
             caught_at: Time.zone.parse('2015-05-15'),
             bait_used: 'Live worm',
             location_description: 'Wachusett Reservoir',
             image: File.open('Yellow Perch - 5-15-2015.JPG'))

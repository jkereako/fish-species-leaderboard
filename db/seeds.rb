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

# User 1
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

# User 2
user2 = User.new
user2.email = 'user2@developmentuser.com'
user2.name = 'Regular user 2'
user2.password = 'password'
user2.password_confirmation = 'password'
user2.role = User.user_role
user2.invitation_created_at = Time.zone.now
user2.invitation_sent_at = Time.zone.now
user2.invitation_accepted_at = Time.zone.now
user2.save

# 2014 competition
competition = Competition.new
competition.name = '2014 Fish Species Contest'
competition.begins_at = Time.zone.parse '2014-01-01'
competition.ends_at = Time.zone.parse '2014-12-31'
competition.prize = 'Loser pays winner $50 plus $5 for each unique catch of the winner.'
competition.bonus = 'Big fish'
competition.has_expired = true
competition.users = [user, user2]
competition.winner = admin
competition.save(validate: false)

#-- 2014 competition
#---- First user
Catch.new(species: 'Smallmouth Bass',
          user: user, competition: competition,
          caught_at: Time.zone.parse('2014-07-26')).save(validate: false)

Catch.new(species: 'Largemouth Bass',
          user: user, competition: competition,
          caught_at: Time.zone.parse('2014-05-26')).save(validate: false)

Catch.new(species: 'Striped Bass',
          user: user, competition: competition,
          caught_at: Time.zone.parse('2014-08-06')).save(validate: false)

Catch.new(species: 'Brown Trout',
          user: user, competition: competition,
          caught_at: Time.zone.parse('2014-08-16')).save(validate: false)

Catch.new(species: 'Blue Gill',
          user: user, competition: competition,
          caught_at: Time.zone.parse('2014-05-26')).save(validate: false)

Catch.new(species: 'Black Crappie',
          user: user, competition: competition,
          caught_at: Time.zone.parse('2014-05-26')).save(validate: false)

Catch.new(species: 'Chubsucker',
          user: user, competition: competition,
          caught_at: Time.zone.parse('2014-08-16')).save(validate: false)
#---- Second user
Catch.new(species: 'Largemouth Bass',
          user: user2, competition: competition,
          caught_at: Time.zone.parse('2014-06-04')).save(validate: false)

Catch.new(species: 'White Bass',
          user: user2, competition: competition,
          caught_at: Time.zone.parse('2014-07-25')).save(validate: false)

Catch.new(species: 'Rainbow Trout',
          user: user2, competition: competition,
          caught_at: Time.zone.parse('2014-12-31')).save(validate: false)

Catch.new(species: 'Blue Gill',
          user: user2, competition: competition,
          caught_at: Time.zone.parse('2014-05-21')).save(validate: false)

Catch.new(species: 'Black Crappie',
          user: user2, competition: competition,
          caught_at: Time.zone.parse('2014-05-21')).save(validate: false)

Catch.new(species: 'Yellow Perch',
          user: user2, competition: competition,
          caught_at: Time.zone.parse('2014-06-04')).save(validate: false)

Catch.new(species: 'Channel Catfish',
          user: user2, competition: competition,
          caught_at: Time.zone.parse('2014-08-24')).save(validate: false)

Catch.new(species: 'Grass Carp',
          user: user2, competition: competition,
          caught_at: Time.zone.parse('2014-08-14')).save(validate: false)

# 2015 competition
competition = Competition.new
competition.name = '2015 Fish Species Contest'
competition.begins_at = Time.zone.parse '2015-01-01'
competition.ends_at = Time.zone.parse '2015-12-31'
competition.prize = 'Loser pays winner $50 plus $5 for each unique catch of the winner.'
competition.users = [user, user2]
competition.save(validate: false)

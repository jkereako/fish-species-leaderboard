# Administrator
user = User.new
user.email = 'admin@developmentuser.com'
user.password = 'password'
user.password_confirmation = 'password'
user.role = 'administrator'
user.name = 'Big cheese'
user.save!

# Regular user
user = User.new
user.email = 'user@developmentuser.com'
user.password = 'password'
user.password_confirmation = 'password'
user.role = 'user'
user.name = 'Regular user'
user.save!

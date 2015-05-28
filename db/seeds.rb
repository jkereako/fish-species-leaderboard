# Administrator
user = User.new
user.email = 'admin@developmentuser.com'
user.name = 'Admin User'
user.password = 'password'
user.password_confirmation = 'password'
user.role = User.administrator_role
user.invitation_created_at = Time.zone.now
user.invitation_sent_at = Time.zone.now
user.invitation_accepted_at = Time.zone.now
user.save

# Regular user
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

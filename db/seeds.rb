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

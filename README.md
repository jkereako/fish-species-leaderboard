# Fish species leaderboard
Provides a way to friends to compete with one another.

# Usage
What you can do in the app depends on your account's level of access.

### Administrators
Administrators may invite users, create competitions, delete competitions and
suspend users. Administrators cannot edit the details of a user's account which
includes changing a user's password.

### Users
Users may only add catches. Once a catch is added, it cannot be edited nor
deleted.

## User management
The gem, Devise, handles all of the user management. It is, in my opinion, the
standard for user management.

## Policy management
Every user (or in this context, "competitor") of this app has the role "user".
Administrators, likewise, have the role "administrators". Roles are recorded as
an attribute of the `User` model.

The polices which govern what each role can do in the app is defined in code
with the gem, [Pundit](https://github.com/elabs/pundit). As the app evolves, the
polices will change and doing so will not require a database migration.

# About
This app, although functional, is really an on-going academic exercise. It shows
how to use Devise and Pundit together to manage users and their authorizations.
This project also includes over 150 tests written for RSpec.

Assets are handled using Bower. This was decided in lieu

This app is intended for Heroku, hence the `Procfile`.

# License
MIT

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

# Species
This app maintains a list of species. The list grew from past catches, so, not
every species of fish is represented. The list is static  because it is look-up
data and it does not often change. Future versions of this app may localize the
species list by region.

The class which manages the species list is a regular Ruby class with
`ActiveModel` mixins.

# About
Although a functional app, this project is actually an academic exercise. It
provides example usage of the gems Devise and Pundit, of a has-many through
relationship, of ActiveModel usage, of Bower usage, of RSpec test cases and of
deployment to Heroku.

# License
MIT

class Membership < ActiveRecord::Base
  belongs_to :user, inverse_of: 'memberships', counter_cache: true
  belongs_to :competition, inverse_of: 'memberships', counter_cache: true
end

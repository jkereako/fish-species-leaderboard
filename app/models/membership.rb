class Membership < ActiveRecord::Base
  belongs_to :user, inverse_of: 'memberships'
  belongs_to :competition, inverse_of: 'memberships'
end

class Competition < ActiveRecord::Base
  has_many :users
  has_one :user, foreign_key: 'winner_id'
end

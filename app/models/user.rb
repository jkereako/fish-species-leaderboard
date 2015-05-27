class User < ActiveRecord::Base
  scope :administrators, -> { where role: 'administrator' }
  scope :users, -> { where role: 'user' }
  scope :active, -> { where is_active: true }
  scope :leaders, -> { order 'catches_count DESC' }

  ROLES = %w(administrator user)

  has_many :memberships
  has_many :competitions, through: 'memberships'

  has_one :victory, inverse_of: 'winner', class_name: 'Competition'
  has_many :catches, inverse_of: 'user'

  validates :role, inclusion: { in: ROLES,
                                message: "%{value} is an invalid role type" }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :recoverable,
         :rememberable, :trackable, :validatable

  # Overidden
  def to_param
    "#{id} #{name}".parameterize
  end

  def admin?
    role == ROLES.first
  end
end

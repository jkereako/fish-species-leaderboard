class User < ActiveRecord::Base
  scope :administrators, -> { where role: 'administrator' }
  scope :users, -> { where role: 'user' }
  scope :active, -> { where is_active: true }
  scope :leaders, -> { order 'catches_count DESC' }

  ROLES = %w(administrator user)

  has_many :memberships, inverse_of: 'user'
  has_many :competitions, through: 'memberships'

  has_one :victory, inverse_of: 'winner', class_name: 'Competition'
  has_many :catches, inverse_of: 'user'

  validates :name, presence: true
  validates :role, inclusion: { in: ROLES }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :recoverable,
         :rememberable, :trackable, :validatable

  # Class methods
  def self.roles
    ROLES
  end

  def self.administrator_role
    ROLES.first
  end

  def self.user_role
    ROLES.last
  end

  #-- ActiveRecord override
  def to_param
    "#{id} #{name}".parameterize
  end

  #-- Devise override
  def active_for_authentication?
    super && is_active
  end

  def inactive_message
    is_active ? super : 'Your account has been suspended.'
  end

  def inivited?
    invitation_token.present?
  end

  # Helpers
  def admin?
    role == ROLES.first
  end

  def active?
    is_active
  end

  def suspended?
    !is_active
  end

end

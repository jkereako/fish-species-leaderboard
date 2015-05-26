class User < ActiveRecord::Base
  scope :administrators, -> { where(role: 'administrator') }
  scope :users, -> { where(role: 'user') }

  # constants come up next
  ROLES = %w(administrator user)

  has_and_belongs_to_many :competitions, inverse_of: 'competitors'
  has_one :victory, inverse_of: 'winner', class_name: 'Competition'
  has_many :catches, inverse_of: 'user'

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :recoverable,
         :rememberable, :trackable, :validatable

  def admin?
    role == ROLES.first
  end
end

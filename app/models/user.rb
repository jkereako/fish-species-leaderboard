class User < ActiveRecord::Base
  has_and_belongs_to_many :competitions, inverse_of: 'competitors'
  has_one :victory, inverse_of: 'winner', class_name: 'Competition'
  has_many :catches, inverse_of: 'user'

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :recoverable,
         :rememberable, :trackable, :validatable
end

class User < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :catches

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :recoverable,
         :rememberable, :trackable, :validatable
end

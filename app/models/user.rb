class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :events
  has_many :opportunities

  ROLES = ['admin', 'editor', 'user']

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :role, presence: true, inclusion: { in: ROLES, message: '%{value} is not a valid role' }

  # set role to user if blank
  before_validation do |user|
    user.role ||= 'user'
  end

  # Attributes:
  # email:                   string
  # first_name:              string
  # last_name:               string
  # role:                    string
  # created_at, updated_at:  datetime

  def admin?
    role == 'admin'
  end

  def editor?
    role == 'editor'
  end

  def user?
    role == 'user'
  end
end

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :email, :password, :user_name, :first_name, :last_name, :admin
  validates_uniqueness_of :email, :user_name
  
  has_many :projects
  has_many :partnerships, through: :projects
  has_many :feedbacks, through: :projects

  has_many :connections
end
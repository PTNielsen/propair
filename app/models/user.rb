class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :omniauthable, :omniauth_providers => [:slack]

  validates_presence_of :email
  validates_uniqueness_of :email
  
  has_many :projects, class_name: "Project", foreign_key: :author_id
  has_many :feedbacks, class_name: "Feedback", foreign_key: :author_id
  
  has_many :partnerships
  has_many :connections
  has_many :auth_tokens
end
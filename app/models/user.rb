class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :omniauthable, :omniauth_providers => [:slack]

  validates :email, presence: true, uniqueness: true
  
  has_many :projects, class_name: "Project", foreign_key: :author_id
  has_many :feedbacks, class_name: "Feedback", foreign_key: :author_id
  has_many :requests, class_name: "Request", foreign_key: :requestor_id
  
  has_many :partnerships
  has_many :connections
  has_many :auth_tokens

  def self.slack_ids_hash
    # Slick way to handle the uncommented below
    # User.all.each_with_object({}) do |user, hash|
    #   hash[user.slack["uid"]] = user
    # end

    slack_ids = {}
    
    User.all.each do |user|
      slack_ids[user.slack["uid"]] = user
    end
    slack_ids
  end
end
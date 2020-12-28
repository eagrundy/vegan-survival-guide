class User < ActiveRecord::Base
    has_many :restaurants

    validates :name, :email, :bio, presence: true
    validates :email, uniqueness: true
    
    has_secure_password
end
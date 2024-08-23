class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_many :memberships 
         has_many :organizations, through: :memberships
         has_many :posts, dependent: :destroy
         has_one :profile, dependent: :destroy
         has_many :comments, dependent: :destroy
end

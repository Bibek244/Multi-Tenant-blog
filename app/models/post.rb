class Post < ApplicationRecord
  belongs_to :user
  belongs_to :organization
  has_many :comments, dependent: :destroy
end

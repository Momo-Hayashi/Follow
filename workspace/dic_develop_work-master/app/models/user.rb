class User < ApplicationRecord
  has_secure_password
  before_validation { email.downcase! }

  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, presence: true, length: { minimum: 6 }

  # has_many :relationships でなく、それぞれを区別するための別の名前でアソシエーションを定義する必要がある
  # class_name: 'Relationship'を忘れないように！
  has_many :active_relationships, foreign_key: 'follower_id', class_name: 'Relationship', dependent: :destroy
  has_many :passive_relationships, foreign_key: 'followed_id', class_name: 'Relationship', dependent: :destroy

  # follower has many following...
  has_many :following, through: :active_relationships, source: :followed
  # followed has many followerd...
  has_many :followers, through: :passive_relationships, source: :follower
end

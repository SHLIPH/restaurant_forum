class User < ApplicationRecord
  has_many :comments
  has_many :restaurants, through: :comments
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :name

  mount_uploader :avatar, PhotoUploader

  # 「使用者收藏很多餐廳」的多對多關聯
  has_many :favorites, dependent: :destroy
  has_many :favorited_restaurants, through: :favorites, source: :restaurant

  has_many :likes, dependent: :destroy
  has_many :liked_restaurants, through: :likes, source: :restaurant

  has_many :followships, dependent: :destroy
  has_many :followings, through: :followships

  has_many :inverse_followships, class_name: "Followship", foreign_key: "following_id"
  has_many :followers, through: :inverse_followships, source: :user

  has_many :friendships, dependent: :destroy
  has_many :friendings, through: :friendships

  has_many :inverse_friends, class_name: "Friendship", foreign_key: "friending_id"
  has_many :friends, through: :inverse_friends, source: :user

  def admin?
    self.role == "admin"
  end

  def like?(restaurant)
    self.liked_restaurants.include?(restaurant)
  end

  def following?(user)
    self.followings.include?(user)
  end

  def friending?(user)
    self.friendings.include?(user)
  end

  def all_friends
    @friends = self.inverse_friends
    @friends << self.friends
    @friends = @friends.uniq
    return @friends
  end
end

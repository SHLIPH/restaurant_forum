class Friendship < ApplicationRecord
  validates :friending_id, uniqueness: { scope: :user_id }
  belongs_to :user
  belongs_to :friending, class_name: "User"
end

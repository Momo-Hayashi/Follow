class Relationship < ApplicationRecord
  # 本来belongs_to :userとすべきだが、名前を変えてアソシエーションを定義
  belongs_to :followed, class_name: "User"
  belongs_to :follower, class_name: "User"
end

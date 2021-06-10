class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image, destroy: false

  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction, length: {maximum: 50}
  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  has_many :group_users
  has_many :groups, through: :group_users


# active
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
# フォローしている人の一覧を取り出す followingメソッドを使えるように定義している
  has_many :followings, through: :relationships, source: :followed

# passive
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
# フォロワー一覧を取り出すため
  has_many :followers, through: :reverse_of_relationships, source: :follower

# グループ機能
  has_many :group_users
  
  # DM機能
  has_many :user_rooms, dependent: :destroy
  has_many :chats, dependent: :destroy

#ユーザーをフォローする
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

#ユーザーをフォロー解除する
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

#現在のユーザーがフォローしてたらtrueを返す
  def following?(user)
    followings.include?(user)
  end
  
  
  
end

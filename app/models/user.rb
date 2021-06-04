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
  
  
# active 
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
# passive
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  
# フォローしている人の一覧を取り出す followingメソッドを使えるように定義している
  has_many :following, through: :active_relationships, source: :followed
# フォロワー一覧を取り出すため
  has_many :followers, through: :passive_relationships, source: :follower
  
#ユーザーをフォローする
  def follow(other_user)
    following << other_user
  end
  
#ユーザーをフォロー解除する
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end
  
#現在のユーザーがフォローしてたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end
  
  
end

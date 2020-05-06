class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,:validatable

  has_many :books, dependent: :destroy
  attachment :profile_image, destroy: false
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_books, through: :favorites, source: :book 
  def already_favorited?(book)
    self.favorites.exists?(book_id: book.id)
  end
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  #foregin_key = 入口　、source = 出口
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationships, source: :user
  
  def follow(other_user)#自分自身ではないか？
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
      #フォローが重複するのを防ぐ
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
    #relationshipが存在すればdestroy
  end

  def following?(other_user)
    self.followings.include?(other_user)
    #フォローしているユーザーたちを取得
  end

  def User.search(search, user_or_book)
    if user_or_book == "1"
       User.where(['name LIKE ?', "%#{search}%"])
    else
       User.all
    end
end

  #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
  validates :name, presence: true, length: {maximum: 20, minimum: 2}
  validates :introduction, length: { maximum: 50 }
end

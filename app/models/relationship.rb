class Relationship < ApplicationRecord
  belongs_to :user
  
  #class_name: ‘User’ と補足設定することで、
  #Followクラスという存在しないクラスを参照することを防ぎ、User クラスであることを明示
  belongs_to :follow, class_name: 'User'

  validates :user_id, presence: true
  validates :follow_id, presence: true
end

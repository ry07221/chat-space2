class Group < ApplicationRecord
  has_many :group_users
  has_many :users, through: :group_users
  has_many :messages
  validates :name, presence: true



#モデルにインスタンスメソッドを定義→viewファイルにif文などを書かずに済む

  def show_last_message
    if (last_message = messages.last).present?
      last_message.content? ? last_message.content : ''   #条件式 ? trueの時の値 : falseの時の値
    else
      'still be not messages here'
    end
  end
end


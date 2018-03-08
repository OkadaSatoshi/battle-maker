class Battle < ApplicationRecord
  belongs_to :user
  has_many :participant_managements, dependent: :destroy
  has_many :users, through: :participant_managements
  has_many :comments, dependent: :destroy
  
  #length: { in 1..適当な数字}とpresenceは併用すべき？
  validates :title, length: { in: 1..50 }
  validate :battle_date_cannot_be_in_the_past
  validates :place, length: { maximum: 200 }
  validates :content, length: { maximum: 1000 }
    
  def battle_date_cannot_be_in_the_past
    if battle_date.present? && battle_date < DateTime.now
      errors.add(:battle_date, "は現在以降の日時を入力してください。") 
    end
  end
  
  def self.fetch_random_row_battles(want)
    battles = Battle.where("battle_date >= ?", DateTime.now)
    slice_battles = battles.shuffle.slice(0..want-1)
    slice_battles.sort! do |a,b|
      a[:battle_date] <=> b[:battle_date]
    end
    random_battles = slice_battles.reverse
    return random_battles
  end
end

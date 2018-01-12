class Item < ApplicationRecord
  has_many :orders
  has_many :members, through: :orders
  has_one :mantenimiento
  belongs_to :category
  belongs_to :marca
  belongs_to :modelo

  #validates :name, presence: true
  validates :category, presence: true
end

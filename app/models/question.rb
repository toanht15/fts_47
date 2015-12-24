class Question < ActiveRecord::Base
  belongs_to :category
  has_many :answers, dependent: :destroy

  accepts_nested_attributes_for :answers

  validates :content, presence: true
end

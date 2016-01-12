class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :exams
  has_many :questions, dependent: :destroy
  has_many :categories, through: :exams
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
end

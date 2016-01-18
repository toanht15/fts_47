class Category < ActiveRecord::Base
  require "csv"
  has_many :exams, dependent: :destroy
  has_many :questions, dependent: :destroy
  validates :name, presence: true, length: {maximum: 50}, uniqueness: true

  class << self
    def to_csv options = {}
      CSV.generate options do |csv|
        csv << column_names
        all.each do |category|
          csv << category.attributes.values_at(*column_names)
        end
      end
    end
  end
end

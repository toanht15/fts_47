class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged
  TEMP_EMAIL_PREFIX = "change@me"
  TEMP_EMAIL_REGEX = /\Achange@me/
  has_many :exams
  has_many :questions, dependent: :destroy
  has_many :categories, through: :exams
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable, :omniauthable

  validates_format_of :email, without: TEMP_EMAIL_REGEX, on: :update
  validates :name, presence: true, length: {maximum: 100}
  class << self
    def find_for_oauth auth, current_user = nil
      identity = Identity.find_for_oauth auth
      user = current_user ? current_user : identity.user
      if user.nil?
        email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
        email = email_is_verified ? auth.info.email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com"
        user = User.find_by(email: email) if email
        user = create_user auth.extra.raw_info.name, email if user.nil?
      end
      identity.save! user if identity.user != user
      user
    end

    def create_user name, email
      user = User.create!(name: name, email: email, password: Devise.friendly_token[0,20])
    end
  end

  def email_verified?
    email && email !~ TEMP_EMAIL_REGEX
  end
end

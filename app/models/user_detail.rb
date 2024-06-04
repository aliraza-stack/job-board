class UserDetail < ApplicationRecord
  belongs_to :user

  enum gender: { male: 'male', female: 'female' }
  validates :first_name, :last_name, :phone_number, :birthday, :gender, :profession, :bio, presence: true
  validates :phone_number, format: { with: /\A\+?\d{10,14}\z/, message: 'must be a valid phone number' }
  validates :website, format: { with: URI::DEFAULT_PARSER.make_regexp, message: 'must be a valid url' }

end

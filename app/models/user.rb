class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :confirmable,
         :lockable,
         :trackable

  has_one :user_detail, dependent: :destroy
  has_one :address, dependent: :destroy

  accepts_nested_attributes_for :user_detail
  accepts_nested_attributes_for :address

  has_one_attached :avatar

  enum role: { admin: 'admin', employer: 'employer', freelancer: 'freelancer' }
  DETAIL_ATTRIBUTES = %w[first_name last_name phone_number birthday gender profession bio].freeze

  validates :role, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 8 }, on: :create

  def admin?
    role == 'admin'
  end

  def employer?
    role == 'employer'
  end

  def freelancer?
    role == 'freelancer'
  end

  def profile_complete?
    user_detail? && address?
  end

  def user_detail?
    DETAIL_ATTRIBUTES.all? { |attr| user_detail.send(attr).present? }
  end

  def address?
    address&.city.present? && address&.state.present? && address&.country.present? && address&.zip_code.present?
  end

end

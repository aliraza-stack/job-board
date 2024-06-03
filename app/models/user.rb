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

  validates :role, presence: true

  def admin?
    role == 'admin'
  end

  def employer?
    role == 'employer'
  end

  def freelancer?
    role == 'freelancer'
  end

end

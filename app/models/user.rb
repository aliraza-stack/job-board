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

  enum role: { admin: 'admin', employer: 'employer', freelancer: 'freelancer' }
  has_one_attached :avatar

  validates :role, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :profession, presence: true
  validates :bio, presence: true
  validates :avatar, presence: true

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

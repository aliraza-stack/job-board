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

class User < ApplicationRecord
  PASSWORD_FORMAT = /(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])/

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable,
         :confirmable, omniauth_providers: %i[facebook]

  validates :email, presence: true
  validates :password, format: { with: PASSWORD_FORMAT }, if: :password_required?

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.skip_confirmation!
    end
  end
end

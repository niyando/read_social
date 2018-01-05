class User < ActiveRecord::Base

  validates_presence_of :uid, :token, :token_secret
  validates_uniqueness_of :uid

  def self.from_omniauth(auth)
    where(uid: auth[:uid]).first_or_create do |user|
      user.uid           = auth[:uid]
      user.token         = auth[:token]
      user.token_secret  = auth[:token_secret]
      user.save
    end
  end

end

class User < ApplicationRecord
    has_many :wants
    has_many :records, through: :wants
    has_many :findings, through: :records
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable,
    :omniauthable, omniauth_providers: [:discogs]

  def index
  end

  def findings?
    findings = []
    self.records.each do |record|
      record.findings
    end
  end

  def self.find_for_discogs_oauth(auth)
    user_params = auth.info.slice(:username, :picture)
    user_params.merge! auth.credentials.slice(:token)
    user_params[:provider] = auth.provider
    user_params[:discogs_id] = auth.uid
    user_params[:email] = auth.info.username + '@digdog.com'
    user_params = user_params.to_h
    user = User.find_by(provider: auth.provider, discogs_id: auth.uid)
    user ||= User.find_by(email: user_params["email"]) # User did a regular sign up in the past.
    # binding.pry
    if user
      user.update(user_params)
    else
      user = User.new(user_params)
      user.password = Devise.friendly_token[0,20]  # Fake password for validation
      user.save!
    end
    return user
  end

end

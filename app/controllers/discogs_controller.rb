class DiscogsController < ApplicationController
  before_action :set_client

  def authenticate
    app_key      = ENV["DISCOGS_API_KEY"]
    app_secret   = ENV["DISCOGS_API_SECRET"]
    request_data = @discogs.get_request_token(app_key, app_secret, "http://localhost:3000/discogs/callback")
    session[:request_token] = request_data[:request_token]

    redirect_to request_data[:authorize_url]
  end

  def callback
    if session[:request_token].is_a? OAuth::RequestToken
      request_token = session[:request_token]
    else
      consumer      = OAuth::Consumer.new(session[:request_token]["consumer"]["key"], session[:request_token]["consumer"]["secret"], site: session[:request_token]["consumer"]["site"])
      request_token = OAuth::RequestToken.from_hash(consumer, { oauth_token: session[:request_token]["token"], oauth_token_secret: session[:request_token]["secret"]})
    end

    verifier        = params[:oauth_verifier]
    access_token    = @discogs.authenticate(request_token, verifier)

    session[:request_token] = nil
    session[:access_token]  = access_token

    redirect_to root_path
  end

  def index
  end

  def wants

    #1 Call à l'api

    @user     = @discogs.get_identity
    @response = @discogs.get_user_wantlist(@user.username)

    #2 Pour chaque item de l'api, créer un Record (Record.new), mais
    # ne pas le persister en base (pas de save/create)

    #3 -> return array de records

  end


  def show
    image = @discogs.get_image(params[:id])

    send_data(image,
              :disposition => "inline",
              :type => "image/jpeg")
  end

  def whoami
    @user = @discogs.get_identity
  end

  private

  def set_client
    @discogs = Discogs::Wrapper.new("OAuth", session[:access_token])
  end

  # def add_want
  #   release_id = "2489281"

  #   @user     = @discogs.get_identity
  #   @response = @discogs.add_release_to_user_wantlist(@user.username, release_id)
  # end

  # def edit_want
  #   release_id = "2489281"
  #   notes      = "Added via the Discogs Ruby Gem. But, you *DO* want it now!!"
  #   rating     = 5

  #   @user     = @discogs.get_identity
  #   @response = @discogs.edit_release_in_user_wantlist(@user.username,
  #                                                      release_id,
  #                                                      {:notes => notes, :rating => rating})
  # end

  # def remove_want
  #   release_id = "2489281"

  #   @user     = @discogs.get_identity
  #   @response = @discogs.delete_release_from_user_wantlist(@user.username, release_id)
  # end
end

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def discogs
    user = User.find_for_discogs_oauth(request.env['omniauth.auth'])

    if user.persisted?
      session[:access_token] = request.env['omniauth.auth'].extra.access_token
      sign_in_and_redirect user, event: :authentication
      set_flash_message(:notice, :success, kind: 'Discogs') if is_navigational_format?
    else
      session['devise.discogs_data'] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end
end
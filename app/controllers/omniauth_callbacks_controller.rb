class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  require "uri"
  require "net/http"

  def facebook
    if !fb_postable?(request.env["omniauth.auth"].credentials.token)
      failure
    else
      @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)

      if @user.persisted?
        flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
        sign_in_and_redirect @user, :event => :authentication
      else
        session["devise.facebook_data"] = request.env["omniauth.auth"]
        redirect_to new_user_registration_url
      end
    end
  end

  def handle_post
    if params[:question]
      new_question_path
    end
  end

  def failure
    flash[:notice] = "> Sorry we could not obtain permission from Facebook to authorize you"
    redirect_to root_path
  end
end
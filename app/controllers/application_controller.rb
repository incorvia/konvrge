class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  def fb_postable?(token)
    @graph = Koala::Facebook::API.new(token) 
    permissions = @graph.get_connections('me', 'permissions')

    permissions[0]["status_update"] == 1 ? true : false
  end

  def post_to_facebook(item_path, redirect_to_link, options)
    if current_user.post_permission == true
      @graph = Koala::Facebook::API.new(current_user.token) 

      begin
        @graph.put_object("me", "feed", options) 
        redirect_to redirect_to_link
      rescue
        redirect_to redirect_to_link
      end
    else
      redirect_to redirect_to_link
    end
  end
end

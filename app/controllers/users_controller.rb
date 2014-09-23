class UsersController < ApplicationController
  before_filter :set_access_control_headers, only: :present

  def present
    @users = Arp.present_users
  end

  def present_embeddable
    @users = Arp.present_users
    response.headers.delete "X-Frame-Options"
    render layout: 'embeddable'
  end

  private
    def set_access_control_headers
      response.headers['Access-Control-Allow-Origin'] = '*'
      response.headers['Access-Control-Request-Method'] = '*'
    end
end

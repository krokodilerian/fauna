class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up).push(*[:name, :username, :email])
    devise_parameter_sanitizer.for(:sign_in).push(*[:username])
    devise_parameter_sanitizer.for(:account_update).push(*[:name, :username,
                                                           :email, :url,
                                                           :twitter, :privacy,
                                                           :github, :jabber,
                                                           :gpg_fingerprint,
                                                           :pin, :pin_confirmation,
                                                           phone_numbers_attributes: [
                                                             :_destroy,
                                                             :id,
                                                             :phone_number
                                                           ]])
  end

  def current_ip_address
    request.env['HTTP_X_FORWARDED_FOR'] || request.remote_ip
  end

  def current_mac_address
    Arp.mac_by_ip_address(current_ip_address)
  end
end

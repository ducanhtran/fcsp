class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :rack_mini_profiler_authorize_request

  include ApplicationHelper

  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = exception.message
    redirect_to root_path
  end

  private
  def rack_mini_profiler_authorize_request
    environments = Rails.application.config.rack_mini_profiler_environments
    return unless Rails.env.in? environments
    Rack::MiniProfiler.authorize_request
  end

  def after_sign_out_path_for _resource
    root_path
  end
end

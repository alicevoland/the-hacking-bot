class ApplicationController < ActionController::Base
  layout :layout_by_resource
  before_action :set_locale

  private

  def layout_by_resource
    if devise_controller?
      'devise'
    else
      'application'
    end
  end

  def set_locale
    puts I18n.locale
  end
end

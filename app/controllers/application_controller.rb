class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action :authenticate_user!, only: %i[all]
  before_action :set_current_user

  private

  def set_current_user
    Current.user = current_user
  end
end

# frozen_string_literal: true

# /workspaces/Inventory-Management-System/app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  include Pundit::Authorization
  helper ApplicationHelper
  before_action :authenticate_user!
  after_action :verify_authorized, except: [:index, :new], unless: :devise_controller?
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end
end

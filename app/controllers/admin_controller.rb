class AdminController < ActionController::Base
  include ApplicationHelper
  protect_from_forgery with: :exception
  layout 'admin'
end

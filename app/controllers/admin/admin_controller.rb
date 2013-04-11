class Admin::AdminController < Admin::ApplicationController
  layout 'admin'
  before_filter :authenticate_admin!

  def dashboard
  end
end

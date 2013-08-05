class Admin::AdminController < Admin::ApplicationController
  layout 'admin'
  before_filter :authenticate_admin!

  def dashboard
    @activities = PublicActivity::Activity.order('created_at DESC').limit(20)
  end
end

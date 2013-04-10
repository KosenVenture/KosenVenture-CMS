class AdminController < ApplicationController
  layout 'admin'
  before_filter :authenticate_admin!

  def dashboard
  end
end

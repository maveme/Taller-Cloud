class WelcomeController < ApplicationController
  #before_filter :authenticate_admin!
  def index
    @admin= Admin.find_by_pymeName(params[:id])
    @creditLines=@admin.credit_lines
    @payment_plan = @admin.payment_plans.new
  end
end

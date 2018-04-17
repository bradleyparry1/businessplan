class DashboardController < ApplicationController
  def view
    @actuals = Actual.all
  end

  def get_teams()
    if params[:group] == "All"
      @teams = Team.all
    else
      @teams = Group.find_by_name(params[:group]).teams
    end
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js {render json: @teams}
    end
  end
end

def summary
end

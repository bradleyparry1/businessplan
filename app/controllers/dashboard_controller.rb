class DashboardController < ApplicationController
  include DashboardHelper
  def view
    @cumulative = params[:cum_filter] == "No" ? false : true

    @actual_months = Actual.maximum("month")

    team_ids = get_team_ids(params[:group_filter],params[:team_filter])
    @actuals = Actual.where(team_id: team_ids)

    @people = Person.where(team_id: team_ids)
    @others = Other.where(team_id: team_ids)

    @cs_acc_ids = Account.where(major: "CSs").pluck(:id)
    @interims_acc_ids = Account.where(major: "Interims").pluck(:id)
    @other_acc_ids = Account.where(major: "Other").pluck(:id)
    @income_acc_ids = Account.where(major: "Income").pluck(:id)

    @cs_ids = Name.where(role: 1).pluck(:id)
    @interim_ids = Name.where(role: 2).pluck(:id)

    cs_actuals = get_actuals_totals(@actuals.where(account_id: @cs_acc_ids))
    interims_actuals = get_actuals_totals(@actuals.where(account_id: @interims_acc_ids))
    other_actuals = get_actuals_totals(@actuals.where(account_id: @other_acc_ids))
    income_actuals = get_actuals_totals(@actuals.where(account_id: @income_acc_ids))

    cs_forecast = get_people_month_costs(@people.where(name_id: @cs_ids))
    interims_forecast = get_people_month_costs(@people.where(name_id: @interim_ids))
    other_forecast = get_other_month_costs(@others.where(account_id: @other_acc_ids))
    income_forecast = get_other_month_costs(@others.where(account_id: @income_acc_ids))

    @cs_row = make_row(cs_actuals,cs_forecast,@actual_months)
    @interims_row = make_row(interims_actuals,interims_forecast,@actual_months)
    @other_row = make_row(other_actuals,other_forecast,@actual_months)
    @income_row = make_row(income_actuals,income_forecast,@actual_months)

    @total_row = make_total_row(@cs_row,@interims_row,@other_row,@income_row)

    @cs_baseline = get_people_month_costs(BasePerson.where(name_id: @cs_ids, team_id: team_ids))
    @interims_baseline = get_people_month_costs(BasePerson.where(name_id: @interim_ids, team_id: team_ids))
    @other_baseline = get_other_month_costs(BaseOther.where(account_id: @other_acc_ids, team_id: team_ids))
    @income_baseline = get_other_month_costs(BaseOther.where(account_id: @income_acc_ids, team_id: team_ids))

    @baseline_total_row = make_total_row(@cs_baseline,@interims_baseline,@other_baseline,@income_baseline)

    @cs_variance = make_variance(@cs_row,@cs_baseline)
    @interims_variance = make_variance(@interims_row,@interims_baseline)
    @other_variance = make_variance(@other_row,@other_baseline)
    @income_variance = make_variance(@income_row,@income_baseline)

    @variance_total_row = make_total_row(@cs_variance,@interims_variance,@other_variance,@income_variance)

    @graph_data = create_graph_dict(@actual_months,@total_row,@baseline_total_row,@cumulative)
  end

  def get_team_ids(group,team)
    if (group == "" || group == nil) && (team == "" || team == nil)
      return Team.all.pluck(:id)
    elsif team != ""
      return Team.find(team).id
    else
      return Group.find(group).teams.pluck(:id)
    end
  end

  def create_graph_dict(months,fore,base,cum)
    month_names = ["Apr 2018","May 2018","Jun 2018","Jul 2018","Aug 2018","Sep 2018","Oct 2018","Nov 2018","Dec 2018","Jan 2019","Feb 2019","Mar 2019"]
    dict = [{name: "Actuals", data:[]},{name: "Forecast", data:[]},{name: "Baseline", data:[]}]
    fo = 0.0
    bas = 0.0
    (months + 1).times do |i|
      if cum
        fo += fore[i]
        bas += base[i]
      else
        fo = fore[i]
        bas = base[i]
      end
      dict[0][:data].append([month_names[i],fo])
      if i == months
        dict[1][:data].append([month_names[i],fo])
      else
        dict[1][:data].append([month_names[i],nil])
      end
      dict[2][:data].append([month_names[i],bas])
    end
    (11-months).times do |i|
      if cum
        fo += fore[months + i + 1]
        bas += base[months + i + 1]
      else
        fo = fore[months + i + 1]
        bas = base[months + i + 1]
      end
      dict[0][:data].append([month_names[months + i + 1],nil])
      dict[1][:data].append([month_names[months + i + 1],fo])
      dict[2][:data].append([month_names[months + i + 1],bas])
    end
    return dict
  end

  def make_total_row(cs,int,oth,inc)
    total = []
    cs.each_with_index do |v,i|
      total.append((v + int[i] + oth[i] + inc[i]))
    end
    return total
  end

  def make_variance(top,base)
    variance = []
    top.each_with_index do |v,i|
      variance.append(v - base[i])
    end
    return variance
  end

  def make_row(actuals,forecast,months)
    row = []
    row_total = 0.0
    (months + 1).times do |i|
      row.append(actuals[i])
    end
    (11 - months).times do |i|
      row.append(forecast[months + 1 + i])
    end
    return row
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

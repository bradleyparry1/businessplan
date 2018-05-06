module PeopleHelper

  def get_permissions_team_ids
    gs = current_user.groups
    team_ids = []
    gs.each do |g|
      g.teams.each do |t|
        team_ids << t.id
      end
    end
    return team_ids
  end

  def get_rate(name,team)
    if name.grade.id == 16
      return (name.charge_rate * 253 * 1.2) / 12
    end
    Rate.find_by(group_id: team.group.id, grade_id: name.grade_id).salary / 12
  end

  def get_all_costs(monthly_rate,ftes,indv_fte)
    costs = []
      ftes.each do |fte|
        costs.push(fte * indv_fte * monthly_rate)
      end
    return costs
  end

  def get_all_fte(start_date,end_date,indv_fte)
    date = Date.new(2018,4,1)
    fte = []
    12.times do |n|
      fte.push(indv_fte * get_fte(start_date,end_date,date + n.months,date + (n + 1).months - 1.days))
    end
    return fte
  end

  def get_fte(start_date,end_date,month_start,month_end)
    return 0 if start_date == nil || start_date > month_end || (end_date != nil && end_date < month_start)
    return 1 if start_date <= month_start && (end_date == nil || end_date >= month_end)
    if (start_date != nil && start_date > month_start) && (end_date != nil && end_date < month_end)
      fte = (business_days_between(start_date, end_date) / business_days_between(month_start, month_end))
      return fte
    end
    if start_date > month_start
      fte = (business_days_between(start_date, month_end) / business_days_between(month_start, month_end))
      return fte
    end
    if end_date < month_end
      fte = (business_days_between(month_start, end_date) / business_days_between(month_start, month_end))
      return fte
    end
  end

  def business_days_between(date1, date2)
    business_days = 0
    date = date2
    while date > date1
     business_days = business_days + 1 unless date.saturday? or date.sunday?
     date = date - 1.day
    end
    Float(business_days)
  end

  def currency(float)
    number_to_currency(float, unit: "£", separator: ".", delimiter: ",", precision: 0)
  end
end

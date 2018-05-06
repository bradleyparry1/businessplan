module DashboardHelper
  def get_all_outputs(t,change_ids,ochange_ids,inc_ids)
    cen_fte = get_total_march_fte(t.people,false,change_ids,t.pchanges)
    san_fte = get_total_march_fte(t.people,true,change_ids,t.pchanges)
    dif_fte = san_fte - cen_fte

    cen_p = get_total_spend(t.people,false,change_ids,t.pchanges)
    san_p = get_total_spend(t.people,true,change_ids,t.pchanges)
    dif_p = san_p - cen_p

    cen_o = get_other_spend(t.others,false,ochange_ids,t.ochanges,false,inc_ids)
    san_o = get_other_spend(t.others,true,ochange_ids,t.ochanges,false,inc_ids)
    dif_o = san_o - cen_o

    cen_i = get_other_spend(t.others,false,ochange_ids,t.ochanges,true,inc_ids)
    san_i = get_other_spend(t.others,true,ochange_ids,t.ochanges,true,inc_ids)
    dif_i = san_i - cen_i

    outputs = [cen_fte,san_fte,dif_fte,cen_p,san_p,dif_p,cen_o,san_o,dif_o,cen_i,san_i,dif_i]
  end

  def get_other_spend(others,sandbox,change_ids,team_changes,income,inc_ids)
    total = 0

  if income
    others = others.where("account_id IN (?)", inc_ids)
    team_changes = team_changes.where("account_id IN (?)", inc_ids)
  else
    others = others.where("account_id NOT IN (?)", inc_ids)
    team_changes = team_changes.where("account_id NOT IN (?)", inc_ids)
  end

    team_changes.each do |c|
      if sandbox && c.for_deletion != true && c.central_approved != true && c.central_declined != true
        total += total_year_cost(c)
      end
    end

    others.each do |o|
      if !change_ids.include?(o.id) || !sandbox
        total += total_year_cost(o)
      end
    end
    return total
  end

  def get_total_spend(people,sandbox,change_ids,team_changes)
    total = 0

    team_changes.each do |c|
      if sandbox && c.for_deletion != true && c.central_approved != true && c.central_declined != true
        rate = get_rate(Name.find(c.name_id),Team.find(c.team_id))
        ftes = get_all_fte(c.start,c.end,c.fte)
        all_costs = get_all_costs(rate,ftes,c.fte)
        total += all_costs.inject(0){|sum,x| sum + x }
      end
    end

    people.each do |p|
      if !change_ids.include?(p.id) || !sandbox
        rate = get_rate(Name.find(p.name_id),Team.find(p.team_id))
        ftes = get_all_fte(p.start,p.end,p.fte)
        all_costs = get_all_costs(rate,ftes,p.fte)
        total += all_costs.inject(0){|sum,x| sum + x }
      end
    end
    return total == [] ? 0 : total
  end

  def get_total_march_fte(people,sandbox,change_ids,team_changes)
    total = 0.0

    team_changes.each do |c|
      if sandbox && c.for_deletion != true && c.central_approved != true && c.central_declined != true
        rate = get_rate(c.name,c.team)
        ftes = get_all_fte(c.start,c.end,c.fte)
        total += ftes[-1]
      end
    end

    people.each do |p|
      if !change_ids.include?(p.id) || !sandbox
        rate = get_rate(p.name,p.team)
        ftes = get_all_fte(p.start,p.end,p.fte)
        total += ftes[-1]
      end
    end
    return total == [] ? 0.0 : total
  end


  def get_fte_list(people)
    fte_totals = [0,0,0,0,0,0,0,0,0,0,0,0]
    people.each do |person|
      ftes = get_all_fte(person.start,person.end,person.fte)
      12.times do |n|
        fte_totals[n] += ftes[n]
      end
    end
    return fte_totals
  end

  def get_actuals_totals(actuals)
    actuals_totals = [0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]
    actuals.each do |a|
      actuals_totals[a.month] += a.amount
    end
    return actuals_totals
  end

  def get_people_month_costs(people)
    people_totals = [0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]
    people.each do |p|
      rate = get_rate(p.name,p.team)
      ftes = get_all_fte(p.start,p.end,p.fte)
      all_costs = get_all_costs(rate,ftes,p.fte)
      all_costs.each_with_index do |a,i|
        people_totals[i] += a
      end
    end
    return people_totals
  end

  def get_other_month_costs(others)
    other_totals = [0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]
    others.each do |o|
      all_costs = other_month_costs(o)
      all_costs.each_with_index do |a,i|
        other_totals[i] += a unless !a
      end
    end
    return other_totals
  end

end

class SandboxesController < ApplicationController
  before_action :logged_in_user, only: [:people, :other]
  def people
    team_ids = params[:team_filter] && params[:team_filter] != "" ? params[:team_filter] : get_permissions_team_ids
    if params[:term]
      matches = Name.where('name LIKE ?', "%#{params[:term]}%").pluck(:id)
      @people = Person.where(team_id: team_ids,name_id: matches)
      @new = Pchange.where(person_id: nil, team_id: team_ids, central_approved: false, central_declined: false,name_id: matches)
      @changes = Pchange.where(central_approved: false, central_declined: false,name_id: matches)
    else
      @people = Person.where(team_id: team_ids)
      @new = Pchange.where(person_id: nil, team_id: team_ids, central_approved: false, central_declined: false)
      @changes = Pchange.where(central_approved: false, central_declined: false)
    end
  end

  def other
    team_ids = params[:team_filter] && params[:team_filter] != "" ? params[:team_filter] : get_permissions_team_ids
    if params[:term]
      matches = Other.where('description LIKE ?', "%#{params[:term]}%").pluck(:id)
      @others = Other.where(team_id: team_ids,id: matches)
      @new = Ochange.where(other_id: nil, team_id: team_ids, central_approved: false, central_declined: false, id: matches)
      @changes = Ochange.where(central_approved: false, central_declined: false, id: matches)
    else
      @others = Other.where(team_id: team_ids)
      @new = Ochange.where(other_id: nil, team_id: team_ids, central_approved: false, central_declined: false)
      @changes = Ochange.where(central_approved: false, central_declined: false)
    end
  end


  def change
    team_ids = get_permissions_team_ids
    @new = Pchange.where(central_approved: false, central_declined: false, bmo_approved: true, team_id: team_ids)
    @onew = Ochange.where(central_approved: false, central_declined: false, bmo_approved: true, team_id: team_ids)
  end

  def bmo
    team_ids = get_permissions_team_ids
    @new = Pchange.where(bmo_approved: false, central_approved: false, central_declined: false, team_id: team_ids)
    @onew = Ochange.where(bmo_approved: false, central_approved: false, central_declined: false, team_id: team_ids)
  end

  def approved
    team_ids = get_permissions_team_ids
    @new = Pchange.where(central_approved: true, team_id: team_ids).reverse_order
    @onew = Ochange.where(central_approved: true, team_id: team_ids).reverse_order
  end

  def declined
    team_ids = get_permissions_team_ids
    @new = Pchange.where(central_approved: false, central_declined: true, team_id: team_ids).reverse_order
    @onew = Ochange.where(central_approved: false, central_declined: true, team_id: team_ids).reverse_order
  end

  private
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
end

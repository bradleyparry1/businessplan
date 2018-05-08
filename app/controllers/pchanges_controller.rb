class PchangesController < ApplicationController
  before_action :set_pchange, only: [:show, :edit, :update, :destroy]

  # GET /pchanges
  # GET /pchanges.json
  def index
    @pchanges = Pchange.all
  end

  # GET /pchanges/1
  # GET /pchanges/1.json
  def show
    session[:return_to] ||= request.referer
  end

  # GET /pchanges/new
  def new
    @pchange = Pchange.new
    @pchange.person_id = params[:person_id]
    @pchange.name_type = params[:name_type]
    @pchange.name_id = params[:name_id]
    @pchange.team_id = params[:team_id]
    @pchange.start = params[:start]
    @pchange.end = params[:end] ? params[:end] : Date.parse("2019-04-01")
    @pchange.fte = params[:fte] ? params[:fte] : 1.0
    @pchange.brexit = params[:brexit]
    @pchange.user_id = current_user.id
  end

  # GET /pchanges/1/edit
  def edit
    session[:return_to] ||= request.referer
    if @pchange.central_approved || @pchange.central_declined
      respond_to do |format|
        format.html { redirect_to @pchange, notice: 'You cannot edit an approved or declined change.' }
        format.json { render :show, status: :created, location: @pchange }
      end
    end
    if ["BMA","BOM"].include?(current_user.user_type)
      @pchange.user_id = current_user.id
    end
  end

  # POST /pchanges
  # POST /pchanges.json
  def create
    @pchange = Pchange.new(pchange_params)

    respond_to do |format|
      if @pchange.save
        format.html { redirect_to @pchange, notice: 'Change request was successfully created.' }
        format.json { render :show, status: :created, location: @pchange }
      else
        format.html { render :new }
        format.json { render json: @pchange.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pchanges/1
  # PATCH/PUT /pchanges/1.json
  def update
    respond_to do |format|
      if @pchange.update(pchange_params)
        format.html { redirect_to session.delete(:return_to), notice: 'Change request was successfully updated.' }
        format.json { render :show, status: :ok, location: @pchange }
      else
        format.html { render :edit }
        format.json { render json: @pchange.errors, status: :unprocessable_entity }
      end
    end
    if @pchange.central_approved == true
      if @pchange.person_id != nil
        if @pchange.for_deletion == false
          per =  Person.find(@pchange.person_id)
          per.name_type = @pchange.name_type
          per.name_id = @pchange.name_id
          per.team_id = @pchange.team_id
          per.start = @pchange.start
          per.end = @pchange.end
          per.fte = @pchange.fte
          per.brexit = @pchange.brexit
          per.save
        else
          Person.find(@pchange.person_id).delete
        end
      else
        per = Person.new
        per.name_id = @pchange.name_id
        per.name_type = @pchange.name_type
        per.team_id = @pchange.team_id
        per.start = @pchange.start
        per.end = @pchange.end
        per.fte = @pchange.fte
        per.brexit = @pchange.brexit
        per.save
      end
    end
  end

  # DELETE /pchanges/1
  # DELETE /pchanges/1.json
  def destroy
    @pchange.destroy
    respond_to do |format|
      format.html { redirect_to pchanges_url, notice: 'Change request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pchange
      @pchange = Pchange.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pchange_params
      params.require(:pchange).permit(:person_id, :name_id, :name_type, :team_id, :start, :end, :fte, :brexit, :for_deletion, :bmo_approved, :central_approved, :central_declined, :user_id, :comment)
    end
end

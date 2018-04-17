class OchangesController < ApplicationController
  before_action :set_ochange, only: [:show, :edit, :update, :destroy]

  # GET /ochanges
  # GET /ochanges.json
  def index
    @ochanges = Ochange.all
  end

  # GET /ochanges/1
  # GET /ochanges/1.json
  def show
  end

  # GET /ochanges/new
  def new
    @ochange = Ochange.new
    @ochange.user_id = current_user.id
    @ochange.other_id = params[:other_id]
    @ochange.description = params[:description]
    @ochange.account_id = params[:account_id]
    @ochange.team_id = params[:team_id]
    @ochange.supplier = params[:supplier]
    @ochange.po_number = params[:po_number]
    @ochange.apr = params[:apr]
    @ochange.may = params[:may]
    @ochange.jun = params[:jun]
    @ochange.jul = params[:jul]
    @ochange.aug = params[:aug]
    @ochange.sep = params[:sep]
    @ochange.oct = params[:oct]
    @ochange.nov = params[:nov]
    @ochange.dec = params[:dec]
    @ochange.jan = params[:jan]
    @ochange.feb = params[:feb]
    @ochange.mar = params[:mar]
  end

  # GET /ochanges/1/edit
  def edit
    session[:return_to] ||= request.referer
    if ["BMA","BOM"].include?(current_user.user_type)
      @pchange.user_id = current_user.id
    end
  end

  # POST /ochanges
  # POST /ochanges.json
  def create
    @ochange = Ochange.new(ochange_params)

    respond_to do |format|
      if @ochange.save
        format.html { redirect_to @ochange, notice: 'Ochange was successfully created.' }
        format.json { render :show, status: :created, location: @ochange }
      else
        format.html { render :new }
        format.json { render json: @ochange.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ochanges/1
  # PATCH/PUT /ochanges/1.json
  def update
    respond_to do |format|
      if @ochange.update(ochange_params)
        format.html { redirect_to @ochange, notice: 'Ochange was successfully updated.' }
        format.json { render :show, status: :ok, location: @ochange }
      else
        format.html { render :edit }
        format.json { render json: @ochange.errors, status: :unprocessable_entity }
      end
    end

    if @ochange.central_approved == true
      if @ochange.other_id != nil
        if @ochange.for_deletion == false
          oth =  Other.find(@ochange.other_id)
          oth.description = @ochange.description
          oth.account_id = @ochange.account_id
          oth.team_id = @ochange.team_id
          oth.supplier = @ochange.supplier
          oth.po_number = @ochange.po_number
          oth.apr = @ochange.apr
          oth.may = @ochange.may
          oth.jun = @ochange.jun
          oth.jul = @ochange.jul
          oth.aug = @ochange.aug
          oth.sep = @ochange.sep
          oth.oct = @ochange.oct
          oth.nov = @ochange.nov
          oth.dec = @ochange.dec
          oth.jan = @ochange.jan
          oth.feb = @ochange.feb
          oth.mar = @ochange.mar
          oth.save
        else
          Other.find(@ochange.other_id).delete
        end
      else
        oth = Other.new
        oth.description = @ochange.description
        oth.account_id = @ochange.account_id
        oth.team_id = @ochange.team_id
        oth.supplier = @ochange.supplier
        oth.po_number = @ochange.po_number
        oth.apr = @ochange.apr
        oth.may = @ochange.may
        oth.jun = @ochange.jun
        oth.jul = @ochange.jul
        oth.aug = @ochange.aug
        oth.sep = @ochange.sep
        oth.oct = @ochange.oct
        oth.nov = @ochange.nov
        oth.dec = @ochange.dec
        oth.jan = @ochange.jan
        oth.feb = @ochange.feb
        oth.mar = @ochange.mar
        oth.save
      end
    end
  end

  # DELETE /ochanges/1
  # DELETE /ochanges/1.json
  def destroy
    @ochange.destroy
    respond_to do |format|
      format.html { redirect_to ochanges_url, notice: 'Ochange was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ochange
      @ochange = Ochange.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ochange_params
      params.require(:ochange).permit(:description, :team_id, :account_id, :supplier, :po_number, :apr, :may, :jun, :jul, :aug, :sep, :oct, :nov, :dec, :jan, :feb, :mar, :other_id, :bmo_approved, :central_approved, :central_declined, :user_id, :for_deletion, :comment)
    end
end

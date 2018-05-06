class CivilServantsController < ApplicationController
  before_action :set_civil_servant, only: [:show, :edit, :update, :destroy]

  # GET /civil_servants
  # GET /civil_servants.json
  def index
    @civil_servants = CivilServant.all
  end

  # GET /civil_servants/1
  # GET /civil_servants/1.json
  def show
  end

  # GET /civil_servants/new
  def new
    @civil_servant = CivilServant.new
  end

  # GET /civil_servants/1/edit
  def edit
  end

  # POST /civil_servants
  # POST /civil_servants.json
  def create
    @civil_servant = CivilServant.new(civil_servant_params)

    respond_to do |format|
      if @civil_servant.save
        format.html { redirect_to @civil_servant, notice: 'Civil servant was successfully created.' }
        format.json { render :show, status: :created, location: @civil_servant }
      else
        format.html { render :new }
        format.json { render json: @civil_servant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /civil_servants/1
  # PATCH/PUT /civil_servants/1.json
  def update
    respond_to do |format|
      if @civil_servant.update(civil_servant_params)
        format.html { redirect_to @civil_servant, notice: 'Civil servant was successfully updated.' }
        format.json { render :show, status: :ok, location: @civil_servant }
      else
        format.html { render :edit }
        format.json { render json: @civil_servant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /civil_servants/1
  # DELETE /civil_servants/1.json
  def destroy
    @civil_servant.destroy
    respond_to do |format|
      format.html { redirect_to civil_servants_url, notice: 'Civil servant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_civil_servant
      @civil_servant = CivilServant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def civil_servant_params
      params.require(:civil_servant).permit(:name, :staff_number, :job_title, :role_id, :community_id, :grade_id, :profession_id, :framework_id, :status_id)
    end
end

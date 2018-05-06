class InterimsController < ApplicationController
  before_action :set_interim, only: [:show, :edit, :update, :destroy]

  # GET /interims
  # GET /interims.json
  def index
    @interims = Interim.all
  end

  # GET /interims/1
  # GET /interims/1.json
  def show
  end

  # GET /interims/new
  def new
    @interim = Interim.new
  end

  # GET /interims/1/edit
  def edit
  end

  # POST /interims
  # POST /interims.json
  def create
    @interim = Interim.new(interim_params)

    respond_to do |format|
      if @interim.save
        format.html { redirect_to @interim, notice: 'Interim was successfully created.' }
        format.json { render :show, status: :created, location: @interim }
      else
        format.html { render :new }
        format.json { render json: @interim.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /interims/1
  # PATCH/PUT /interims/1.json
  def update
    respond_to do |format|
      if @interim.update(interim_params)
        format.html { redirect_to @interim, notice: 'Interim was successfully updated.' }
        format.json { render :show, status: :ok, location: @interim }
      else
        format.html { render :edit }
        format.json { render json: @interim.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /interims/1
  # DELETE /interims/1.json
  def destroy
    @interim.destroy
    respond_to do |format|
      format.html { redirect_to interims_url, notice: 'Interim was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_interim
      @interim = Interim.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def interim_params
      params.require(:interim).permit(:name, :staff_number, :job_title, :role_id, :community_id, :grade_id, :profession_id, :framework_id, :status_id, :charge_rate)
    end
end

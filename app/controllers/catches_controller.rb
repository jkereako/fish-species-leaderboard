class CatchesController < ApplicationController
  before_action :authorize_catch, except: [:index, :show]
  before_action :set_catch, only: [:show, :edit, :update, :destroy]

  # GET /catches
  # GET /catches.json
  def index
    @catches = Catch.all
  end

  # GET /catches/1
  # GET /catches/1.json
  def show
  end

  # GET /catches/new
  def new
    species_path = Rails.root.join('config', 'data', 'species.yml')
    @client_data[:species] = YAML.load_file species_path
    @catch = Catch.new
  end

  # GET /catches/1/edit
  def edit
  end

  # POST /catches
  # POST /catches.json
  def create
    @catch = Catch.new
    @catch.species = catch_params[:species]
    @catch.bait_used = catch_params[:bait_used]
    @catch.length_in_inches = catch_params[:length_in_inches]
    @catch.location_description = catch_params[:location_description]
    @catch.caught_at = Date.parse catch_params[:caught_at]
    @catch.user = current_user

    respond_to do |format|
      if @catch.save
        format.html { redirect_to @catch, notice: 'Catch was successfully created.' }
        format.json { render :show, status: :created, location: @catch }
      else
        format.html { render :new }
        format.json { render json: @catch.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /catches/1
  # PATCH/PUT /catches/1.json
  def update
    respond_to do |format|
      if @catch.update(catch_params)
        format.html { redirect_to @catch, notice: 'Catch was successfully updated.' }
        format.json { render :show, status: :ok, location: @catch }
      else
        format.html { render :edit }
        format.json { render json: @catch.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /catches/1
  # DELETE /catches/1.json
  def destroy
    @catch.destroy
    respond_to do |format|
      format.html { redirect_to catches_url, notice: 'Catch was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def authorize_catch
    authorize :catch
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_catch
    @catch = Catch.find_by_id params[:id]
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def catch_params
    params[:catch]
  end
end

class CompetitionsController < ApplicationController
  before_action :authorize_competition, except: [:index, :show]
  before_action :set_competition, only: [:show, :edit, :update, :destroy]

  # GET /competitions
  # GET /competitions.json
  def index
    @competitions = Competition.all
  end

  # GET /competitions/1
  # GET /competitions/1.json
  def show
  end

  # GET /competitions/new
  def new
    @competition = Competition.new
    # Although there is multiple competitors for a competition, we only need 1
    # competitor so that we can show the user a form
    @competition.competitors << User.new
  end

  # GET /competitions/1/edit
  def edit
  end

  # POST /competitions
  # POST /competitions.json
  def create
    @competition = Competition.new

    @competition.name = competition_params[:name]
    @competition.prize = competition_params[:prize]
    @competition.begins_at = Date.parse competition_params[:begins_at]
    @competition.ends_at = Date.parse competition_params[:ends_at]

    # @see http://stackoverflow.com/questions/8929230/why-is-the-first-element-always-blank-in-my-rails-multi-select-using-an-embedde
    @competition.competitors = User.find competition_params[:competitors]

    exit unless @competition.valid?

    respond_to do |format|
      if @competition.save!
        format.html { redirect_to @competition,
                      notice: 'Competition was successfully created.' }
        format.json { render :show,
                      status: :created,
                      location: @competition}
      else
        format.html { render :new }
        format.json { render json: @competition.errors,
                             status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /competitions/1
  # PATCH/PUT /competitions/1.json
  def update
    respond_to do |format|
      if @competition.update(competition_params)
        format.html { redirect_to @competition, notice: 'Competition was successfully updated.' }
        format.json { render :show, status: :ok, location: @competition }
      else
        format.html { render :edit }
        format.json { render json: @competition.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /competitions/1
  # DELETE /competitions/1.json
  def destroy
    @competition.destroy
    respond_to do |format|
      format.html { redirect_to competitions_url, notice: 'Competition was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def authorize_competition
    authorize :competition
  end
  # Use callbacks to share common setup or constraints between actions.
  def set_competition
    @competition = Competition.find_by_id params[:id]
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def competition_params
    params[:competition]
  end
end

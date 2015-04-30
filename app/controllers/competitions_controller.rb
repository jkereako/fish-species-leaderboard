class CompetitionsController < ApplicationController
  before_action :set_competition, only: [:show, :edit, :update, :destroy]

  def add_competitor
    add_user
  end
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

    # Create at least 2 users for the competition
    add_competitor
    add_competitor
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
    @competition.begins_at = Date.strptime(competition_params[:begins_at],
                                           '%m/%d/%Y')
    @competition.ends_at = Date.strptime(competition_params[:ends_at],
                                         '%m/%d/%Y')

    respond_to do |format|
      if @competition.save
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
    def add_user
      @competition.users << User.new
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_competition
      @competition = Competition.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def competition_params
      params[:competition]
    end
end

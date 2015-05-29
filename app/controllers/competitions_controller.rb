class CompetitionsController < ApplicationController
  before_action :authorize_competition, except: [:index, :show]
  before_action :set_competition, only: [:show, :edit, :update, :destroy]
  before_action :set_users, only: [:create, :update]

  def suspend
    # REVIEW This is throwing an error.
    format.json do
      render 'shared/error',
             locals: { errors: @competition.errors,
                       notice: 'Data missing or invalid'},
             status: :unprocessable_entity
    end
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
    # Although there is multiple competitors for a competition, we only need 1
    # competitor so that we can show the user a form
    @competition.users << User.new
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
    @competition.users = @users

    begin
      @competition.users = User.find_by_id competition_params[:users]
    rescue NoMethodError
      puts 'nah'
    end

    respond_to do |format|
      if @competition.save
        format.html { redirect_to @competition,
                      notice: 'Competition was successfully created.' }
        format.json { render :show,
                      status: :created,
                      location: @competition}
      else
        format.html { render :new }
        format.json do
          render 'shared/error',
                 locals: { errors: @competition.errors,
                           notice: 'Data missing or invalid'},
                 status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /competitions/1
  # PATCH/PUT /competitions/1.json
  def update
    respond_to do |format|
      @competition.ends_at = competition_params[:ends_at]
      @competition.prize = competition_params[:prize]
      @competition.users = @users

      if @competition.update(skip_validate_begins_at_is_not_in_the_past: true)
        format.html { redirect_to @competition, notice: 'Competition was successfully updated.' }
        format.json do
          render :show,
                 locals: { competition: @competition,
                           notice: "Successfully updated #{@competition.name}" },
                 location: @competition,
                 status: :ok
          end
      else
        format.html { render :edit }
        format.json do
          render 'shared/error',
                 locals: { errors: @competition.errors,
                           notice: 'Invalid data' },
                 status: :unprocessable_entity
        end
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

  #-- Helpers
  def competition_params
    params[:competition]
  end

  #-- Callbacks
  def authorize_competition
    authorize :competition
  end

  def set_competition
    @competition = Competition.find_by_id params[:id]
  end

  def set_users
    # Since @users is expected to be an array, make it so.
    if competition_params[:users].blank?
      @users = []
    else
      @users = User.find competition_params[:users]
    end
  end
end

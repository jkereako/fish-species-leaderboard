class CompetitionsController < ApplicationController
  before_action :set_competition, only: [:show, :edit, :update, :destroy, :suspend]
  before_action :authorize_competition, except: [:index, :show]
  before_action :set_users, only: [:create, :update]

  def suspend
    @competition.is_suspended = !@competition.suspended?
    respond_to do |format|
      if @competition.save
        format.html do
          redirect_to competitions_url,
                      notice: 'Competition was successfully suspended.'
        end
        format.json { head :no_content }
      else
        format.html { render :new }
        format.json do
          render 'shared/error',
                 locals: { errors: @competition.errors,
                           notice: 'Data missing or invalid' },
                 status: :unprocessable_entity
        end
      end
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
    @competition.users.build User.all.active.as_json

  end

  # GET /competitions/1/edit
  def edit
    @competition.users.build User.all.active.as_json
  end

  # POST /competitions
  # POST /competitions.json
  def create
    @competition = Competition.new
    # REVIEW: The code below invalidates `begins_at` and `ends_at` while still
    # satisfying the validators. If we were to pass nil, then an exception will
    # be raised. Instead, we pass a valid date which will be invalid when passed
    # to the validators.
    set_begins_at
    set_ends_at

    @competition.name = competition_params[:name]
    @competition.prize = competition_params[:prize]
    @competition.bonus = competition_params[:bonus]
    @competition.users = @users

    respond_to do |format|
      if @competition.save
        format.html do
          redirect_to @competition,
                      notice: 'Competition was successfully created.'
        end
        format.json do
          render :show,
                 locals: { competition: @competition,
                           notice: "Successfully created #{@competition.name}" },
                 status: :created,
                 location: @competition
        end
      else
        format.html { render :new }
        format.json do
          render 'shared/error',
                 locals: { errors: @competition.errors,
                           notice: 'Data missing or invalid' },
                 status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /competitions/1
  # PATCH/PUT /competitions/1.json
  def update
    respond_to do |format|
      if @competition.update competition_params
        format.html do
          redirect_to @competition,
                      notice: 'Competition was successfully updated.'
        end
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
      format.html do
        redirect_to competitions_url,
                    notice: 'Competition was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  def set_begins_at
    @competition.begins_at = Time.parse competition_params[:begins_at]
    rescue ArgumentError
      @competition.begins_at = Time.zone.parse '1970-01-02 00:00:00'
  end

  # Make `ends_at` 1 day before `begins_at` to invalidate it.
  def set_ends_at
    @competition.ends_at = Time.zone.parse competition_params[:ends_at]
    rescue ArgumentError
      @competition.ends_at = Time.zone.parse '1970-01-01 00:00:00'
  end

  #-- Helpers
  def competition_params
    params.require(:competition).permit(:bonus, :name, :begins_at, :ends_at,
                                        :prize, users: [])
  end

  #-- Callbacks
  def authorize_competition
    if @competition.present?
      authorize @competition
    else
      authorize :competition
    end
  end

  def set_competition
    @competition = Competition.find_by_id params[:id]
  end

  def set_users
    filtered_params = competition_params
    # Since @users is expected to be an array, make it so.
    if filtered_params[:users].blank?
      @users = []
    else
      @users = User.find filtered_params[:users]
    end
  end
end

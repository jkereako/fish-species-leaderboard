class UserInvitationsController < Devise::InvitationsController
  before_action :authorize_user_invitation

  # GET /catches
  # GET /catches.json
  def index
    super
  end

  # GET /catches/1
  # GET /catches/1.json
  def show
    super
  end

  # GET /catches/new
  def new
    super
  end

  # GET /catches/1/edit
  def edit
    super
  end

  # POST /catches
  # POST /catches.json
  def create
    super
  end

  # PATCH/PUT /catches/1
  # PATCH/PUT /catches/1.json
  def update
    super
  end

  # DELETE /catches/1
  # DELETE /catches/1.json
  def destroy
    super
  end

  private

  def authorize_user_invitation
    authorize :user_invitation
  end

end

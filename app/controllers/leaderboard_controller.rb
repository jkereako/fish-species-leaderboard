class LeaderboardController < ApplicationController
  def index
    @competitions = Competition.active
  end
end

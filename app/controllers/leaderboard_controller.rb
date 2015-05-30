class LeaderboardController < ApplicationController
  def index
    @competitions = Competition.active.begun
  end
end

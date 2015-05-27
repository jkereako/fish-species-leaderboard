class LeaderboardController < ApplicationController
  def index
    @competitions = Competition.all
  end
end

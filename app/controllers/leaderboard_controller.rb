class LeaderboardController < ApplicationController
  def index
    @competitions = Competition.order :catches_count
  end
end

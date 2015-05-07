module LeaderboardHelper
  def last_catch_for(competitor:)
    competitor.catches.order(:created_at).last
  end
end

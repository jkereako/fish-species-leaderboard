module CompetitionsHelper
  def competition_status_in_words(competition)
    return 'on going' if competition.active?
    return 'suspended' if competition.suspended?
    return 'expired' if competition.expired?
  end
end

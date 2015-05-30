module CompetitionsHelper
  def competition_status_in_words(competition)
    return 'on going' if competition.active?
    return 'suspended' if competition.suspended?
    return 'expired' if competition.expired?
  end

  def bs_class_for_competition_status (competition)
    return 'label-success' if competition.active?
    return 'label-warning' if competition.suspended?
    return 'label-danger' if competition.expired?
  end

end

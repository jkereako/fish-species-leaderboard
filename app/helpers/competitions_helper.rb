module CompetitionsHelper
  # Convert status into words
  def competition_status_in_words(competition)
    return 'on going' if competition.active?
    return 'not started' if competition.yet_to_begin?
    return 'suspended' if competition.suspended?
    return 'expired' if competition.expired?
  end

  # Apply a Bootstrap label class for each status
  def bs_class_for_competition_status(competition)
    return 'label-success' if competition.active?
    return 'label-info' if competition.yet_to_begin?
    return 'label-warning' if competition.suspended?
    return 'label-danger' if competition.expired?
  end

end

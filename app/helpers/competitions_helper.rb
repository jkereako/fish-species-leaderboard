module CompetitionsHelper
  def competition_status_in_words(competition)
    case competition.active?
    when true
      return 'active'
    when false
      return 'inactive'
    end
  end
end

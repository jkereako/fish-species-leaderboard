module CompetitionsHelper
  def competition_status_in_words(is_active)
    case is_active
    when true
      return 'on going'
    when false
      return 'expired'
    end
  end
end

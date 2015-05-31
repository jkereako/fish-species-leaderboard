module CatchesHelper

  def length_in_words(length)
    return 'not taken' if length == 0
    length + '"'
  end
end

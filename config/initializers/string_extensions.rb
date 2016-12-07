class String
  #
  # Extracts the first and the latest character from the current String.
  #
  def first_and_last
    split('').select.with_index do |character, index|
      character if index.zero? || index == (size - 1)
    end
  end
end

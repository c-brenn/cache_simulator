class ImprovedRandomReplacement
  attr_reader :max_index
  def initialize(num_lines)
    @occupied_lines = 0
    @max_index = num_lines - 1
  end

  def access(line)
  end

  def replacement_index
    if full?
      rand 0..max_index
    else
      @occupied_lines += 1
      @occupied_lines - 1
    end
  end

  private

  def full?
    @occupied_lines == (max_index + 1)
  end
end

class RandomReplacement
  attr_reader :max_index
  def initialize(num_lines)
    @max_index = num_lines - 1
  end

  def access(line)
  end

  def replacement_index
    rand 0..max_index
  end
end

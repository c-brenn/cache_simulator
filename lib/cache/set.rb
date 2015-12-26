require_relative "./fifo_replacement"

class Set
  attr_reader  :num_lines, :replacement_policy
  attr_accessor :lines, :occupied_lines

  def initialize(lines_per_set, bytes_per_line, replacement_policy = nil)
    @num_lines = lines_per_set
    @occupied_lines = 0
    @lines = []
    @replacement_policy = FifoReplacement.new(lines_per_set)
  end

  def access(tag)
    index = lines.index { |t| t == tag }
    if index
      replacement_policy.access(index)
      true
    else
      add_tag(tag)
      false
    end
  end

  private

  def full?
    occupied_lines == num_lines
  end

  def add_tag(tag)
    self.occupied_lines += 1 if !full?
    lines[replacement_index] = tag
    replacement_policy.access(replacement_index)
  end

  def replacement_index
    replacement_policy.replacement_index
  end
end

require_relative "./fifo_replacement"
class Set
  attr_reader  :num_lines
  attr_accessor :lines, :occupied_lines

  def initialize(lines_per_set, bytes_per_line, replacement_policy = nil)
    @num_lines = lines_per_set
    @occupied_lines = 0
    @lines = []
    @replacement_policy = FifoReplacement.new(lines_per_set)
  end

  def access(tag)
    if lines.any? { |t| t == tag }
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
  end

  def replacement_index
    @replacement_policy.next_index
  end
end

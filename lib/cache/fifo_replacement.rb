class FifoReplacement
  def initialize(base)
    @base = base
    @index = 0
  end

  def next_index
    @index += 1
    (@index - 1)% @base
  end
end

class FifoReplacement
  def initialize(base)
    @base = base
    @index = 0
  end

  # no op - all replacement policies must implement access
  def access(n)
    true
  end

  def replacement_index
    @index += 1
    (@index - 1)% @base
  end
end

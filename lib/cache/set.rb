require_relative "./replacement_policy_factory"

class Set
  attr_reader   :replacement_policy
  attr_accessor :lines

  def initialize(lines_per_set, bytes_per_line, replacement_policy = :lru)
    @lines = []
    @replacement_policy = ReplacementPolicyFactory.new.build(
        lines_per_set: lines_per_set,
        replacement_policy: replacement_policy)
  end

  def access(tag)
    lookup(tag) || handle_miss(tag)
  end

  def hit?
    @hit
  end

  private

  def lookup(tag)
    index = lines.index { |t| t == tag }
    if index
      replacement_policy.access(index)
      @hit = true
    end
  end

  def handle_miss(tag)
    index = replacement_index
    lines[index] = tag
    replacement_policy.access(index)
    @hit = false
  end

  def replacement_index
    replacement_policy.replacement_index
  end
end

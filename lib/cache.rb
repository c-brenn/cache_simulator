require_relative "./cache/set"

class Cache
  attr_accessor :sets
  attr_reader :set_bits, :offset_bits

  def initialize(num_sets, lines_per_set, bytes_per_line)
    @set_bits = Math.log2(num_sets).ceil
    @offset_bits = Math.log2(bytes_per_line).ceil
    initilize_sets(num_sets, lines_per_set, bytes_per_line)
  end

  def access(address)
    tag, set, offset = split_adress(address)

    sets[set].access(tag)
  end

  def split_adress(address)
    offset = address & gen_mask(offset_bits)
    set_number = (address >> offset_bits) & gen_mask(set_bits)
    tag = address >> set_bits + offset_bits
    [tag, set_number, offset]
  end

  private

  def initilize_sets(num_sets, lines_per_set, bytes_per_line)
    self.sets = []
    num_sets.times do
      self.sets << Set.new(lines_per_set, bytes_per_line)
    end
  end

  def gen_mask(num_ones)
    mask = 0
    num_ones.times do
      mask = mask << 1
      mask = mask + 1
    end
    mask
  end
end

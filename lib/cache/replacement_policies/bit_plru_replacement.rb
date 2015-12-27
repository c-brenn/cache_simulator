class BitPLRUReplacement
  attr_reader :num_lines
  attr_accessor :bits, :set_bits
  def initialize(num_lines)
    @bits = Array.new(num_lines) { 0 }
    @num_lines = num_lines
    @set_bits = 0
  end

  def access(index)
    self.set_bits += 1
    if set_bits == num_lines
      bits.collect! { 0 }
      self.set_bits = 0
    end
    bits[index] = 1
  end

  def replacement_index
    bits.index { |bit| bit == 0 } || 0
  end
end

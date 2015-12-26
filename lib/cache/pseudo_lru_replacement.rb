class PseudoLRUReplacement
  attr_accessor :bits
  def initialize(num_lines)
    @num_lines = num_lines
    @bits = Array.new(num_lines - 1) { 0 }
    @base_index = (num_lines / 2) - 1
  end

  def access(index)
    alter_tree(@base_index + (index / 2), index % 2) if @num_lines != 1
  end

  def replacement_index
    if @num_lines == 1
      0
    else
      build_str(0, "").to_i(2)
    end
  end

  private

  def build_str(index, str)
    bit = bits[index]
    str << bit.to_s
    next_index = index * 2 + 1 + bit
    if next_index < bits.length
      build_str(next_index, str)
    else
      str
    end
  end

  def alter_tree(index, parity)
    bits[index] = flip_parity(parity)
    if index <= 0
      return
    else
      alter_tree((index - 1) / 2, (index + 1) % 2)
    end
  end

  def flip_parity(parity)
    if parity == 0
      1
    else
      0
    end
  end
end

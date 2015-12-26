class LRUReplacement
  attr_accessor :matrix
  def initialize(num_lines)
    initialize_matrix num_lines
  end

  def access(index)
    matrix[index].collect! { 1 }
    matrix.each { |row| row[index] = 0 }
  end

  def replacement_index
    matrix.index { |row|
      row.all? { |elem| elem == 0 }
    }
  end

  private

  def initialize_matrix(num_lines)
    self.matrix = Array.new(num_lines) {
      Array.new(num_lines) { 0 }
    }
  end
end

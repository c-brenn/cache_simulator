require 'table_print'

class Logger
  def self.pretty_print(results)
    tp results,
      {:"N:K:L" => row_key},
      {hits: row_attr(:hits)},
      {misses: row_attr(:misses)},
      {hit_rate: row_attr(:hit_rate)}
    puts "\n\n"
  end

  def self.row_attr(attr)
    ->(row) { row[row_key.(row)][attr] }
  end

  def self.row_key
    ->(row) { row.keys.first }
  end
end

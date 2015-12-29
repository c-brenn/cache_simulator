class StatMaintainer
  def initialize
    reset_stats
  end

  def reset_stats
    @hits = 0
    @misses = 0
  end

  def record_access(is_hit)
    if is_hit
      @hits += 1
    else
      @misses += 1
    end
  end

  def current_results
    {
      hits: @hits,
      misses: @misses,
      hit_rate: hit_rate
    }
  end

  private

  def hit_rate
    ((1.0 * @hits) / (@hits + @misses)).round(3)
  end
end

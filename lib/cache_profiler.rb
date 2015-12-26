require_relative "./cache"
require_relative "./cache/set"
require_relative "./cache/lru_replacement"
require_relative "./cache/pseudo_lru_replacement"

class CacheProfiler
  @@addresses = [
    "0000",
    "0004",
    "000c",
    "2200",
    "00d0",
    "00e0",
    "1130",
    "0028",
    "113c",
    "2204",
    "0010",
    "0020",
    "0004",
    "0040",
    "2208",
    "0008",
    "00a0",
    "0004",
    "1104",
    "0028",
    "000c",
    "0084",
    "000c",
    "3390",
    "00b0",
    "1100",
    "0028",
    "0064",
    "0070",
    "00d0",
    "0008",
    "3394"
  ]

  attr_reader :cache
  attr_accessor :misses, :hits
  def initialize
    @cache = nil
    @hits = 0
    @misses = 0
  end

  def profile(cache)
    @cache = cache
    self.hits = 0
    self.misses = 0
    access_addresses
    print_results
  end

  private

  def access_addresses
    @@addresses.each do |address|
      address = address.to_i(16)
      is_hit = cache.access(address)
      log_result(is_hit)
      # print_result(address, is_hit)
    end
  end

  def log_result(hit)
    if hit
      self.hits += 1
    else
      self.misses += 1
    end
  end

  def print_result(address, is_hit)
    tag, set, offset = cache.split_adress(address)
    str = "address #{address}\t set #{set}\t "
    if is_hit
      str << "hit"
    else
      str << "miss"
    end
    puts str
  end

  def print_results
    puts "-- Results --"
    puts "hits: #{self.hits}"
    puts "misses: #{self.misses}"
    puts "-------------"
  end
end

comp = CacheProfiler.new
puts "---- LRU ----"
rep_policy = LRUReplacement
comp.profile(Cache.new(8, 1, 16, rep_policy))
comp.profile(Cache.new(4, 2, 16, rep_policy))
comp.profile(Cache.new(2, 4, 16, rep_policy))
comp.profile(Cache.new(1, 8, 16, rep_policy))

puts "---- Psuedo LRU ----"
rep_policy = PseudoLRUReplacement
comp.profile(Cache.new(8, 1, 16, rep_policy))
comp.profile(Cache.new(4, 2, 16, rep_policy))
comp.profile(Cache.new(2, 4, 16, rep_policy))
comp.profile(Cache.new(1, 8, 16, rep_policy))

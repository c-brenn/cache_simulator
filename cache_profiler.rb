Dir.glob("./lib/**/*.rb").each { |f| require f }

class CacheProfiler

  @@cache_configurations = [
    [8, 1, 16],
    [4, 2, 16],
    [2, 4, 16],
    [1, 8, 16]
  ]

  attr_reader :cache
  attr_accessor :misses, :hits
  def initialize
    @cache = nil
    @hits = 0
    @misses = 0
    @addresses = read_addresses
  end

  def profile_policy(replacement_policy)
    @@cache_configurations.each do |config|
      print_start(config)
      profile(Cache.new(config[0], config[1], config[2], replacement_policy))
      print_results
    end
  end

  private

  def profile(cache)
    @cache = cache
    self.hits = 0
    self.misses = 0
    access_addresses
  end

  def access_addresses
    @addresses.each do |address|
      is_hit = cache.access(address)
      log_result(is_hit)
    end
  end

  def log_result(hit)
    if hit
      self.hits += 1
    else
      self.misses += 1
    end
  end

  def print_start(config)
    puts "\n--- Profile ---"
    puts "cache sets: #{config[0]}"
    puts "lines per set: #{config[1]}"
    puts "bytes per line: #{config[2]}\n"
  end

  def print_results
    puts "hits: #{self.hits}"
    puts "misses: #{self.misses}"
    puts "-------------\n"
  end

  def read_addresses
    File.readlines("./support/addresses.txt").map { |i| i.to_i(16) }
  end
end

comp = CacheProfiler.new
rep_policy = :improved_random
comp.profile_policy(rep_policy)

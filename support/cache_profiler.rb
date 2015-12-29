Dir.glob(File.expand_path("../lib/**/*.rb", File.dirname(__FILE__))).each { |f| require f }
require_relative "./logger"
require_relative "./stat_maintainer"

class CacheProfiler

  attr_reader :cache
  def initialize
    @stat_maintainer = StatMaintainer.new
    @addresses = read_addresses
  end

  def profile_policy(replacement_policy)
    cache_configurations.map { |config|
      results = profile build_cache(config, replacement_policy)
      result_key = "#{config[:n]}:#{config[:k]}:#{config[:l]}"
      { result_key => results }
    }
  end

  def print_results(results)
    Logger.pretty_print(results)
  end


  private

  def build_cache(config, replacement_policy)
    Cache.new(config[:n], config[:k], config[:l], replacement_policy)
  end

  def profile(cache)
    @stat_maintainer.reset_stats
    access_addresses_and_record_hits cache
    @stat_maintainer.current_results
  end

  def access_addresses_and_record_hits(cache)
    @addresses.each do |address|
      is_hit = cache.access(address)
      @stat_maintainer.record_access is_hit
    end
  end

  def cache_configurations
    [
      {n: 8, k: 1, l: 16},
      {n: 4, k: 2, l: 16},
      {n: 2, k: 4, l: 16},
      {n: 1, k: 8, l: 16}
    ]
  end

  def read_addresses
    File.readlines(File.expand_path("addresses.txt", File.dirname(__FILE__))).map { |i| i.to_i(16) }
  end
end

comp = CacheProfiler.new
ReplacementPolicyFactory.policies.each do |policy|
  puts "** POLICY -- #{policy} **"
  results =  comp.profile_policy(policy)
  comp.print_results results
end

require_relative "./replacement_policies/bit_plru_replacement"
require_relative "./replacement_policies/fifo_replacement"
require_relative "./replacement_policies/improved_random_replacement"
require_relative "./replacement_policies/lru_replacement"
require_relative "./replacement_policies/pseudo_lru_replacement"
require_relative "./replacement_policies/random_replacement"

class ReplacementPolicyFactory

  REPLACEMENT_POLICIES = {
    lru: LRUReplacement,
    pseudo_lru_tree: PseudoLRUReplacement,
    pseudo_lru_bits: BitPLRUReplacement,
    random: RandomReplacement,
    improved_random: ImprovedRandomReplacement
  }

  def initialize
    @policies = Hash.new(LRUReplacement).merge REPLACEMENT_POLICIES
  end

  def build(lines_per_set:, replacement_policy: :lru)
    if lines_per_set <= 1
      direct_mapped_cache_policy
    else
      build_policy(replacement_policy, lines_per_set)
    end
  end

  private

  def build_policy(policy_key, lines_per_set)
    policy = @policies[policy_key]
    policy.new(lines_per_set)
  end

  @@direct_mapped_cache_policy = Struct.new(:nothing) do
    def access(index)
    end

    def replacement_index
      0
    end
  end

  def direct_mapped_cache_policy
    @@direct_mapped_cache_policy.new
  end
end

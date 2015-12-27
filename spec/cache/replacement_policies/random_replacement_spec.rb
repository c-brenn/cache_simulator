require "cache/replacement_policies/random_replacement"

describe RandomReplacement do
  subject { RandomReplacement.new(2) }
  it_behaves_like "a replacement policy"
end

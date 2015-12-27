require "cache/replacement_policy_factory"

describe ReplacementPolicyFactory do
  let(:factory) { ReplacementPolicyFactory.new }
  describe "#build" do
    it "rep-policy for direct mapped caches always replaces 0th line" do
      rep_policy = factory.build(lines_per_set: 1, replacement_policy: :anything)

      expect(rep_policy.replacement_index).to eq 0
      expect(rep_policy.replacement_index).to eq 0
      expect(rep_policy.replacement_index).to eq 0
    end

    it "builds the correct replacement policy for non direct mapped caches" do
      rep_policy = factory.build(lines_per_set: 4, replacement_policy: :random)

      expect(rep_policy).to be_a RandomReplacement
    end
  end
end

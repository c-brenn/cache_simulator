require "cache/replacement_policies/pseudo_lru_replacement"

describe PseudoLRUReplacement do
  subject { PseudoLRUReplacement.new(2) }
  it_behaves_like "a replacement policy"

  describe "#access and #replacement_index" do
    it "replaces the first line when no accesses have been made" do
      replacement_policy = PseudoLRUReplacement.new(4)

      expect(replacement_policy.replacement_index).to eq(0)
    end

    it "alters the bits correctly and replaces the correct item" do
      replacement_policy = PseudoLRUReplacement.new(4)

      replacement_policy.access(1)
      expect(replacement_policy.replacement_index).to eq(2)

      replacement_policy.access(2)
      expect(replacement_policy.replacement_index).to eq(0)

      replacement_policy.access(0)
      expect(replacement_policy.replacement_index).to eq(3)

      replacement_policy.access(1)
      expect(replacement_policy.replacement_index).to eq(3)

      replacement_policy.access(3)
      expect(replacement_policy.replacement_index).to eq(0)
    end

    it "can cope with large sets" do
      replacement_policy = PseudoLRUReplacement.new(8)

      replacement_policy.access(1)
      expect(replacement_policy.replacement_index).to eq(4)

      replacement_policy.access(4)
      expect(replacement_policy.replacement_index).to eq(2)

      replacement_policy.access(3)
      expect(replacement_policy.replacement_index).to eq(6)
    end
  end
end

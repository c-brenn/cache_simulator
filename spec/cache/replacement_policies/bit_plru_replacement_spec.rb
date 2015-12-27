require "cache/replacement_policies/bit_plru_replacement"

describe BitPLRUReplacement do
  subject { BitPLRUReplacement.new(2) }
  it_behaves_like "a replacement policy"

  describe "#replacement_index" do
    it "replaces the first line when no accesses have occured" do
      rep_policy = BitPLRUReplacement.new(3)

      expect(rep_policy.replacement_index).to eq 0
    end

    it "replaces the first element it encounters that has not been accessed" do
      rep_policy = BitPLRUReplacement.new(3)

      rep_policy.access(1)
      rep_policy.access(0)
      expect(rep_policy.replacement_index).to eq 2
    end

    it "replaces the first unset line when all lines have been accessed" do
      rep_policy = BitPLRUReplacement.new(3)

      rep_policy.access(1)
      rep_policy.access(2)
      rep_policy.access(0)
      expect(rep_policy.replacement_index).to eq 1
    end
  end
end

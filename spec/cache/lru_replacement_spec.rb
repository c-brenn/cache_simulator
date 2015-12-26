require "cache/lru_replacement"

describe LRUReplacement do
  subject { LRUReplacement.new(2) }
  it_behaves_like "a replacement policy"

  describe "#access" do
    it "sets the bits correctly on indexes" do
      replacement_policy = LRUReplacement.new(3)
      replacement_policy.access(1)

      matrix = replacement_policy.matrix
      expect(all_zeroes?(matrix[0])).to eq true
      expect(matrix[1]).to eq [1, 0, 1]
      expect(all_zeroes?(matrix[2])).to eq true
    end
  end

  describe "#replacement_index" do
    it "replaces the first line when no accesses have been made" do
      replacement_policy = LRUReplacement.new(3)

      expect(replacement_policy.replacement_index).to eq 0
    end

    it "replaces the LRU entry after accesses have been made" do
      replacement_policy  = LRUReplacement.new(3)
      replacement_policy.access(0)
      replacement_policy.access(2)

      expect(replacement_policy.replacement_index).to eq 1

      replacement_policy.access(1)
      expect(replacement_policy.replacement_index).to eq 0
    end
  end

  def all_zeroes?(row)
    row.all? { |i| i == 0 }
  end
end

require "cache/set"

describe Set do
  it "is true" do
    expect(true).to eq true
  end

  describe "#access" do
    it "misses when the set is empty" do
      set = Set.new(1, 1)

      expect(set.access(123)).to eq(false)
    end

    it "hits when the tag is present" do
      set = Set.new(1,1)
      set.access(123)
      expect(set.access(123)).to eq(true)
    end
  end
end

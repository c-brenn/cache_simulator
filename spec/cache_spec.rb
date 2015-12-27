require "cache"

describe Cache do
  describe "initialization" do
    let(:cache) { Cache.new(8,8,8) }

    it "has the correct number of sets" do
      expect(cache.sets.length).to eq(8)
    end

    it "uses the correct number of bits to split the addresses" do
      expect(cache.set_bits).to eq(3)
      expect(cache.offset_bits).to eq(3)
    end
  end

  describe "#split_adress" do
    let(:cache) { Cache.new(2, 4, 16) }

    it "splits the address correctly" do
      tag, set_number, offset = cache.split_adress(0x11)
      expect(tag).to eq(0)
      expect(set_number).to eq(1)
      expect(offset).to eq(1)
    end
  end

  describe "#access" do
    it "misses when there is nothing in the cache" do
      cache = Cache.new(1, 1, 1)

      expect(cache.access(0x11)).to be_falsey
    end

    it "hits when the entry is in the cache" do
      cache = Cache.new(2, 4, 16)
      cache.access(0x11)

      expect(cache.access(0x11)).to be_truthy
    end
  end
end

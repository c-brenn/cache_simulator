require "cache/fifo_replacement"

describe FifoReplacement do
  subject { FifoReplacement.new(0) }
  it_behaves_like "a replacement policy"

  describe "#replacement_index" do
    it "cycles through indices" do
      replacement_policy = FifoReplacement.new(3)

      expect(replacement_policy.replacement_index).to eq 0
      expect(replacement_policy.replacement_index).to eq 1

      replacement_policy.replacement_index # loop around
      expect(replacement_policy.replacement_index).to eq 0
    end
  end
end

require "cache/fifo_replacement"

describe FifoReplacement do
  describe "#next_index" do
    it "cycles through indices" do
      replacement_policy = FifoReplacement.new(3)

      expect(replacement_policy.next_index).to eq 0
      expect(replacement_policy.next_index).to eq 1

      replacement_policy.next_index # loop around
      expect(replacement_policy.next_index).to eq 0
    end
  end
end

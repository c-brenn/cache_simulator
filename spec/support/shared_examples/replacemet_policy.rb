RSpec.shared_examples "a replacement policy" do
  it { is_expected.to respond_to :access }
  it { is_expected.to respond_to :replacement_index }
end

RSpec.describe Ease do
  describe "#at" do
    it "can ease linearly" do
      subject = Ease.new(:linear_tween, 2)

      expect(subject.at(0.0)).to eq(0)
      expect(subject.at(1.0)).to eq(0.5)
      expect(subject.at(1.5)).to eq(0.75)
      expect(subject.at(2.0)).to eq(1)
    end

    it "can ease in/out by a sine wave" do
      subject = Ease.new(:ease_in_out_sine, 2)

      expect(subject.at(0.0)).to eq(0)
      expect(subject.at(1.0)).to be_between(0.49, 0.51)
      expect(subject.at(1.5)).to be_between(0.85, 0.86)
      expect(subject.at(2.0)).to eq(1)
    end

    it "does not require names start with 'ease'" do
      subject = Ease.new(:in_out_sine, 2)
      expect(subject.at(1.5)).to be_between(0.85, 0.86)
    end

    it "infers 'linear_tween' from 'linear'" do
      subject = Ease.new(:linear, 2)
      expect(subject.at(1.5)).to eq(0.75)
    end
  end
end

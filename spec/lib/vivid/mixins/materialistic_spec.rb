module Vivid
  RSpec.describe Materialistic do
    class MaterialisticTest
      include Renderable
      include Materialistic

      render_as :shape, :sphere

      def attributes
        {}
      end
    end

    it "defines a getter and setter for the material" do
      subject = MaterialisticTest.new
      plastic = Plastic.new

      subject.material = plastic
      expect(subject.material).to eq(plastic)
    end

    it "renders the material before the object" do
      subject = MaterialisticTest.new
      plastic = Plastic.new

      subject.material = plastic
      subject.next_frame

      builder = PBRT::Builder.new
      subject.build_pbrt(builder)

      expect(builder.to_s).to eq(<<~PBRT)
        Material "plastic"
        Shape "sphere"
      PBRT
    end

    context "when no material is set" do
      it "does not render a material" do
        subject = MaterialisticTest.new
        subject.next_frame

        builder = PBRT::Builder.new
        subject.build_pbrt(builder)

        expect(builder.to_s).to eq(<<~PBRT)
          Shape "sphere"
        PBRT
      end
    end
  end
end

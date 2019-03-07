module Vivid
  RSpec.describe Transformable do
    class TransformableTest
      include Transformable

      transforms :translate, :scale, :rotate
    end

    it "defines the transform methods" do
      subject = TransformableTest.new

      expect(subject).to respond_to(:translate)
      expect(subject).to respond_to(:scale)
      expect(subject).to respond_to(:rotate)
    end

    it "defines a method on the class to get the transform names" do
      expect(TransformableTest.transfom_names).to eq [:translate, :scale, :rotate]
    end

    describe "#translate" do
      it "sets the initial translate_transform array to [0, 0, 0]" do
        subject = TransformableTest.new

        expect(subject.translate_transform).to eq [0, 0, 0]
      end

      it "adds to the translate_transform array" do
        subject = TransformableTest.new

        subject.translate(1, 2, 3)
        expect(subject.translate_transform).to eq [1, 2, 3]

        subject.translate(1, 2, 3)
        expect(subject.translate_transform).to eq [2, 4, 6]
      end
    end

    describe "#scale" do
      it "sets the initial scale_transform array to [1, 1, 1]" do
        subject = TransformableTest.new

        expect(subject.scale_transform).to eq [1, 1, 1]
      end

      it "multiplies the scale_transform array" do
        subject = TransformableTest.new

        subject.scale(1, 2, 3)
        expect(subject.scale_transform).to eq [1, 2, 3]

        subject.scale(1, 2, 3)
        expect(subject.scale_transform).to eq [1, 4, 9]
      end
    end

    describe "#rotate" do
      it "sets the initial rotate_transform array to empty" do
        subject = TransformableTest.new

        expect(subject.rotate_transform).to eq []
      end

      it "appends the rotation to the translate_transform array" do
        subject = TransformableTest.new

        subject.rotate(90, 1, 0, 0)
        expect(subject.rotate_transform).to eq [[90, 1, 0, 0]]

        subject.rotate(45, 1, 1, 0)
        expect(subject.rotate_transform).to eq [[90, 1, 0, 0], [45, 1, 1, 0]]
      end

      it "adds to the previous rotation if the axis is the same" do
        subject = TransformableTest.new

        subject.rotate(90, 1, 0, 0)
        subject.rotate(45, 1, 0, 0)

        expect(subject.rotate_transform).to eq [[135, 1, 0, 0]]
      end

      it "wraps around to 0..360 degrees" do
        subject = TransformableTest.new

        subject.rotate(370, 1, 0, 0)
        expect(subject.rotate_transform).to eq [[10, 1, 0, 0]]

        subject.rotate(-20, 1, 0, 0)
        expect(subject.rotate_transform).to eq [[350, 1, 0, 0]]
      end
    end

    class TransformableTest2
      include Transformable

      transforms :scale
    end

    it "does not define transform methods that aren't listed" do
      subject = TransformableTest2.new

      expect(subject).not_to respond_to(:translate)
      expect(subject).not_to respond_to(:rotate)
    end

    context "when the object is renderable" do
      class TransformableTest3
        include Renderable
        include Transformable

        render_as :shape, :sphere
        transforms :translate, :scale, :rotate

        def attributes
          { radius: 1 }
        end
      end

      it "renders the transforms before the object" do
        subject = TransformableTest3.new

        subject.translate(1, 2, 3)
        subject.scale(4, 5, 6)
        subject.rotate(90, 0, 1, 0)

        builder = PBRT::Builder.new

        subject.next_frame
        subject.build_pbrt(builder)

        expect(builder.to_s).to eq(<<~PBRT)
          Translate 1 2 3
          Scale 4 5 6
          Rotate 90 0 1 0
          Shape "sphere" "float radius" [1]
        PBRT
      end
    end
  end
end

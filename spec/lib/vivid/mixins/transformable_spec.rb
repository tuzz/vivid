module Vivid
  RSpec.describe Transformable do
    class TransformableTest
      include Transformable
      include Renderable

      transforms :translate, :scale, :rotate
      render_as :shape, :sphere

      def attributes
        { radius: 1 }
      end
    end

    it "defines the transform methods" do
      subject = TransformableTest.new

      expect(subject).to respond_to(:translate)
      expect(subject).to respond_to(:scale)
      expect(subject).to respond_to(:rotate)
    end

    it "defines a method on the class to get the transform names" do
      expect(TransformableTest.transform_names).to eq [:translate, :scale, :rotate]
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

      it "renders the translation before the object" do
        subject = TransformableTest.new
        subject.translate(1, 2, 3)

        builder = PBRT::Builder.new
        subject.next_frame
        subject.build_pbrt(builder)

        expect(builder.to_s).to eq(<<~PBRT)
          Translate 1 2 3
          Shape "sphere" "float radius" [1]
        PBRT
      end

      it "does not render any translations if the object isn't translated" do
        subject = TransformableTest.new

        builder = PBRT::Builder.new
        subject.next_frame
        subject.build_pbrt(builder)

        expect(builder.to_s).to eq(<<~PBRT)
          Shape "sphere" "float radius" [1]
        PBRT
      end

      it "supports animated translations" do
        subject = TransformableTest.new

        subject.translate(1, 2, 3)
        subject.next_frame
        subject.translate(4, 5, 6)

        builder = PBRT::Builder.new
        subject.build_pbrt(builder)

        expect(builder.to_s).to eq(<<~PBRT)
          Translate 1 2 3
          ActiveTransform EndTime
          Translate 4 5 6
          ActiveTransform All
          Shape "sphere" "float radius" [1]
        PBRT
      end

      it "combines translations correctly between frames" do
        subject = TransformableTest.new

        subject.translate(1, 2, 3)
        subject.next_frame

        subject.translate(4, 5, 6)
        subject.next_frame

        subject.translate(7, 8, 9)

        builder = PBRT::Builder.new
        subject.build_pbrt(builder)

        expect(builder.to_s).to eq(<<~PBRT)
          Translate 5 7 9
          ActiveTransform EndTime
          Translate 7 8 9
          ActiveTransform All
          Shape "sphere" "float radius" [1]
        PBRT
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

      it "renders the scale before the object" do
        subject = TransformableTest.new
        subject.scale(1, 2, 3)

        builder = PBRT::Builder.new
        subject.next_frame
        subject.build_pbrt(builder)

        expect(builder.to_s).to eq(<<~PBRT)
          Scale 1 2 3
          Shape "sphere" "float radius" [1]
        PBRT
      end

      it "does not render any scales if the object isn't scaled" do
        subject = TransformableTest.new

        builder = PBRT::Builder.new
        subject.next_frame
        subject.build_pbrt(builder)

        expect(builder.to_s).to eq(<<~PBRT)
          Shape "sphere" "float radius" [1]
        PBRT
      end

      it "supports animated scales" do
        subject = TransformableTest.new

        subject.scale(1, 2, 3)
        subject.next_frame
        subject.scale(4, 5, 6)

        builder = PBRT::Builder.new
        subject.build_pbrt(builder)

        expect(builder.to_s).to eq(<<~PBRT)
          Scale 1 2 3
          ActiveTransform EndTime
          Scale 4 5 6
          ActiveTransform All
          Shape "sphere" "float radius" [1]
        PBRT
      end

      it "combines scales correctly between frames" do
        subject = TransformableTest.new

        subject.scale(1, 2, 3)
        subject.next_frame

        subject.scale(4, 5, 6)
        subject.next_frame

        subject.scale(7, 8, 9)

        builder = PBRT::Builder.new
        subject.build_pbrt(builder)

        expect(builder.to_s).to eq(<<~PBRT)
          Scale 4 10 18
          ActiveTransform EndTime
          Scale 7 8 9
          ActiveTransform All
          Shape "sphere" "float radius" [1]
        PBRT
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

      it "renders the rotations before the object" do
        subject = TransformableTest.new

        subject.rotate(90, 1, 0, 0)
        subject.rotate(45, 0, 1, 0)

        builder = PBRT::Builder.new
        subject.next_frame
        subject.build_pbrt(builder)

        expect(builder.to_s).to eq(<<~PBRT)
          Rotate 90 1 0 0
          Rotate 45 0 1 0
          Shape "sphere" "float radius" [1]
        PBRT
      end

      it "does not render any rotations if the object isn't rotated" do
        subject = TransformableTest.new

        builder = PBRT::Builder.new
        subject.next_frame
        subject.build_pbrt(builder)

        expect(builder.to_s).to eq(<<~PBRT)
          Shape "sphere" "float radius" [1]
        PBRT
      end

      it "supports animated rotations" do
        subject = TransformableTest.new

        subject.rotate(90, 1, 0, 0)
        subject.next_frame
        subject.rotate(45, 0, 1, 0)

        builder = PBRT::Builder.new
        subject.build_pbrt(builder)

        expect(builder.to_s).to eq(<<~PBRT)
          Rotate 90 1 0 0
          ActiveTransform EndTime
          Rotate 45 0 1 0
          ActiveTransform All
          Shape "sphere" "float radius" [1]
        PBRT
      end

      it "combines rotations correctly between frames" do
        subject = TransformableTest.new

        subject.rotate(90, 1, 0, 0)
        subject.next_frame

        subject.rotate(45, 0, 1, 0)
        subject.next_frame

        subject.rotate(45, 0, 1, 0)
        subject.next_frame

        subject.rotate(45, 0, 1, 0)

        builder = PBRT::Builder.new
        subject.build_pbrt(builder)

        expect(builder.to_s).to eq(<<~PBRT)
          Rotate 90 1 0 0
          Rotate 90 0 1 0
          ActiveTransform EndTime
          Rotate 45 0 1 0
          ActiveTransform All
          Shape "sphere" "float radius" [1]
        PBRT
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

    class TransformableTest3
      include Transformable

      transforms :translate
      transforms :scale
    end

    it "can define transforms separately" do
      expect(TransformableTest3.transform_names).to eq [:translate, :scale]
    end

    class TransformableTest4 < TransformableTest3
    end

    pending "it works with inheritance" do
      expect(TransformableTest4.transform_names).to eq [:translate, :scale]
    end

    class TransformableTest5
      include Transformable
      include Renderable

      transforms :translate, :no_motion_blur

      render_as :shape, :sphere

      def attributes
        { radius: 1 }
      end
    end

    it "does not use separate transform times if no_motion_blur is set" do
      subject = TransformableTest5.new

      subject.next_frame
      subject.translate(1, 2, 3)

      builder = PBRT::Builder.new
      subject.build_pbrt(builder)

      expect(builder.to_s).to eq(<<~PBRT)
        Translate 1 2 3
        Shape "sphere" "float radius" [1]
      PBRT
    end
  end
end

module Vivid
  RSpec.describe Renderable do
    class RenderableTest
      include Renderable

      render_as :shape, :sphere

      attr_accessor :attributes
    end

    it "defines the #build_pbrt and #next_frame methods" do
      subject = RenderableTest.new

      expect(subject).to respond_to(:build_pbrt)
      expect(subject).to respond_to(:next_frame)
    end

    it "errors if #build_pbrt is called before #next_frame" do
      subject = RenderableTest.new
      builder = PBRT::Builder.new

      expect { subject.build_pbrt(builder) }.to raise_error(SequenceError)
    end

    it "errors if #build_pbrt is called twice in a row without #next_frame" do
      subject = RenderableTest.new
      builder = PBRT::Builder.new

      subject.next_frame
      subject.build_pbrt(builder)

      expect { subject.build_pbrt(builder) }.to raise_error(SequenceError)
    end

    it "calls the a method for each render name on the build_pbrt builder" do
      subject = RenderableTest.new
      builder = PBRT::Builder.new

      subject.next_frame
      subject.build_pbrt(builder)

      expect(builder.to_s).to eq(<<~PBRT)
        Shape "sphere"
      PBRT
    end

    it "passes attributes to the final method called on the builder" do
      subject = RenderableTest.new
      builder = PBRT::Builder.new

      subject.attributes = { radius: 1 }

      subject.next_frame
      subject.build_pbrt(builder)

      expect(builder.to_s).to eq(<<~PBRT)
        Shape "sphere" "float radius" [1]
      PBRT
    end

    it "defines a method on the class to get the render names" do
      expect(RenderableTest.render_names).to eq [:shape, :sphere]
    end

    class RenderableTest2
      include Renderable

      render_as :texture, :@name, :spectrum, :imagemap

      def attributes
        { name: name, filename: "foo.png" }
      end

      attr_accessor :name
    end

    it "can pass arguments to the chained methods" do
      subject = RenderableTest2.new
      builder = PBRT::Builder.new

      subject.name = "mytexture"

      subject.next_frame
      subject.build_pbrt(builder)

      expect(builder.to_s).to eq(<<~PBRT)
        Texture "mytexture" "spectrum" "imagemap" "string filename" ["foo.png"]
      PBRT
    end

    class RenderableTest3
      include Renderable

      render_as :translate, :@xy, :@z

      attr_accessor :xy, :z
    end

    it "can pass arguments (instead of attributes) to the last method" do
      subject = RenderableTest3.new
      builder = PBRT::Builder.new

      subject.xy = [1, 2]
      subject.z = 3

      subject.next_frame
      subject.build_pbrt(builder)

      expect(builder.to_s).to eq(<<~PBRT)
        Translate 1 2 3
      PBRT
    end

    class RenderableTest4
      include Renderable

      render_as :shape, :sphere, :@my_attributes

      attr_accessor :my_attributes
    end

    it "can send a different set of attributes to the last method" do
      subject = RenderableTest4.new
      builder = PBRT::Builder.new

      subject.my_attributes = { radius: 1 }

      subject.next_frame
      subject.build_pbrt(builder)

      expect(builder.to_s).to eq(<<~PBRT)
        Shape "sphere" "float radius" [1]
      PBRT
    end

    class RenderableTest5
      include Renderable

      render_as :shape, :sphere

      attr_accessor :attributes, :something

      before_frame :foo
      before_render :bar
      after_render :baz

      def foo
        self.something = true
      end

      def bar(builder)
        builder.translate(1, 1, 1)
      end

      def baz(builder)
        builder.translate(2, 2, 2)
      end
    end

    it "can be extended with before and after hooks" do
      subject = RenderableTest5.new
      builder = PBRT::Builder.new

      expect(subject.something).to be_falsey
      subject.next_frame
      expect(subject.something).to be_truthy

      subject.build_pbrt(builder)

      expect(builder.to_s).to eq(<<~PBRT)
        Translate 1 1 1
        Shape "sphere"
        Translate 2 2 2
      PBRT
    end

    class RenderableTest6
      include Renderable
    end

    it "does not render if 'render_as' is not set" do
      subject = RenderableTest6.new
      builder = PBRT::Builder.new

      subject.next_frame
      subject.build_pbrt(builder)

      expect(builder.to_s).to eq("")
    end

    class RenderableTest7
      include Renderable

      before_render :foo
      after_render :bar

      def foo(builder)
        builder.translate(1, 1, 1)
      end

      def bar(builder)
        builder.translate(2, 2, 2)
      end
    end

    it "still runs before and after hooks if 'render_as' is not set" do
      subject = RenderableTest7.new
      builder = PBRT::Builder.new

      subject.next_frame
      subject.build_pbrt(builder)

      expect(builder.to_s).to eq(<<~PBRT)
        Translate 1 1 1
        Translate 2 2 2
      PBRT
    end
  end
end

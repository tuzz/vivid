module Vivid
  RSpec.describe Renderable do
    class RenderableTest
      include Renderable

      render :shape, :sphere

      attr_accessor :attributes
    end

    it "defines the #build_pbrt method" do
      subject = RenderableTest.new
      expect(subject).to respond_to(:build_pbrt)
    end

    it "calls the a method for each render name on the build_pbrt builder" do
      subject = RenderableTest.new
      builder = PBRT::Builder.new

      subject.build_pbrt(builder)

      expect(builder.to_s).to eq(<<~PBRT)
        Shape "sphere"
      PBRT
    end

    it "passes attributes to the final method called on the builder" do
      subject = RenderableTest.new
      builder = PBRT::Builder.new

      subject.attributes = { radius: 1 }
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

      render :texture, :@name, :spectrum, :imagemap

      def attributes
        { name: name, filename: "foo.png" }
      end

      attr_accessor :name
    end

    it "can pass arguments to the chained methods" do
      subject = RenderableTest2.new
      builder = PBRT::Builder.new

      subject.name = "mytexture"
      subject.build_pbrt(builder)

      expect(builder.to_s).to eq(<<~PBRT)
        Texture "mytexture" "spectrum" "imagemap" "string filename" ["foo.png"]
      PBRT
    end

    class RenderableTest3
      include Renderable

      render :translate, :@xy, :@z

      attr_accessor :xy, :z
    end

    it "can pass arguments (instead of attributes) to the last method" do
      subject = RenderableTest3.new
      builder = PBRT::Builder.new

      subject.xy = [1, 2]
      subject.z = 3

      subject.build_pbrt(builder)

      expect(builder.to_s).to eq(<<~PBRT)
        Translate 1 2 3
      PBRT
    end

    class RenderableTest4
      include Renderable

      render :shape, :sphere, :@my_attributes

      attr_accessor :my_attributes
    end

    it "can send a different set of attributes to the last method" do
      subject = RenderableTest4.new
      builder = PBRT::Builder.new

      subject.my_attributes = { radius: 1 }
      subject.build_pbrt(builder)

      expect(builder.to_s).to eq(<<~PBRT)
        Shape "sphere" "float radius" [1]
      PBRT
    end
  end
end

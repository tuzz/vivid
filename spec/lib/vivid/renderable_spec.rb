module Vivid
  RSpec.describe Renderable do
    class RenderableTest
      include Renderable

      render :shape, :sphere

      attr_accessor :attributes
    end

    it "defines the #to_pbrt method" do
      subject = RenderableTest.new
      expect(subject).to respond_to(:to_pbrt)
    end

    it "calls the a method for each render name on the to_pbrt builder" do
      subject = RenderableTest.new
      builder = PBRT::Builder.new

      subject.to_pbrt(builder)

      expect(builder.to_s).to eq(<<~PBRT)
        Shape "sphere"
      PBRT
    end

    it "passes attributes to the final method called on the builder" do
      subject = RenderableTest.new
      builder = PBRT::Builder.new

      subject.attributes = { radius: 1 }
      subject.to_pbrt(builder)

      expect(builder.to_s).to eq(<<~PBRT)
        Shape "sphere" "float radius" [1]
      PBRT
    end

    it "defines a method on the class to get the render names" do
      expect(RenderableTest.render_names).to eq [:shape, :sphere]
    end
  end
end

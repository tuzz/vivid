module Vivid
  RSpec.describe Attributes do
    class AttributesTest
      include Attributes

      attributes :foo, :bar
    end

    it "defines getters and setters for the attributes" do
      subject = AttributesTest.new

      subject.foo = "foo"
      subject.bar = 123

      expect(subject.foo).to eq("foo")
      expect(subject.bar).to eq(123)
    end

    it "can set the attributes on initialization" do
      subject = AttributesTest.new(foo: "foo", bar: 123)

      expect(subject.foo).to eq("foo")
      expect(subject.bar).to eq(123)
    end

    it "defines a method to get the attributes hash" do
      subject = AttributesTest.new

      subject.foo = "foo"
      subject.bar = 123

      expect(subject.attributes).to eq(foo: "foo", bar: 123)
    end

    it "defines a method on the class to get the attribute names" do
      expect(AttributesTest.attribute_names).to eq [:foo, :bar]
    end

    class AttributesTest2
      include Attributes

      attributes :foo
      attributes :bar
    end

    it "can define attributes separately" do
      expect(AttributesTest2.attribute_names).to eq [:foo, :bar]
    end

    class AttributesTest3 < AttributesTest2
    end

    pending "it works with inheritance" do
      expect(AttributesTest3.attribute_names).to eq [:foo, :bar]
    end
  end
end

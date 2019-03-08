module Vivid
  class Config
    def self.path
      @path
    end

    def self.path=(path)
      @path = path

      YAML.load_file(path).each do |key, value|
        define_singleton_method(key) { value }
      end
    end
  end

  def self.config
    Config
  end
end

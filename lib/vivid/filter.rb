module Vivid
  class Filter
    include Attributes
    include Renderable

    def option_type
      :filter
    end
  end
end

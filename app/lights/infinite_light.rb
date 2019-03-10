class InfiniteLight < Vivid::Light
  attributes :scale, :L, :samples, :mapname
  render_as :light_source, :infinite
end

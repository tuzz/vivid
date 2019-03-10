class DistantLight < Vivid::Light
  attributes :scale, :L, :from, :to
  render_as :light_source, :distant
end

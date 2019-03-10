class SpotLight < Vivid::Light
  attributes :scale, :I, :from, :to, :coneangle, :conedeltaangle
  render_as :light_source, :spot
end

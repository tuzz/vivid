class AreaLight < Vivid::Light
  attributes :shape, :L, :twosided, :samples
  render_as :area_light_source, :diffuse
  transforms :translate, :rotate, :scale, :no_motion_blur
  after_render :render_shape

  def attributes
    super.reject { |k, _| k == :shape }
  end

  def render_shape(builder)
    shape.next_frame
    shape.build_pbrt(builder)
  end
end

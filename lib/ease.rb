# The different methods for easing are here:
# https://github.com/munshkr/easing-ruby/blob/master/lib/easing.rb

class Ease
  attr_accessor :method, :duration

  def initialize(method, duration)

    self.method = coerce(method.to_s)
    self.duration = duration
  end

  def at(time)
    Easing.public_send(method, time, 0, 1, duration)
  end

  private

  def coerce(method)
    if method.start_with?("ease")
      method.to_sym
    elsif method.start_with?("linear")
      :linear_tween
    else
      :"ease_#{method}"
    end
  end
end

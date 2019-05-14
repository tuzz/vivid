class GameOfLifeScene < Vivid::Scene
  WIDTH = 10
  HEIGHT = 10
  GENERATIONS = 20

  def description
    GENERATIONS.times do |g|
      z = (g + 1) * 20

      WIDTH.times do |w|
        HEIGHT.times do |h|
          x = -WIDTH / 2 + w + 0.5
          y = -HEIGHT / 2 + h + 0.5

          sphere = Sphere.new.scale(0.3, 0.3, 0.3).translate(x, y, z)
          sphere.material = Disney.new(color: alive?(w, h) ? rgb(0, 1, 0) : rgb(1, 0, 0))
          add sphere

          add PointLight.new(I: rgb(0.2, 0.2, 0.2))
            .translate(x + rand - 0.5, y + rand - 0.5, z - 0.4) if alive?(w, h)
        end
      end

      update_board
    end

    light = PointLight.new(I: rgb(10, 10, 10))

    distance = GENERATIONS * 20
    duration = GENERATIONS * 2

    play Simultaneous.new(
      Translate.new(options[:camera], by: [0, 0, -distance], duration: duration, ease: :in_out_sine),
      Translate.new(light, by: [0, 0, -distance], duration: duration, ease: :in_out_sine),
      Rotate.new(options[:camera], by: distance / 2, axis: [0, 0, 1], duration: duration, ease: :in_out_sine),
    )
  end

  # A very quick and dirty implementation of Game of Life:
  def board
    @board ||= Array.new(HEIGHT) { Array.new(WIDTH) { [true, false].sample } }
  end

  def update_board
    HEIGHT.times { |y| WIDTH.times { |x| board[y][x] = alive_next?(x, y) } }
  end

  def alive_next?(x, y)
    (live_neighbors(x, y) == 3) || (board[y][x] && live_neighbors(x, y) == 2)
  end

  def live_neighbors(x, y)
    (-1..1).flat_map { |i| (-1..1).map { |j| alive?(x + i, y + j) unless [i, j] == [0, 0] } }.count(&:itself)
  end

  def alive?(x, y)
    x %= WIDTH; y %= HEIGHT; board[y][x]
  end
end

GameOfLifeScene.new.render

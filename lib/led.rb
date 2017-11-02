module LED

  COLORS = [
    Ws2812::Color.new(255, 0, 0),
    Ws2812::Color.new(255, 127, 0),
    Ws2812::Color.new(255, 255, 0),
    Ws2812::Color.new(127, 255, 0),
    Ws2812::Color.new(0, 255, 0),
    Ws2812::Color.new(0, 255, 127),
    Ws2812::Color.new(0, 255, 255),
    Ws2812::Color.new(0, 127, 255),
    Ws2812::Color.new(0, 0, 255),
    Ws2812::Color.new(127, 0, 255),
    Ws2812::Color.new(255, 0, 255),
    Ws2812::Color.new(255, 0, 127)
  ]
  BLACK = Ws2812::Color.new(0,0,0)

  MATRIX = [
    [  0,  0,  1,  2,  3,  0,  0,  0,  0,  0,  0,  0,  0],
    [  0,  8,  7,  6,  5,  4,  0,  0,  0,  0, 22, 21, 20],
    [  9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19,  0,  0],
    [ 32, 31, 30, 29, 28, 27, 26, 25, 24, 23,  0,  0,  0],
    [ 33, 34,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0],
    [ 36, 35,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0],
    [ 37, 38, 39, 40, 41, 42, 43, 44, 45,  0,  0,  0,  0],
    [  0,  0,  0,  0, 50, 49, 48, 47, 46,  0,  0,  0,  0],
    [ 51, 52, 53, 54, 55,  0,  0,  0,  0, 56, 57,  0,  0],
  ]

  HAT = Ws2812::Basic.new(55, 18).open
  def self.disp(hat, from_x, from_y, to_x, to_y, color, time = 0.15)
    (from_x...to_x).each do |x|
      hat[MATRIX[from_y][x]-1] = color if (0...13).include?(x) && (0..8).include?(from_y) && MATRIX[from_y][x] != 0
    end
    (from_y..to_y).each do |y|
      hat[MATRIX[y][to_x]-1] = color if (0...13).include?(to_x) && (0..8).include?(y) && MATRIX[y][to_x] != 0
    end
    (from_x...to_x).each do |x|
      hat[MATRIX[to_y][x]-1] = color if (0...13).include?(x) && (0..8).include?(to_y) && MATRIX[to_y][x] != 0
    end
    (from_y...to_y).each do |y|
      hat[MATRIX[y][from_x]-1] = color if (0...13).include?(from_x) && (0..8).include?(y) && MATRIX[y][from_x] != 0
    end
    hat.show

    sleep time

    (from_x...to_x).each do |x|
      hat[MATRIX[from_y,][x]-1] = LED::BLACK if (0...13).include?(x) && (0..8).include?(from_y) && MATRIX[from_y][x] != 0
    end
    (from_y..to_y).each do |y|
      hat[MATRIX[y,][to_x]-1] = LED::BLACK if (0...13).include?(to_x) && (0..8).include?(y) && MATRIX[y][to_x] != 0
    end
    (from_x...to_x).each do |x|
      hat[MATRIX[to_y][x]-1] = LED::BLACK if (0...13).include?(x) && (0..8).include?(to_y) && MATRIX[to_y][x] != 0
    end
    (from_y...to_y).each do |y|
      hat[MATRIX[y][from_x]-1] = LED::BLACK if (0...13).include?(from_x) && (0..8).include?(y) && MATRIX[y][from_x] != 0
    end
    hat.show
  end

  def self.kakusan(hat, num, color)
    x, y = 0
    y = MATRIX.index do |x_s|
      x = x_s.index do |y_s|
        y_s == num
      end
    end
    disp(hat, x, y, x, y, color)
    13.times do |i|
      LED.disp(hat, x-i, y-i, x+i, y+i, color)
    end
  end


  def self.play
    input = UniMIDI::Input.first
    hat = Ws2812::Basic.new(57, 18).open

    begin
      MIDI.using(input) do
        receive :note do |message|
          if 18 < message.velocity
#            puts message.note
            if Thread.list.size < 24
              color = COLORS[message.note % 12]
#              puts color
              Thread.new do
                 LED.kakusan(hat, rand(1..57), color)
              end
            end
          end
        end
        join
      end
    rescue Interrupt
    # ignored
    end
  end

  def self.play2
    input = UniMIDI::Input.first
    hat = Ws2812::Basic.new(55, 18).open

    begin
      MIDI.using(input) do
        receive :note do |message|
          if 18 < message.velocity
#            puts message.note
            if Thread.list.size < 24
              color = COLORS[message.note % 12]
#              puts color
              Thread.new do
                HAT[0..11] = color
                HAT[30..54] = color
                HAT.show
                sleep 0.2
                HAT[0..11] = BLACK
                HAT[30..54] = BLACK
                HAT.show
              end
            end
          end
        end
        join
      end
    rescue Interrupt
    # ignored
    end
  end

  def self.flash(color = nil)
    HAT[12..30] = color || COLORS.sample
    HAT.show
    sleep 0.2
    HAT[12..30] = BLACK
    HAT.show
  end
end

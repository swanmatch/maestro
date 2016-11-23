module LED
  colors = [
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

  def disp(hat, from_x, from_y, to_x, to_y, color, time = 0.15)
    (from_x...to_x).each do |x|
      hat[x, from_y] = color if (0..7).include?(x) && (0..7).include?(from_y)
    end
    (from_y..to_y).each do |y|
      hat[to_x, y] = color if (0..7).include?(to_x) && (0..7).include?(y)
    end
    (from_x...to_x).each do |x|
      hat[x, to_y] = color if (0..7).include?(x) && (0..7).include?(to_y)
    end
    (from_y...to_y).each do |y|
      hat[from_x, y] = color if (0..7).include?(from_x) && (0..7).include?(y)
    end
    hat.show

    sleep time

    black = Ws2812::Color.new(0,0,0)
    (from_x...to_x).each do |x|
      hat[x, from_y] = black if (0..7).include?(x) && (0..7).include?(from_y)
    end
    (from_y..to_y).each do |y|
      hat[to_x, y] = black if (0..7).include?(to_x) && (0..7).include?(y)
    end
    (from_x...to_x).each do |x|
      hat[x, to_y] = black if (0..7).include?(x) && (0..7).include?(to_y)
    end
    (from_y...to_y).each do |y|
      hat[from_x, y] = black if (0..7).include?(from_x) && (0..7).include?(y)
    end
    hat.show
  end

  def kakusan(hat, x, y, color)
    disp(hat, x, y, x, y, color)
    8.times do |i|
      disp(hat, x-i, y-i, x+i, y+i, color)
    end
  end


  def play
    input = UniMIDI::Input.first
    $hat = Ws2812::UnicornHAT.new

    begin
      MIDI.using(input) do
        receive :note do |message|
          if 18 < message.velocity
            if Thread.list.size < 24
              color = colors[message.note % 12]
              Thread.new do
                kakusan($hat, rand(0..7), rand(0..7), color)
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

end
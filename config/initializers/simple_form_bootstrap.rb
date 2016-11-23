# Use this setup block to configure all options available in SimpleForm.
SimpleForm.setup do |config|
  config.error_notification_class = 'alert alert-danger'
  config.button_class = 'btn btn-default'
  config.boolean_label_class = nil

  config.wrappers :vertical_form, tag: 'div', class: 'form-group', error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :label, class: 'control-label'

    b.use :input, class: 'form-control'
    b.use :error, wrap_with: { tag: 'span', class: 'help-block' }
    b.use :hint,  wrap_with: { tag: 'p', class: 'help-block' }
  end

  config.wrappers :vertical_file_input, tag: 'div', class: 'form-group', error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :readonly
    b.use :label, class: 'control-label'

    b.use :input
    b.use :error, wrap_with: { tag: 'span', class: 'help-block' }
    b.use :hint,  wrap_with: { tag: 'p', class: 'help-block' }
  end

  config.wrappers :vertical_boolean, tag: 'div', class: 'form-group', error_class: 'has-error' do |b|
    b.use :html5
    b.optional :readonly

    b.wrapper tag: 'div', class: 'checkbox' do |ba|
      ba.use :label_input
    end

    b.use :error, wrap_with: { tag: 'span', class: 'help-block' }
    b.use :hint,  wrap_with: { tag: 'p', class: 'help-block' }
  end

  config.wrappers :vertical_radio_and_checkboxes, tag: 'div', class: 'form-group', error_class: 'has-error' do |b|
    b.use :html5
    b.optional :readonly
    b.use :label, class: 'control-label'
    b.use :input
    b.use :error, wrap_with: { tag: 'span', class: 'help-block' }
    b.use :hint,  wrap_with: { tag: 'p', class: 'help-block' }
  end

  config.wrappers :horizontal_form, tag: 'div', class: 'form-group', error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :label, class: 'col-sm-3 control-label'

    b.wrapper tag: 'div', class: 'col-sm-9' do |ba|
      ba.use :input, class: 'form-control'
      ba.use :error, wrap_with: { tag: 'span', class: 'help-block' }
      ba.use :hint,  wrap_with: { tag: 'p', class: 'help-block' }
    end
  end

  config.wrappers :horizontal_file_input, tag: 'div', class: 'form-group', error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :readonly
    b.use :label, class: 'col-sm-3 control-label'

    b.wrapper tag: 'div', class: 'col-sm-9' do |ba|
      ba.use :input
      ba.use :error, wrap_with: { tag: 'span', class: 'help-block' }
      ba.use :hint,  wrap_with: { tag: 'p', class: 'help-block' }
    end
  end

  config.wrappers :horizontal_boolean, tag: 'div', class: 'form-group', error_class: 'has-error' do |b|
    b.use :html5
    b.optional :readonly

    b.wrapper tag: 'div', class: 'col-sm-offset-3 col-sm-9' do |wr|
      wr.wrapper tag: 'div', class: 'checkbox' do |ba|
        ba.use :label_input
      end

      wr.use :error, wrap_with: { tag: 'span', class: 'help-block' }
      wr.use :hint,  wrap_with: { tag: 'p', class: 'help-block' }
    end
  end

  config.wrappers :horizontal_radio_and_checkboxes, tag: 'div', class: 'form-group', error_class: 'has-error' do |b|
    b.use :html5
    b.optional :readonly

    b.use :label, class: 'col-sm-3 control-label'

    b.wrapper tag: 'div', class: 'col-sm-9' do |ba|
      ba.use :input
      ba.use :error, wrap_with: { tag: 'span', class: 'help-block' }
      ba.use :hint,  wrap_with: { tag: 'p', class: 'help-block' }
    end
  end

  config.wrappers :inline_form, tag: 'div', class: 'form-group', error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :label, class: 'sr-only'

    b.use :input, class: 'form-control'
    b.use :error, wrap_with: { tag: 'span', class: 'help-block' }
    b.use :hint,  wrap_with: { tag: 'p', class: 'help-block' }
  end

  config.wrappers :multi_select, tag: 'div', class: 'form-group', error_class: 'has-error' do |b|
    b.use :html5
    b.optional :readonly
    b.use :label, class: 'control-label'
    b.wrapper tag: 'div', class: 'form-inline' do |ba|
      ba.use :input, class: 'form-control'
      ba.use :error, wrap_with: { tag: 'span', class: 'help-block' }
      ba.use :hint,  wrap_with: { tag: 'p', class: 'help-block' }
    end
  end
  # Wrappers for forms and inputs using the Bootstrap toolkit.
  # Check the Bootstrap docs (http://getbootstrap.com)
  # to learn about the different styles for forms and inputs,
  # buttons and other elements.
  config.default_wrapper = :vertical_form
  config.wrapper_mappings = {
    check_boxes: :vertical_radio_and_checkboxes,
    radio_buttons: :vertical_radio_and_checkboxes,
    file: :vertical_file_input,
    boolean: :vertical_boolean,
    datetime: :multi_select,
    date: :multi_select,
    time: :multi_select
  }
end
require "micromidi"
require "ws2812"

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
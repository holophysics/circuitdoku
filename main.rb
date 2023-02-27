#===============================================
#                     Classes
#===============================================

class Circuit
  def initialize graph
    @graph = graph
  end
end

class Solid
  attr_accessor :x, :y, :w, :h, :r, :g, :b, :a, :blendmode_enum

  def primitive_marker
    :solid
  end
end
#================================================
class Wire < Solid

  @@w = 6

  def initialize x1, y1, x2, y2
    self.x = get_x x1, y1, x2, y2
    self.y = get_y x1, y1, x2, y2
    self.w = get_w x1, y1, x2, y2
    self.h = get_h x1, y1, x2, y2
  end

  def serialize
    {
      x: x,
      y: y,
      w: w,
      h: h
    }
  end

  def inspect
    serialize.to_s
  end

  def to_s
    serialize.to_s
  end
  

  def get_x x1, y1, x2, y2
    if x2 == x1
      x = x1 - (@@w / 2).round
    elsif y1 == y2
      x = x1
    end
    x
  end
  
  def get_y x1, y1, x2, y2
    if x2 == x1
      y = y1
    elsif y2 == y1
      y = y1 - (@@w / 2).round
    end
    y
  end
  
  def get_w x1, y1, x2, y2
    if x2 == x1
      w = @@w
    elsif y2 == y1
      w = x2 - x1
    end
    w
  end
  
  def get_h x1, y1, x2, y2
    if x2 == x1
      h = y2 - y1
    elsif y2 == y1
      h = @@w
    end
    h
  end
end
#===============================================
class Sprite
  attr_accessor :x, :y, :w, :h, :path, :angle, :a, :r, :g, :b,
  :source_x, :source_y, :source_w, :source_h,
  :tile_x, :tile_y, :tile_w, :tile_h,
  :flip_horizontally, :flip_vertically,
  :angle_anchor_x, :angle_anchor_y, :blendmode_enum

  def primitive_marker
    :sprite
  end
end
#===============================================
class SwitchHorizontal < Sprite
  @@W = 160
  @@H = 160

  def initialize x_c, y_c
    self.x = (x_c - @@W / 2).round
    self.y = (y_c - @@H / 2).round
    self.w = @@W
    self.h = @@H
    self.path = 'sprites/specific/switch-hor-open.png'
    @is_open = true
  end

  def toggle
    @is_open = !@is_open

    if @is_open == true
      path = "sprites/specific/switch-hor-open.png"
    elsif @is_open == false
      path = "sprites/specific/switch-hor-closed.png"
    end
  end

  def serialize
    {
      x: x,
      y: y,
      w: w,
      h: h,
      path: path
    }
  end

  def inspect
    serialize.to_s
  end

  def to_s
    serialize.to_s
  end
end
#===============================================
class SwitchVertical < Sprite
  @@W = 160
  @@H = 160

  def initialize x_c, y_c
    self.x = (x_c - @@W / 2).round
    self.y = (y_c - @@H / 2).round
    self.w = @@W
    self.h = @@H
    self.path = set_path
    @is_open = true
  end

  def toggle
    @is_open = !@is_open

    if @is_open == true
      path = "sprites/specific/switch-ver-open.png"
    elsif @is_open == false
      path = "sprites/specific/switch-ver-closed.png"
    end
  end

  def serialize
    {
      x: x,
      y: y,
      w: w,
      h: h,
      path: path
    }
  end

  def inspect
    serialize.to_s
  end

  def to_s
    serialize.to_s
  end
end
#===============================================

class Bulb < Sprite
  @@W = 98
  @@H = 134

  def initialize x_c, y_c
    self.x = (x_c - @@W/2).round
    self.y = (y_c - @@H/2).round
    self.w = @@W
    self.h = @@H
    self.path = 'sprites/specific/bulb-unlit.png'
    self.source_x = 40
    self.source_y = 40
    self.source_w = 900
    self.source_h = 1200
  end

  def serialize
    {
      x: x,
      y: y,
      w: w,
      h: h,
      path: path,
      source_x: source_x,
      source_y: source_y,
      source_w: source_w,
      source_h: source_h
    }
  end

  def inspect
    serialize.to_s
  end

  def to_s
    serialize.to_s
  end
end 
#===============================================
class Battery < Sprite
  @@W = 73
  @@H = 138

  def initialize x_c, y_c
    self.x = (x_c - @@W/2).round
    self.y = (y_c - @@H/2).round
    self.w = @@W
    self.h = @@H
    self.path = 'sprites/specific/battery.png'
  end

  def serialize
    {
      x: x,
      y: y,
      w: w,
      h: h,
      path: path
    }
  end

  def inspect
    serialize.to_s
  end

  def to_s
    serialize.to_s
  end
end 
#===============================================
class Connector < Sprite
  def initialize x, y, w, h
    @x = x
    @y = y
    @w = w
    @h = h
    @path = 'sprites/specific/connector.png'
  end
end 
#===============================================
#                     Scenes
#===============================================

class CDGame
  def initialize args
    @args = args
    @sprites = []
    @wires = []
    @bulbs = []
    @switches = []

    @circuit = [
      :battery_p
      :connector,
      :wire,
      :corner_connector,
      :wire,
      :connector,
      :switch_horizontal,
      :connector,
      :wire,
      :connector,
      :bulb,
      :connector,
      :wire,
      :corner_connector,
      :wire,
      :corner_connector,
      :wire,
      :corner_connector,
      :wire,
      :connector,
      :battery_n
    ]

    @corners = {
      lower_left: {x: 320, y: 160},
      upper_left: {x: 320, y: 550},
      upper_right: {x: 960, y: 550},
      lower_right: {x: 960, y: 160}
    }

    #@args.state.switch1 ||= SwitchHorizontal.new(480, 550)
#
    #@args.state.bulb1 ||= Bulb.new(640, 600)
#
    #@sprites << Battery.new(320, 310)
    #@wires << Wire.new(320, 380, 320, 550)
    #@wires << Wire.new(320, 550, 415, 550)
    #@switches << @args.state.switch1
    #@wires << Wire.new(545, 550, 640, 550)
    #@bulbs << @args.state.bulb1
    #@wires << Wire.new(640, 550, 960, 550)
    #@wires << Wire.new(960, 550, 960, 160)
    #@wires << Wire.new(960, 160, 320, 160)
    #@wires << Wire.new(320, 160, 320, 235)
  end

  def title_tick args
  end
  
  def iterate
    if @args.inputs.mouse.down && @args.inputs.mouse.inside_rect?(@args.state.switch1)
      if @args.state.switch1.path == 'sprites/specific/switch-hor-open.png'
        @args.state.switch1.path = 'sprites/specific/switch-hor-closed.png'
        @args.state.bulb1.path = 'sprites/specific/bulb-lit.png'
        @args.state.bulb1.x += 1
        @args.state.bulb1.y += 1
        @args.outputs.sounds << 'sounds/click.wav'
      elsif @args.state.switch1.path == 'sprites/specific/switch-hor-closed.png'
        @args.state.switch1.path = 'sprites/specific/switch-hor-open.png'
        @args.state.bulb1.path = 'sprites/specific/bulb-unlit.png'
        @args.state.bulb1.x -= 1
        @args.state.bulb1.y -= 1
        @args.outputs.sounds << 'sounds/click.wav'
      end
    end
  end

  def render
    @args.outputs.sprites << [@sprites, @bulbs, @switches]
    @args.outputs.solids << @wires
  end

  def gameplay_tick
    iterate
    render
  end
end



#===============================================
#                   MAIN LOOP
#===============================================

def tick args
  args.state.game = CDGame.new args
  args.state.game.gameplay_tick
end

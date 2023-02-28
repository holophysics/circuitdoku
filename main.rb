#todo  IMPLEMENT RENDER BY PICKING ITEMS FROM BRANCH_HASH, THEN ADDING TO OUTPUTS
#todo  GIVE EVERY CIRCUIT ELEMENT A "CONDUCTIVE" METHOD
#todo  IMPLEMENT ITERATE BY CHECKING THAT ALL ELEMENTS IN BRANCH HAVE CONDUCTIVE = TRUE, THEN LIGHTING ANY BULBS IN BRANCH
#todo  USE CIRCUIT CLASS    
#===============================================
#                     Classes
#===============================================

class Branch
  def initialize branch_hash p1, p2
    @branch_hash = branch_hash
  end

  def connection_point_1
    p1
  end

  def connection_point_2
    p2
  end
end
#================================================
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

  def initialize p1, p2
    self.x = get_x p1, p2
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
  

  def get_x p1, p2
    x1 = p1[:x]
    y1 = p1[:y]
    x2 = p2[:x]
    y2 = p2[:y]
    if x2 == x1
      x = x1 - (@@w / 2).round
    elsif y1 == y2
      x = x1
    end
    x
  end
  
  def get_y p1, p2
    x1 = p1[:x]
    y1 = p1[:y]
    x2 = p2[:x]
    y2 = p2[:y]
    if x2 == x1
      y = y1
    elsif y2 == y1
      y = y1 - (@@w / 2).round
    end
    y
  end
  
  def get_w p1, p2
    x1 = p1[:x]
    y1 = p1[:y]
    x2 = p2[:x]
    y2 = p2[:y]
    if x2 == x1
      w = @@w
    elsif y2 == y1
      w = x2 - x1
    end
    w
  end
  
  def get_h p1, p2
    x1 = p1[:x]
    y1 = p1[:y]
    x2 = p2[:x]
    y2 = p2[:y]
    if x2 == x1
      h = y2 - y1
    elsif y2 == y1
      h = @@w
    end
    h
  end

  def connection_point_1
    p1
  end

  def connection_point_2
    p2
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

  def initialize point1
    self.x = (point1[:x])
    self.y = (point1[:y] - @@H / 2)
    self.w = @@W
    self.h = @@H
    self.path = 'sprites/specific/switch-hor-open.png'
    @conductive = true
  end

  def toggle
    @conductive = !@conductive

    if @conductive
      path = "sprites/specific/switch-hor-closed.png"
    else
      path = "sprites/specific/switch-hor-open.png"
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

  def connection_point_1
    point1
  end

  def connection_point_2
    {x: point1[:x] + @@W, y: point1[:y]}
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

  def connection_point_1

  end

  def connection_point_2

  end
end
#===============================================
class Bulb < Sprite
  @@W = 98
  @@H = 134

  def initialize p1
    self.x = (p1[:x])
    self.y = (p1[:y] - @@H/5)
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

  def connection_point_1
    p1
  end

  def connection_point_2
    {x: p1[:x] + @@W, y: p1[:y]}
  end
end 
#===============================================
class Battery < Sprite
  @@W = 73
  @@H = 138

  def initialize p1
    self.x = p1[:x] - @@W/2
    self.y = p1[:y]
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

  def connection_point_1
    p1
  end

  def connection_point_2
    {x: p1[:x], y: p1[y] + @@H}
  end
end 
#===============================================
class Connector < Sprite
  @@SIZE = 6

  def initialize point
    self.x = point[:x]
    self.y = point[:y]
    self.w = @@SIZE
    self.h = @@SIZE
    self.path = 'sprites/specific/connector.png'
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

  def point
    point
  end
end 
#===============================================
#                     Game Class
#===============================================

class CDGame
  def initialize args
    @args = args
    @sprites = []
    @wires = []
    @bulbs = []
    @switches = []

    @circuit = Branch.new {
      battery_p: Battery.new {x: 320, y: 91},
      connector1: Connector.new @circuit[:battery_p].connection_point_2,
      wire1: Wire.new @circuit[:connector1].point, @circuit[:corner_connector1].point,
      corner_connector1: Connector.new @corners[lower_left],
      wire2: Wire.new @circuit[:corner_connector1].point, @circuit[:connector2].point,
      connector2: Connector.new {x: (@corners[:upper_left][:x] + @corners[:upper_right][:x]) / 3, y: @corners[:upper_left][:y]},
      switch_horizontal1: SwitchHorizontal.new , @circuit[:connector2.point],
      connector3: Connector.new @circuit[:switch_horizontal1].connection_point_2,
      wire3: Wire.new @circuit[:connector3].point, @circuit[connector4].point, 
      connector4: Connector.new {x: 2 * (@corners[:upper_left][:x] + @corners[:upper_right][:x]) / 3, y: @corners[:upper_right][:y]},
      bulb1: Bulb.new @circuit[:connector4].point,
      connector5: @circuit[:bulb1].connection_point_2,
      wire4: Wire.new @circuit[:connector5].point, @circuit[:corner_connector2].point,
      corner_connector2: Connector.new @corners[:upper_right],
      wire5: Wire.new @circuit[:corner_connector2].point, @circuit[:corner_connector3].point,
      corner_connector3: Connector.new @corners[:lower_right],
      wire6: Wire.new @circuit[:corner_connector3], @circuit[:corner_connector4],
      corner_connector4: Connector.new @corners[:lower_right],
      wire7: Wire.new @circuit[:corner_connector4].point, @circuit[:connector6].point, 
      connector6: Connector.new @circuit[:battery_p].connection_point_1,
      battery_n: nil
    }

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

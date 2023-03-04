#todo  IMPLEMENT RENDER BY PICKING ITEMS FROM BRANCH_ARRAY, THEN ADDING TO OUTPUTS
#todo  IMPLEMENT ITERATE BY CHECKING THAT ALL ELEMENTS IN BRANCH HAVE CONDUCTIVE = TRUE, THEN LIGHTING ANY BULBS IN BRANCH
#todo  USE CIRCUIT CLASS    
$gtk.reset

#===============================================
#                     Classes
#===============================================

class Branch
  attr_accessor :branch_array
  attr_reader :positive, :negative, :conductive

  def initialize branch_array, positive, negative
    @branch_array = branch_array
    @positive = positive
    @negative = negative
    @conductive = true
  end
end
#================================================
class Circuit
  attr_accessor :graph

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
  attr_reader :connection_point_1, :connection_point_2, :conductive
  @@w = 6

  def initialize p1, p2
    @x = get_x(p1, p2)
    @y = get_y(p1, p2)
    @w = get_w(p1, p2)
    @h = get_h(p1, p2)
    @connection_point_1 = p1
    @connection_point_2 = p2
    @conductive = true
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
      x = x1 - @@w / 2
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
    elsif y1 == y2
      y = y1 - (@@w / 2)
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
    elsif y1 == y2
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
    elsif y1 == y2
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
  attr_accessor :conductive
  attr_reader :connection_point_1, :connection_point_2

  @@W = 140
  @@H = 140

  def initialize point1
    @x = (point1[:x])
    @y = (point1[:y] - @@H / 2 + 3)
    @w = @@W
    @h = @@H
    @path = 'sprites/specific/switch-horizont-open.png'
    @conductive = false
    @connection_point_1 = point1
    @connection_point_2 = {x: point1[:x] + @@W * 9 / 10, y: point1[:y]}
  end

  def toggle
    @conductive = !@conductive

    if @conductive
      path = "sprites/specific/switch-horizont-closed.png"
    else
      path = "sprites/specific/switch-horizont-open.png"
    end
  end

  def serialize
    {
      x: x,
      y: y,
      w: w,
      h: h,
      path: path,
      blendmode_enum: blendmode_enum
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
  attr_reader :connection_point_1, :connection_point_2, :conductive

  @@W = 140
  @@H = 140

  def initialize point1
    @x = point1[:x] - @@W / 2
    @y = point1[:y]
    @w = @@W
    @h = @@H
    @path = "sprites/specific/switch-ver-open.png"
    @conductive = false
    @connection_point_1 = point1
    @connection_point_2 = {x: point1[:x], y: point1[:y] + @@H}
  end

  def toggle
    @conductive = !@conductive

    if @conductive == true
      path = "sprites/specific/switch-ver-closed.png"
    elsif @conductive == false
      path = "sprites/specific/switch-ver-open.png"
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
  attr_reader :conductive, :connection_point_1, :connection_point_2

  @@W = 98
  @@H = 134

  def initialize p1
    @x = (p1[:x])
    @y = (p1[:y] - @@H/5)
    @w = @@W
    @h = @@H
    @path = 'sprites/specific/bulb-unlit.png'
    @source_x = 40
    @source_y = 40
    @source_w = 900
    @source_h = 1200

    @conductive = true
    @connection_point_1 = {x: p1[:x] + @@W / 4, y: p1[:y]}
    @connection_point_2 = {x: p1[:x] + @@W * 7 / 12, y: p1[:y]}
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
  attr_reader :conductive, :connection_point_1, :connection_point_2

  @@W = 73
  @@H = 138

  def initialize p1
    @x = p1[:x] - @@W/2 - 4
    @y = p1[:y]
    @w = @@W
    @h = @@H
    @path = 'sprites/specific/battery.png'
    @connection_point_1 = {x: p1[:x] + 3, y: p1[:y] - 3}
    @connection_point_2 = {x: p1[:x] + 3, y: p1[:y] + @@H + 3}
    @conductive = true
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
  attr_reader :conductive, :point

  @@SIZE = 6

  def initialize point
    @x = point[:x] - @@SIZE / 2 + 3
    @y = point[:y] - @@SIZE / 2 + 3
    @w = @@SIZE
    @h = @@SIZE
    @path = 'sprites/specific/connector.png'
    @conductive = true
    @point = point
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
#                     Game Class
#===============================================

class CDGame
  def initialize args
    @args = args

    @corners = {
      lower_left: {x: 320, y: 160},
      upper_left: {x: 320, y: 550},
      upper_right: {x: 960, y: 550},
      lower_right: {x: 960, y: 160}
    }

    ulx = @corners[:upper_left][:x]
    uly = @corners[:upper_left][:y]
    urx = @corners[:upper_right][:x]
    ury = @corners[:upper_right][:y]
    lrx = @corners[:lower_right][:x]
    lry = @corners[:lower_right][:y]
    llx = @corners[:lower_left][:x]
    lly = @corners[:lower_left][:y]

    @branch = Branch.new( {}, {x: 320, y: 300 + 138}, {x: 320, y: 300} )
    @battery = Battery.new @branch.negative
    @bulb = Bulb.new({x: ulx + (urx - ulx) * 2 / 3, y: uly})
    @switch = SwitchHorizontal.new({x: ulx + (urx - ulx) / 4, y: uly}) 

    @connectors = [
      Connector.new(@battery.connection_point_2),
      Connector.new(@corners[:upper_left]),
      Connector.new(@switch.connection_point_1),
      Connector.new(@switch.connection_point_2),
      Connector.new(@bulb.connection_point_1),
      Connector.new(@bulb.connection_point_2),
      Connector.new(@corners[:upper_right]),
      Connector.new(@corners[:lower_right]),
      Connector.new(@corners[:lower_left]),
      Connector.new(@battery.connection_point_1)
    ]

    @wires = [
      make_wire(0, 1),
      make_wire(1, 2),
      make_wire(3, 4),
      make_wire(5, 6),
      make_wire(6, 7),
      make_wire(7, 8),
      make_wire(8, 9)
    ]

    @switches = [
      SwitchHorizontal.new(@connectors[2].point)
    ]

    @bulbs = [
      @bulb
    ]

    @branch_array = [
      
    ]
  end

  def make_wire a, b
    Wire.new(@connectors[a].point, @connectors[b].point)
  end

  def title_tick args
  end
  
  def iterate
    if @args.inputs.mouse.down && @args.inputs.mouse.inside_rect?(@switches[0])
      @switches[0].toggle
    end   
  end

  def render
    @args.outputs.sprites << [@battery, @connectors, @switches, @bulbs]
    @args.outputs.solids << [@wires]

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
  args.state.game ||= CDGame.new args
  args.state.game.gameplay_tick
end

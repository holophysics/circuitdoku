#todo  IMPLEMENT RENDER BY PICKING ITEMS FROM BRANCH_ARRAY, THEN ADDING TO OUTPUTS
#todo  IMPLEMENT ITERATE BY CHECKING THAT ALL ELEMENTS IN BRANCH HAVE CONDUCTIVE = TRUE, THEN LIGHTING ANY BULBS IN BRANCH
#todo  USE CIRCUIT CLASS    
#===============================================
#                     Classes
#===============================================

class Branch

  def initialize branch_hash, positive, negative
    @branch_hash = branch_hash
    @positive = positive
    @negative = negative
  end

  def branch_hash
    @branch_hash
  end

  def set_branch_hash new_hash
    @branch_hash = new_hash
  end
  def negative
    @negative
  end

  def positive
    @positive
  end

  def conductive
    true
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
    self.y = get_y p1, p2
    self.w = get_w p1, p2
    self.h = get_h p1, p2
    @p1 = p1
    @p2 = p2
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
    x + 3
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
    y + 3
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
    @p1
  end

  def connection_point_2
    @p2
  end

  def conductive
    true
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
  @@W = 200
  @@H = 200

  def initialize point1
    self.x = (point1[:x])
    self.y = (point1[:y] - @@H / 2 + 3)
    self.w = @@W
    self.h = @@H
    self.path = 'sprites/switch-horizont-open.png',
    @conductive = false
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

  def conductive
    @conductive
  end
end
#===============================================
class SwitchVertical < Sprite
  @@W = 160
  @@H = 160

  def initialize point1
    self.x = point1[:x] - @@W / 2
    self.y = point1[:y]
    self.w = @@W
    self.h = @@H
    self.path = "sprites/specific/switch-ver-open.png"
    @conductive = false
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

  def connection_point_1
    point1
  end

  def connection_point_2
    {x: point1[:x], y: point1[:y] + @@H}
  end

  def conductive
    @conductive
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
    {x: x + @@W / 2, y: y + @@H / 5}
  end

  def connection_point_2
    {x: x + @@W * 3 / 2, y: y + @@H / 5}
  end

  def conductive
    true
  end
end 
#===============================================
class Battery < Sprite
  @@W = 73
  @@H = 138

  def initialize p1
    self.x = p1[:x] - @@W/2 - 4
    self.y = p1[:y]
    self.w = @@W
    self.h = @@H
    self.path = 'sprites/specific/battery.png'
    @p1 = p1
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
    @p1
  end

  def connection_point_2
    {x: @p1[:x], y: @p1[y] + @@H}
  end
end 
#===============================================
class Connector < Sprite
  @@SIZE = 6

  def initialize point
    self.x = point[:x] - @@SIZE / 2
    self.y = point[:y] - @@SIZE / 2
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
    {x: x, y: y}
  end

  def conductive
    true
  end
end 
#===============================================
#                     Game Class
#===============================================

class CDGame
  def initialize args
    @args = args
    @sprites = []
    
    @bulbs = []

    @corners = {
      lower_left: {x: 320, y: 160},
      upper_left: {x: 320, y: 550},
      upper_right: {x: 960, y: 550},
      lower_right: {x: 960, y: 160}
    }

    @branch = Branch.new( {}, {x: 320, y: 300 + 138}, {x: 320, y: 300} )
    @battery = Battery.new get_branch.negative

    ulx = get_corners[:upper_left][:x]
    uly = get_corners[:upper_left][:y]
    urx = get_corners[:upper_right][:x]
    ury = get_corners[:upper_right][:y]
    lrx = get_corners[:lower_right][:x]
    lry = get_corners[:lower_right][:y]
    llx = get_corners[:lower_left][:x]
    lly = get_corners[:lower_left][:y]

    @connectors = [
      Connector.new({x: get_branch.positive[:x], y: get_branch.positive[:y] + 5}),
      Connector.new(get_corners[:upper_left]),
      Connector.new({x: ulx + (urx - ulx) / 4, y: uly}),
      Connector.new({x: ulx + (urx - ulx) / 3 + 160, y: uly}),
      Connector.new({x: ulx + (urx - ulx) * 2 / 3, y: uly}),
      Connector.new({x: ulx + (urx - ulx) * 2 / 3 + 98, y: uly}),
      Connector.new(get_corners[:upper_right]),
      Connector.new(get_corners[:lower_right]),
      Connector.new(get_corners[:lower_left]),
      Connector.new({x: get_branch.negative[:x], y: get_branch.negative[:y] - 8})
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
      SwitchHorizontal.new(get_connector[2].point)
    ]

    @bulbs = [
      Bulb.new(get_connector[4].point)
    ]

    @branch_array = [
      
    ]
  end

  def get_corners
    @corners
  end

  def get_branch
    @branch
  end

  def get_connector
    @connectors
  end

  def make_wire a, b
    Wire.new(get_connector[a].point, get_connector[b].point)
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
  args.state.game = CDGame.new args
  args.state.game.gameplay_tick
end

#===========================================================================
#                            Classes
#===========================================================================

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

class Wire < Solid

  def initialize x1, y1, x2, y2, w
    self.x = get_x x1, y1, x2, y2, w
    self.y = get_y x1, y1, x2, y2, w
    self.w = get_w x1, y1, x2, y2, w
    self.h = get_h x1, y1, x2, y2, w
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
  #===========================================================================
  def get_x x1, y1, x2, y2, w
    if x2 == x1
      x = x1 - (w / 2).round
    elsif y1 == y2
      x = x1
    end
    x
  end
  #===========================================================================
  def get_y x1, y1, x2, y2, w
    if x2 == x1
      y = y1
    elsif y2 == y1
      y = y1 - (w / 2).round
    end
    y
  end
  #===========================================================================
  def get_w x1, y1, x2, y2, w
    if x2 == x1
      w = w
    elsif y2 == y1
      w = x2 - x1
    end
    w
  end
  #===========================================================================
  def get_h x1, y1, x2, y2, w
    if x2 == x1
      h = y2 - y1
    elsif y2 == y1
      h = w
    end
    h
  end
end


class Sprite
  attr_accessor :x, :y, :w, :h, :path, :angle, :a, :r, :g, :b, :source_x,
                :source_y, :source_w, :source_h, :flip_horizontally,
                :flip_vertically, :angle_anchor_x, :angle_anchor_y

  def primitive_marker
    :sprite
  end
end

class Switch < Sprite
  def initialize x, y, w, h
    @x = x
    @y = y
    @w = w
    @h = h
    @path = 'sprites/specific/switch.png'
  end
end

class Bulb < Sprite
  def initialize x, y, w, h
    @x = x
    @y = y
    @w = w
    @h = h
    @path = 'sprites/specific/bulb_unlit.png'
  end
end

class Battery < Sprite
  def initialize x, y, w, h
    @x = x
    @y = y
    @w = w
    @h = h
    @path = 'sprites/specific/battery.png'
  end
end 

class Connector < Sprite
  def initialize x, y, w, h
    @x = x
    @y = y
    @w = w
    @h = h
    @path = 'sprites/specific/connector.png'
  end
end 

#===========================================================================
#                            Scenes
#===========================================================================

def title_tick args

end

def gameplay_tick args
  
end

#===========================================================================
#                            MAIN LOOP
#===========================================================================

def tick args
  args.outputs.solids << Wire.new(220, 280, 640, 280, 6)
end

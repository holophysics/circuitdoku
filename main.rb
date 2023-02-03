class Circuit
  def initialize graph
    self.graph = graph
  end
end

class Solid
  attr_accessor :x, :y, :w, :h, :r, :g, :b, :a_x

  def primitive_marker
    :solid
  end
end

class Wire < Solid
  def initialize x, y, w, h
    self.x = x
    self.y = y
    self.w = w
    self.h = h
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
    self.x = x
    self.y = y
    self.w = w
    self.h = h
    self.path = 'sprites/specific/switch.png'
  end
end

class Bulb < Sprite
  def initialize x, y, w, h
    self.x = x
    self.y = y
    self.w = w
    self.h = h
    self.path = 'sprites/specific/bulb_unlit.png'
  end
end

class Battery < Sprite
  def initialize x, y, w, h
    self.x = x
    self.y = y
    self.w = w
    self.h = h
    self.path = 'sprites/specific/battery.png'
  end
end 

class Connector < Sprite
  def initialize x, y, w, h
    self.x = x
    self.y = y
    self.w = w
    self.h = h
    self.path = 'sprites/specific/connector.png'
  end
end 

def tick args
  
end

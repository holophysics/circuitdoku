#===========================================================================
#                            Classes
#===========================================================================

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
  width = 6
  def initialize x1, y1, x2, y2
    self.x = get_x x1, y1, x2, y2
    self.y = y
    self.w = w
    self.h = h
  end
  #===========================================================================
  def get_x x1, y1, x2, y2
    if x2 == x1
      x = x1 - (width / 2).round
    elsif y1 == y2
      x = x1
    end
    x
  end
  #===========================================================================
  def get_y x1, y1, x2, y2
    if x2 == x1
      y = y1
    elsif y2 == y1
      y = y1 - (width / 2).round
    end
    
    
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
  
end

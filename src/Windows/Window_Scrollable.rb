#==============================================================================
# ** Window_Scrollable
#------------------------------------------------------------------------------
#  This window contains scroll functions
#==============================================================================

class Window_Scrollable < Window_Base
  
  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Scroll speed
  attr_accessor :scroll_speed
  # True to scroll horizontally, else false
  attr_accessor :horizontal_scroll
  
  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object initialization
  #     x : window X coordinate
  #     y : window Y coordinate
  #     width : window width
  #     height : window height
  #     scroll_speed : scroll speed
  #     horizontal_scroll : true to scroll horizontally, else false
  #--------------------------------------------------------------------------
  def initialize(x, y, width, height, scroll_speed=8, horizontal_scroll=false)
    super(x, y, width, height)
    self.scroll_speed = scroll_speed
    self.horizontal_scroll = horizontal_scroll
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Frame update
  #--------------------------------------------------------------------------
  def update
    super
    if self.active
      if !horizontal_scroll
        # Scroll vertically
        scroll_max = [self.contents.height - (self.height - 32), 0].max
        if Input.press?(Input::UP)
          self.oy = [self.oy - self.scroll_speed, 0].max
        elsif Input.press?(Input::DOWN)
          self.oy = [self.oy + self.scroll_speed, scroll_max].min
        elsif Input.repeat?(Input::L)
          self.oy = [self.oy - (self.height - 32), 0].max
        elsif Input.repeat?(Input::R)
          self.oy = [self.oy + (self.height - 32), scroll_max].min
        end
      else
        # Scroll horizontally
        scroll_max = [self.contents.width - (self.width - 32), 0].max
        if Input.press?(Input::LEFT)
          self.ox = [self.ox - self.scroll_speed, 0].max
        elsif Input.press?(Input::RIGHT)
          self.ox = [self.ox + self.scroll_speed, scroll_max].min
        elsif Input.repeat?(Input::L)
          self.ox = [self.ox - (self.width - 32), 0].max
        elsif Input.repeat?(Input::R)
          self.ox = [self.ox + (self.width - 32), scroll_max].min
        end
      end
    end
  end
  
end

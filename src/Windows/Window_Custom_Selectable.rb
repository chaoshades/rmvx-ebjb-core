#==============================================================================
# ** Window_Custom_Selectable
#------------------------------------------------------------------------------
#  This window contains custom cursor movement functions
#==============================================================================

class Window_Custom_Selectable < Window_Base
  
  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Positions count
  attr_reader   :item_max
  # Array fo CursorPosition objects (see CursorPosition)
  attr_reader   :positions
  # Cursor position
  attr_reader   :index                   
  
  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     x       : window X coordinate
  #     y       : window Y coordinate
  #     width   : window width
  #     height  : window height
  #     positions : array of CursorPosition object
  #     isUpDown : true to move cursor Up/Down instead of Left/Right, else false
  #--------------------------------------------------------------------------
  def initialize(x, y, width, height, positions, isUpDown=false)
    super(x, y, width, height)
    @index = -1
    @positions = positions
    @item_max = positions.size if positions != nil
    @isUpDown = isUpDown
    self.index = 0 if positions != nil
  end

  #//////////////////////////////////////////////////////////////////////////
  # * Properties
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Set Cursor Position
  #--------------------------------------------------------------------------
  def index=(index)
    @index = index
    update_cursor
  end

  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Determine if cursor is moveable
  #--------------------------------------------------------------------------
  def cursor_movable?
    return false if (not visible or not active)
    return false if (index < 0 or index > @item_max or @item_max == 0)
    return false if (@opening or @closing)
    return true
  end

  #--------------------------------------------------------------------------
  # * Move cursor right
  #     wrap : Wraparound allowed
  #--------------------------------------------------------------------------
  def cursor_right(wrap = false)
    if (@index < @item_max - 1 || wrap)

      temp_index = (@index + 1) % @item_max
      while !@positions[temp_index].enabled
        temp_index = (temp_index + 1) % @item_max
      end
      
      if (temp_index > @index || wrap)
        @index = temp_index
      end
    end
  end
  
  #--------------------------------------------------------------------------
  # * Move cursor left
  #     wrap : Wraparound allowed
  #--------------------------------------------------------------------------
  def cursor_left(wrap = false)
    if (@index > 0 || wrap)

      temp_index = (@index - 1 + @item_max) % @item_max
      while !@positions[temp_index].enabled
        temp_index = (temp_index - 1 + @item_max) % @item_max
      end
      
      if (temp_index < @index || wrap)
        @index = temp_index
      end
    end
  end
  
  #--------------------------------------------------------------------------
  # * Frame Update
  #--------------------------------------------------------------------------
  def update
    super
    if cursor_movable?
      last_index = @index
      if !@isUpDown
        if Input.repeat?(Input::RIGHT)
          cursor_right(Input.trigger?(Input::RIGHT))
        end
        if Input.repeat?(Input::LEFT)
          cursor_left(Input.trigger?(Input::LEFT))
        end
      else
        if Input.repeat?(Input::UP)
          cursor_left(Input.trigger?(Input::UP))
        end
        if Input.repeat?(Input::DOWN)
          cursor_right(Input.trigger?(Input::DOWN))
        end
      end
      if @index != last_index
        Sound.play_cursor
        update_cursor
      end
    end
  end
  
  #--------------------------------------------------------------------------
  # * Update cursor
  #--------------------------------------------------------------------------
  def update_cursor
    if @index < 0                   # If the cursor position is less than 0
      self.cursor_rect.empty        # Empty cursor
    else                            # If the cursor position is 0 or more
      self.cursor_rect = @positions[@index].rect  # Refresh cursor rectangle
    end
  end
  
end

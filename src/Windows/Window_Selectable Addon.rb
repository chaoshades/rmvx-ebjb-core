#==============================================================================
# ** Window_Selectable Addon
#------------------------------------------------------------------------------
#  Addon functions for cursor movement and scroll
#==============================================================================

class Window_Selectable < Window_Base
  
  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Window line height
  attr_reader   :line_h
  # True to show the cursor, else false
  attr_reader   :visible_cursor
  # True to block cursor from moving, else false
  attr_writer   :block_cursor
  # Items alignment
  #   0 - Left
  #   1 - Middle
  #   2 - Right
  attr_reader   :align
  # Pointer on the detail window
  attr_reader   :detail_window
  
  #//////////////////////////////////////////////////////////////////////////
  # * Private Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # True to select all items with the cursor, else false
  @select_all = false
  
  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     x       : window X coordinate
  #     y       : window Y coordinate
  #     width   : window width
  #     height  : window height
  #     spacing : width of empty space when items are arranged horizontally
  #     line_h  : window line height
  #     visible_cursor : true to show the cursor, else false
  #     line_w  : window line width
  #     align : items alignment
  #--------------------------------------------------------------------------
  def initialize(x, y, width, height, spacing = 32, line_h = WLH, 
                 visible_cursor = true, line_w = 0, align = 0)
    @block_cursor = false
    @item_max = 1
    @column_max = 1
    @index = -1
    @spacing = spacing
    @line_h = line_h
    @visible_cursor = visible_cursor
    @line_w = line_w
    @align = align
    super(x, y, width, height)
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Properties
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Set Cursor Position
  #--------------------------------------------------------------------------
  def index=(index)
    @select_all = false
    @block_cursor = false
    @index = index
    update_cursor
    call_update_help
    if @detail_window != nil
      if !self.is_switchable && @detail_window.visible
        switch_windows()
      end
    end
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Create Window Contents
  #--------------------------------------------------------------------------
  def create_contents
    self.contents.dispose
    self.contents = Bitmap.new(width - 32, [height - 32, row_max * @line_h].max)
  end
  
  #--------------------------------------------------------------------------
  # * Determine if cursor is moveable
  #--------------------------------------------------------------------------
  alias cursor_movable_ebjb? cursor_movable? unless $@
  def cursor_movable?
    return false if @block_cursor
    return false if @select_all
    return cursor_movable_ebjb?
  end
  
  #--------------------------------------------------------------------------
  # * Get Top Row
  #--------------------------------------------------------------------------
  def top_row
    return self.oy / @line_h
  end
  
  #--------------------------------------------------------------------------
  # * Set Top Row
  #     row : row shown on top
  #--------------------------------------------------------------------------
  def top_row=(row)
    row = 0 if row < 0
    row = row_max - 1 if row > row_max - 1
    self.oy = row * @line_h
  end
  
  #--------------------------------------------------------------------------
  # * Get Number of Rows Displayable on 1 Page
  #--------------------------------------------------------------------------
  def page_row_max
    return (self.height - 32) / @line_h
  end
  
  #--------------------------------------------------------------------------
  # * Move cursor down
  #     wrap : Wraparound allowed
  #--------------------------------------------------------------------------
  def cursor_down(wrap = false)
    if (@index < @item_max - @column_max) or (wrap and @column_max == 1)
      Sound.play_cursor
      self.index = (@index + @column_max) % @item_max
    end
  end
  
  #--------------------------------------------------------------------------
  # * Move cursor up
  #     wrap : Wraparound allowed
  #--------------------------------------------------------------------------
  def cursor_up(wrap = false)
    if (@index >= @column_max) or (wrap and @column_max == 1)
      Sound.play_cursor
      self.index = (@index - @column_max + @item_max) % @item_max
    end
  end
  
  #--------------------------------------------------------------------------
  # * Move cursor right
  #     wrap : Wraparound allowed
  #--------------------------------------------------------------------------
  def cursor_right(wrap = false)
    if (@column_max >= 2) and
       (@index < @item_max - 1 or (wrap and page_row_max == 1))
      Sound.play_cursor
      self.index = (@index + 1) % @item_max
    end
  end
  
  #--------------------------------------------------------------------------
  # * Move cursor left
  #     wrap : Wraparound allowed
  #--------------------------------------------------------------------------
  def cursor_left(wrap = false)
    if (@column_max >= 2) and
       (@index > 0 or (wrap and page_row_max == 1))
      Sound.play_cursor
      self.index = (@index - 1 + @item_max) % @item_max
    end
  end
  
  #--------------------------------------------------------------------------
  # * Move cursor one page down
  #--------------------------------------------------------------------------
  def cursor_pagedown
    if top_row + page_row_max < row_max
      Sound.play_cursor
      self.top_row += page_row_max
      self.index = [@index + page_item_max, @item_max - 1].min
    end
  end
  
  #--------------------------------------------------------------------------
  # * Move cursor one page up
  #--------------------------------------------------------------------------
  def cursor_pageup
    if top_row > 0
      Sound.play_cursor
      self.top_row -= page_row_max
      self.index = [@index - page_item_max, 0].max
    end
  end
  
  #--------------------------------------------------------------------------
  # * Select all items with the cursor
  #--------------------------------------------------------------------------
  def cursor_select_all
    @select_all = true
    update_cursor
  end
  
  #--------------------------------------------------------------------------
  # * Get rectangle for displaying items
  #     index : item number
  #     adjust_rect_x : true to adjust rect (x, width only) when cursor is visible to avoid
  #                   drawn controls to override cursor, else false 
  #     adjust_rect_y : true to adjust rect (y, height only) when cursor is visible to avoid
  #                   drawn controls to override cursor, else false 
  #--------------------------------------------------------------------------
  def item_rect(index, adjust_rect_x=false, adjust_rect_y=false)
    rect = Rect.new(0, 0, 0, 0)
    if @line_w > 0
      rect.width = @line_w
    else
      rect.width = (contents.width + @spacing) / @column_max - @spacing
    end
    rect.height = @line_h
    
    x = index % @column_max * (rect.width + @spacing)

    if @line_w > 0
      case @align 
      when 0 # Left
        rect.x = x
      when 1 # Middle
        rect.x = x + contents.width/2 - (@column_max * (rect.width + @spacing))/2
      when 2 # Right
        rect.x = x + contents.width - (@column_max * (rect.width + @spacing))
      else
        rect.x = 0
      end
    else
      rect.x = x
    end
   
    rect.y = index / @column_max * @line_h
    
    if adjust_rect_x && @visible_cursor
      rect.x += 2
      rect.width -= 4
    end
    
    if adjust_rect_y && @visible_cursor
      rect.y += 2
      rect.height -= 4
    end
    
    return rect
  end
  
  #--------------------------------------------------------------------------
  # * Update cursor
  #--------------------------------------------------------------------------
  def update_cursor      
    if @index < 0                   # If the cursor position is less than 0
      self.cursor_rect.empty        # Empty cursor
    else                            # If the cursor position is 0 or more
      row = @index / @column_max    # Get current row
      if row < top_row              # If before the currently displayed
        self.top_row = row          # Scroll up
      end
      if row > bottom_row           # If after the currently displayed
        self.bottom_row = row       # Scroll down
      end
      if @visible_cursor
        if @select_all
          self.cursor_rect = Rect.new(0,0,self.contents.width, self.contents.height)
        else
          rect = item_rect(@index)      # Get rectangle of selected item
          rect.y -= self.oy             # Match rectangle to scroll position
          self.cursor_rect = rect       # Refresh cursor rectangle
        end
      else
        self.cursor_rect.empty 
      end
    end
  end
  
  #--------------------------------------------------------------------------
  # * Frame Update
  #--------------------------------------------------------------------------
  def update
    super
    if cursor_movable?
      if Input.repeat?(Input::DOWN)
        cursor_down(Input.trigger?(Input::DOWN))
      end
      if Input.repeat?(Input::UP)
        cursor_up(Input.trigger?(Input::UP))
      end
      if Input.repeat?(Input::RIGHT)
        cursor_right(Input.trigger?(Input::RIGHT))
      end
      if Input.repeat?(Input::LEFT)
        cursor_left(Input.trigger?(Input::LEFT))
      end
      if Input.repeat?(Input::R)
        cursor_pagedown
      end
      if Input.repeat?(Input::L)
        cursor_pageup
      end
    end
    
    if Input.trigger?(Input::X)
      if self.active && self.is_switchable
        switch_windows()
      end
    end
    
  end
  
  #--------------------------------------------------------------------------
  # * Gets current data
  #--------------------------------------------------------------------------
  def current_data
    return @data
  end
  
  #--------------------------------------------------------------------------
  # * Set Detail Window
  #     detail_window : new detail window
  #--------------------------------------------------------------------------
  def detail_window=(detail_window)
    @detail_window = detail_window
    call_update_detail
  end
  
  #--------------------------------------------------------------------------
  # * Call detail window update method
  #--------------------------------------------------------------------------
  def call_update_detail
    if self.active and @detail_window != nil and self.is_switchable
       update_detail
    end
  end
  
  #--------------------------------------------------------------------------
  # * Update detail window (contents are defined by the subclasses)
  #--------------------------------------------------------------------------
  def update_detail
  end
  
  #--------------------------------------------------------------------------
  # * Determine if help/detail window can be switched (contents are defined by the subclasses)
  #--------------------------------------------------------------------------
  def is_switchable
  end
  
  #--------------------------------------------------------------------------
  # * Alias call help window update method
  #--------------------------------------------------------------------------
  alias call_update_help_ebjb call_update_help unless $@
  def call_update_help
    call_update_help_ebjb
    call_update_detail
  end
  
  #--------------------------------------------------------------------------
  # * Switch help/detail window
  #--------------------------------------------------------------------------
  def switch_windows
    if @help_window != nil && @detail_window != nil
      @help_window.visible = !@help_window.visible
      @detail_window.visible = !@detail_window.visible
    end
  end
  
end

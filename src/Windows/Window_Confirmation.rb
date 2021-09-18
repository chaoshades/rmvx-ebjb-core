#==============================================================================
# ** Window_Confirmation
#------------------------------------------------------------------------------
#  This window shows a Yes/No choice with a confirmation message
#==============================================================================

class Window_Confirmation < Window_Selectable
  
  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Label control for the text to display
  attr_reader   :cText

  #//////////////////////////////////////////////////////////////////////////
  # * Private Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Commands list
  @commands = nil
  # Default command index
  @default_index = nil
  # Number of lines for auto-height-resize
  @lines = nil
  
  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     x : window X coordinate
  #     y : window Y coordinate
  #     width : window width
  #     text : text to display
  #     yes_command : YES command text (default Yes)
  #     no_command : NO command text (default No)
  #     default_index : default command index (No by default)
  #--------------------------------------------------------------------------
  def initialize(x, y, width, text, yes_command="Yes", no_command="No",
                 default_index=1)
    column_max = 2
    @commands = [yes_command, no_command]
    row_max = (@commands.size + column_max - 1) / column_max
    
    dummy = Bitmap.new(1,1)
    dummy.font = Font.bold_font
    @lines = dummy.split_multiline(Rect.new(0,0,width-32,WLH), text, 3).size
    dummy.dispose
    dummy = nil
    
    #row_max+lines to keep the text label over the commands
    super(x, y, width, (row_max+@lines) * WLH + 32, 32)
    @column_max = column_max
    @item_max = @commands.size
    @default_index = default_index
    @cText = CLabel.new(self, Rect.new(0,0,width-32,WLH), text, 1, Font.bold_font)
    @cText.multiline = true
    @cText.multiline_resize = true
    refresh
    self.index = @default_index
  end
  
  #--------------------------------------------------------------------------
  # * Refresh
  #--------------------------------------------------------------------------
  def refresh
    self.contents.clear
    @cText.draw()
    # override the font of the label (because we can only change the font of
    # all of the contents in the window)
    self.contents.font = Font.normal_font
    for i in 0..@item_max-1
      draw_item(i)
    end
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Show the confirmation window
  #--------------------------------------------------------------------------
  def show()
    self.active = true
    self.visible = true
  end
  
  #--------------------------------------------------------------------------
  # * Hide the confirmation window
  #--------------------------------------------------------------------------
  def hide()
    self.active = false
    self.visible = false
    self.index = @default_index
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Private Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Draw Item
  #     index : item number
  #--------------------------------------------------------------------------
  def draw_item(index)
    rect = item_rect(index)
    rect.x += 4
    rect.width -= 8
    self.contents.draw_text(rect, @commands[index])
  end
  private:draw_item
  
  #--------------------------------------------------------------------------
  # * Get rectangle for displaying items
  #     index : item number
  #--------------------------------------------------------------------------
  def item_rect(index)
    rect = Rect.new(0, 0, 0, 0)
    rect.width = (contents.width + @spacing) / @column_max - @spacing
    rect.height = WLH
    rect.x = index % @column_max * (rect.width + @spacing)
    # WLH is added for each line to draw the items below the multiline label
    rect.y = (@lines*WLH) + (index / @column_max * WLH)
    return rect
  end
  private:item_rect

end

#==============================================================================
# ** Window_Info_Help
#------------------------------------------------------------------------------
#  This window shows different types of help or explanations
#==============================================================================

class Window_Info_Help < Window_Scrollable
  
  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Label control for the text to display
  attr_reader :cText
  
  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     x : window X coordinate
  #     y : window Y coordinate
  #     width : window width
  #     height : window height
  #     text : text to display
  #--------------------------------------------------------------------------
  def initialize(x, y, width, height, text)
    super(x, y, width, height)
    
    @cText = CLabel.new(self, Rect.new(0,0,self.contents.width,WLH), "")
    @cText.multiline = true
    @cText.multiline_resize = true
    
    window_update(text)
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Update
  #     text : new text to display
  #--------------------------------------------------------------------------
  def window_update(text)
    if text != nil
      @cText.text = text
    end
    refresh()
  end
  
  #--------------------------------------------------------------------------
  # * Refresh
  #--------------------------------------------------------------------------
  def refresh()
    self.contents.clear
    @cText.draw()
  end
  
end
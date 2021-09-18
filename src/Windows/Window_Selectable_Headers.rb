#==============================================================================
# ** Window_Selectable_Headers
#------------------------------------------------------------------------------
#  This window adds headers to a Window_Selectable window
#==============================================================================

class Window_Selectable_Headers < Window_Base
  
  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Pointer on the window selectable which needs the headers
  attr_reader :selectable_window
  # Headers height
  attr_reader :header_height
  # Label controls list for the headers
  attr_reader :cHeaders
  
  #//////////////////////////////////////////////////////////////////////////
  # * Properties
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Set also the selectable window X property
  #--------------------------------------------------------------------------
  def x=(x)
    super(x)
    @selectable_window.x = x
  end
  
  #--------------------------------------------------------------------------
  # * Set also the selectable window Y property
  #--------------------------------------------------------------------------
  def y=(y)
    super(y)
    @selectable_window.y = y+@header_height+8
  end
  
  #--------------------------------------------------------------------------
  # * Set also the selectable window Z property
  #--------------------------------------------------------------------------
  def z=(z)
    super(z)
    @selectable_window.z = self.z + 1
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     selectable_window : window selectable which needs the headers
  #     header_height : headers height
  #--------------------------------------------------------------------------
  def initialize(selectable_window, header_height=WLH)
    @selectable_window = selectable_window
    @header_height = header_height
    super(selectable_window.x, selectable_window.y, 
          selectable_window.width, selectable_window.height+header_height+8)
    selectable_window.opacity = 0
    @cHeaders = []
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Refresh
  #--------------------------------------------------------------------------
  def refresh()
    self.contents.clear
    @cHeaders.each() { |cHeader| cHeader.draw() }
  end
  
  #--------------------------------------------------------------------------
  # * Add new header
  #     text : text of the header
  #     x : x position of the header
  #     width : width of the header
  #     align : header alignment
  #     font : header font
  #--------------------------------------------------------------------------
  def addHeader(text, x, width, align=0, font=nil)
    @cHeaders.push(CLabel.new(self, Rect.new(x,0,width,@header_height), 
                              text, align, font))
  end
  
end

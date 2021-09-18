#==============================================================================
# ** CLabel
#------------------------------------------------------------------------------
#  Represents a Label control on a window
#==============================================================================

class CLabel < Control
  
  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Rectangle to position the control
  attr_accessor :rect
  # Text to draw in the label
  attr_accessor :text
  # Text alignment (see Window_Base Addon)
  attr_accessor :align
  # Text font
  attr_accessor :font
  # True to draw the text in multiline, else false
  attr_accessor :multiline
  # Multiline mode (see Window_Base Addon)
  attr_accessor :multiline_mode
  # True to automatically resize bitmap to fits text contents, else false
  attr_accessor :multiline_resize
  # True to cut the text if it is too long, else false
  attr_accessor :cut_overflow
  
  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     window : window in which the control will be drawn
  #     rect : rectangle to position the control
  #     text : text to draw in the label
  #     align : text alignment
  #     font : text font
  #     multiline : true to draw the text in multiline, else false
  #     cut_overflow : true to cut the text if it is too long, else false
  #     multiline_mode : multiline mode (see Window_Base Addon)
  #     multiline_resize : true to automatically resize bitmap to fits text contents, else false
  #     active : control activity
  #     visible : control visibility
  #--------------------------------------------------------------------------
  def initialize(window, rect, text, align=0, font=nil, multiline=false, 
                 cut_overflow=false, multiline_mode=0, multiline_resize=false,
                 active=true, visible=true)
    super(window, active, visible)
    self.rect = rect
    self.text = text
    self.align = align
    if font.nil?
      self.font = Font.normal_font()
    else
      self.font = font
    end
    self.multiline = multiline
    self.multiline_mode = multiline_mode
    self.cut_overflow = cut_overflow
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Draw the control on the window
  #--------------------------------------------------------------------------
  def draw()
    if visible
      bitmap.font = self.font

      if !active
        bitmap.font.color.alpha = Font.inactive_alpha()
      end
      
      if self.multiline
        if self.multiline_resize
          lines = bitmap.split_multiline(self.rect, self.text, 3)
      
          if (self.rect.height * lines.size) > bitmap.height
            update_bitmap_size(self.rect.width, (self.rect.height * lines.size))
          end
        end
        bitmap.draw_multiline_text(self.rect, self.text, self.align, self.multiline_mode)
      elsif self.cut_overflow
        bitmap.draw_cut_overflow_text(self.rect, self.text, self.align)
      else
        bitmap.draw_text(self.rect, self.text, self.align)
      end
    end
  end
  
end

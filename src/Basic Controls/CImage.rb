#==============================================================================
# ** CImage
#------------------------------------------------------------------------------
#  Represents an Image control on a window
#==============================================================================

class CImage < Control
  
  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Rectangle to position the control
  attr_accessor :rect
  # Bitmap object containing the image to show
  attr_accessor :img_bitmap
  # Rectangle of the image to get in the bitmap
  attr_accessor :src_rect
  # Image alignment
  #   0 - Left
  #   1 - Middle
  #   2 - Right
  attr_accessor :align
  # Image opacity
  attr_accessor :opacity
  # Image vertical alignment
  #   0 - Top
  #   1 - Middle
  #   2 - Bottom
  attr_accessor :valign

  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     window : window in which the control will be drawn
  #     rect : rectangle to position the control
  #     img_bitmap : bitmap object containing the image to show
  #     src_rect : rectangle of the image to get in the bitmap
  #     align : image alignment
  #     opacity : image opacity
  #     valign : image vertical alignment
  #     mirror : true to flip the image horizontally, else false
  #     active : control activity
  #     visible : control visibility
  #--------------------------------------------------------------------------
  def initialize(window, rect, img_bitmap, src_rect, align=0, opacity=255, 
                 valign=0, active=true, visible=true)
    super(window, active, visible)
    self.rect = rect
    self.img_bitmap = img_bitmap
    self.src_rect = src_rect
    self.align = align
    self.opacity = opacity
    self.valign = valign
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Draw the control on the window
  #--------------------------------------------------------------------------
  def draw()
    if visible
      
      case self.align 
      when 0 # Left
        x = self.rect.x
      when 1 # Middle
        x = self.rect.x + self.rect.width/2 - self.src_rect.width/2
      when 2 # Right
        x = self.rect.x + self.rect.width - self.src_rect.width
      else
        x = 0
      end
      
      case self.valign 
      when 0 # Top
        y = self.rect.y
      when 1 # Middle
        y = self.rect.y + self.rect.height/2 - self.src_rect.height/2
      when 2 # Bottom
        y = self.rect.y + self.rect.height - self.src_rect.height
      else
        y = 0
      end

      if !active
        opacity = Font.inactive_alpha()
      else
        opacity = self.opacity
      end
      
      bitmap.blt(x, y, self.img_bitmap, self.src_rect, opacity)
    end
  end
  
end

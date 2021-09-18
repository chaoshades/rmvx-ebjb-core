#==============================================================================
# ** CResizableImage
#------------------------------------------------------------------------------
#  Represents a ResizableImage control on a window
#==============================================================================

class CResizableImage < CImage
  
  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Resize mode
  #   0 - Full resize to fit in rectangle size (can't be aligned since will fit the rectangle)
  #   1 - Width only to fit in rectangle size
  #   2 - Height only to fit in rectangle size
  #   3 - Full resize to fit in rectangle size by respecting image ratio
  attr_accessor :resize_mode
  
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
  #     resize_mode : resize mode (see Attributes section)
  #     active : control activity
  #     visible : control visibility
  #--------------------------------------------------------------------------
  def initialize(window, rect, img_bitmap, src_rect, align=0, opacity=255, 
                 valign=0, resize_mode=0, active=true, visible=true)
    super(window, rect, img_bitmap, src_rect, align, opacity, 
          valign, active, visible)
    self.resize_mode = resize_mode
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Draw the control on the window
  #--------------------------------------------------------------------------
  def draw()
    if visible
      temp_rect = Rect.new(self.src_rect.x, self.src_rect.y, 
                           self.src_rect.width, self.src_rect.height)
      
      case self.resize_mode
      when 0 #Full resize to fit in rectangle size
#~         bw = self.img_bitmap.width
#~         bh = self.img_bitmap.height
#~         if bw > self.rect.width
#~           bw = self.rect.width
#~            bh *= self.rect.width / self.img_bitmap.width.to_f
#~         end
#~         if bh > self.rect.height
#~           bh = self.rect.height
#~           bw *= self.rect.height / self.img_bitmap.height.to_f
#~         end
        temp_rect.width = self.rect.width
        temp_rect.height = self.rect.height
      when 1 #Width only to fit in rectangle size
#~         bw = self.img_bitmap.width
#~         if bw > self.rect.width
#~           bw = self.rect.width
#~         end
        temp_rect.width = self.rect.width
      when 2 #Height only to fit in rectangle size
#~         bh = self.img_bitmap.height
#~         if bh > self.rect.height
#~           bh = self.rect.height
#~         end
        temp_rect.height = self.rect.height
      when 3 #Full resize to fit in rectangle size by respecting image ratio
        bw = self.img_bitmap.width
        bh = self.img_bitmap.height
        if (self.rect.height / self.img_bitmap.height.to_f) > 
           (self.rect.width / self.img_bitmap.width.to_f)
          ratio = self.rect.width / self.img_bitmap.width.to_f
        else
          ratio = self.rect.height / self.img_bitmap.height.to_f
        end
        bw *= ratio
        bh *= ratio
        temp_rect.width = bw.floor
        temp_rect.height = bh.floor
      end
      
      case self.align 
      when 0 #Left
        x = self.rect.x
      when 1 #Middle
        x = self.rect.x + self.rect.width/2 - temp_rect.width/2
      when 2 #Right
        x = self.rect.x + self.rect.width - temp_rect.width
      else
        x = 0
      end

      case self.valign 
      when 0 #Top
        y = self.rect.y
      when 1 #Middle
        y = self.rect.y + self.rect.height/2 - temp_rect.height/2
      when 2 #Bottom
        y = self.rect.y + self.rect.height - temp_rect.height
      else
        y = 0
      end

      if !active
        opacity = Font.inactive_alpha()
      else
        opacity = self.opacity
      end
      
      bitmap.stretch_blt(Rect.new(x, y, temp_rect.width, temp_rect.height), 
                                  self.img_bitmap, self.src_rect, 
                                  opacity)
    end
  end
  
end

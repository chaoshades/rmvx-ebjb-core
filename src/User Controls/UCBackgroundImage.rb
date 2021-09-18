#==============================================================================
# ** UCBackgroundImage
#------------------------------------------------------------------------------
#  Represents an Image as the background of a window
#==============================================================================

class UCBackgroundImage < UserControl
  
  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Image control
  attr_reader :cImage
  # Name of the image in Cache.picture
  attr_accessor :image
  
  #//////////////////////////////////////////////////////////////////////////
  # * Properties
  #//////////////////////////////////////////////////////////////////////////
  #--------------------------------------------------------------------------
  # * Set of the user control visibility
  #--------------------------------------------------------------------------
  def visible=(visible)
    @visible = visible
    @cImage.visible = visible
  end

  #--------------------------------------------------------------------------
  # * Set of the user control activity
  #--------------------------------------------------------------------------
  def active=(active)
    @active = active
    @cImage.active = active
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     window : window in which the control will be drawn
  #     image : name of the image in Cache.picture
  #     align : background image alignment
  #     opacity : background image opacity
  #     valign : background image vertical alignment
  #     active : control activity
  #     visible : control visibility
  #--------------------------------------------------------------------------
  def initialize(window, image, align=0, opacity=255, valign=0, active=true, visible=true)
    super(active, visible)
    self.image = image
    @cImage = CImage.new(window, Rect.new(0, 0, window.width, window.height), 
                         nil, nil, align, opacity, valign, active, visible)
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Draw the background image on the window
  #--------------------------------------------------------------------------
  def draw()
    if self.image != nil
      bitmap = Cache.picture(self.image)
      @cImage.img_bitmap = bitmap
      @cImage.src_rect = Rect.new(0, 0, bitmap.width, bitmap.height)
      @cImage.draw()
    end
  end
  
end

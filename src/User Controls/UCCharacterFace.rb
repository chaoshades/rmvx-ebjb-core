#==============================================================================
# ** UCCharacterFace
#------------------------------------------------------------------------------
#  Represents an actor's character face on a window
#==============================================================================

class UCCharacterFace < UserControl
  
  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Image control to draw the character face
  attr_reader   :cCharFace
  # Actor object
  attr_accessor :actor
  
  #//////////////////////////////////////////////////////////////////////////
  # * Properties
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Set of the user control visibility
  #--------------------------------------------------------------------------
  def visible=(visible)
    @visible = visible
    @cCharFace.visible = visible
  end

  #--------------------------------------------------------------------------
  # * Set of the user control activity
  #--------------------------------------------------------------------------
  def active=(active)
    @active = active
    @cCharFace.active = active
  end

  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     window : window in which the user control will be drawn
  #     rect : rectangle to position the Image control
  #     actor : actor object
  #     align : character face alignment
  #     opacity : character face opacity
  #     valign : character face vertical alignment
  #     active : control activity
  #     visible : control visibility
  #--------------------------------------------------------------------------
  def initialize(window, rect, actor, align=0, opacity=255, valign=0, 
                 active=true, visible=true)
    super(active, visible)
    self.actor = actor
    @cCharFace = CImage.new(window, rect, nil, nil, align, opacity, valign,
                            active, visible)
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Draw character face on the window
  #--------------------------------------------------------------------------
  def draw()
    draw((96 - @cCharFace.rect.width) / 2, (96 - @cCharFace.rect.height) / 2)
  end
  
  #--------------------------------------------------------------------------
  # * Draw character face on the window
  #     x_adjustment : Custom adjustment to the X coordinate
  #     y_adjustment : Custom adjustment to the Y coordinate
  #--------------------------------------------------------------------------
  def draw(x_adjustment=0,y_adjustment=0)
    if self.actor != nil
      bitmap = Cache.face(self.actor.face_name)
      x = actor.face_index % 4 * 96 + x_adjustment
      y = actor.face_index / 4 * 96 + y_adjustment
        
      @cCharFace.img_bitmap = bitmap
      @cCharFace.src_rect = Rect.new(x, y, 96, 96)
      @cCharFace.draw()
    end
  end
  
end

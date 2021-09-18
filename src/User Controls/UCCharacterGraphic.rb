#==============================================================================
# ** UCCharacterGraphic
#------------------------------------------------------------------------------
#  Represents an actor's character graphic on a window
#==============================================================================

class UCCharacterGraphic < UserControl
  
  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Image control to draw the character graphic
  attr_reader   :cCharGraphic
  # Character graphic direction
  #   0 - Bottom
  #   1 - Left
  #   2 - Right
  #   3 - Top
  attr_accessor :direction
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
    @cCharGraphic.visible = visible
  end

  #--------------------------------------------------------------------------
  # * Set of the user control activity
  #--------------------------------------------------------------------------
  def active=(active)
    @active = active
    @cCharGraphic.active = active
  end

  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     window : window in which the user control will be drawn
  #     rect : rectangle to position the Image control
  #     actor : actor object
  #     align : character graphic alignment
  #     opacity : character graphic opacity
  #     valign : character graphic vertical alignment
  #     direction : character graphic direction
  #     active : control activity
  #     visible : control visibility
  #--------------------------------------------------------------------------
  def initialize(window, rect, actor, align=0, opacity=255, valign=0, direction=0,
                 active=true, visible=true)
    super(active, visible)
    self.actor = actor
    @direction = direction
    @cCharGraphic = CImage.new(window, rect, nil, nil, align, opacity, valign,
                               active, visible)
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Draw character graphic on the window
  #--------------------------------------------------------------------------
  def draw()
    if self.actor != nil
      bitmap = Cache.character(self.actor.character_name)
      sign = self.actor.character_name[/^[\!\$]./]
      if sign != nil && sign.include?('$')
        cw = bitmap.width / 3
        ch = bitmap.height / 4
      else
        cw = bitmap.width / 12
        ch = bitmap.height / 8
      end
      n = self.actor.character_index
      
      @cCharGraphic.img_bitmap = bitmap
      @cCharGraphic.src_rect = Rect.new((n%4*3+1)*cw, (n/4*4+@direction)*ch, cw, ch)
      @cCharGraphic.draw()
    end
  end
  
end

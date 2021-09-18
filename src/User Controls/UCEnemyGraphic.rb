#==============================================================================
# ** UCEnemyGraphic
#------------------------------------------------------------------------------
#  Represents an enemy graphic on a window
#==============================================================================

class UCEnemyGraphic < UserControl
  
  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Image control to draw the enemy graphic
  attr_reader   :cEnemyGraphic
  # Enemy object
  attr_accessor :enemy
  
  #//////////////////////////////////////////////////////////////////////////
  # * Properties
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Set of the user control visibility
  #--------------------------------------------------------------------------
  def visible=(visible)
    @visible = visible
    @cEnemyGraphic.visible = visible
  end

  #--------------------------------------------------------------------------
  # * Set of the user control activity
  #--------------------------------------------------------------------------
  def active=(active)
    @active = active
    @cEnemyGraphic.active = active
  end

  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     window : window in which the user control will be drawn
  #     rect : rectangle to position the Image control
  #     enemy : enemy object
  #     align : enemy graphic alignment
  #     opacity : enemy graphic opacity
  #     valign : enemy graphic vertical alignment
  #     resize_mode : resize mode (see CResizableImage)
  #     active : control activity
  #     visible : control visibility
  #--------------------------------------------------------------------------
  def initialize(window, rect, enemy, align=0, opacity=255, valign=0, resize_mode=nil, 
                 active=true, visible=true)
    super(active, visible)
    self.enemy = enemy
    @cEnemyGraphic = CResizableImage.new(window, rect, 
                     nil, nil, align, opacity, valign, resize_mode, 
                     active, visible)
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Draw enemy graphic on the window
  #--------------------------------------------------------------------------
  def draw()
    if self.enemy != nil
      bitmap = Cache.battler(self.enemy.battler_name, self.enemy.battler_hue)
      @cEnemyGraphic.img_bitmap = bitmap
      @cEnemyGraphic.src_rect = Rect.new(0, 0, bitmap.width, bitmap.height)
      @cEnemyGraphic.draw()
    end
  end
  
end

#==============================================================================
# ** Window_Selectable_Multiple
#------------------------------------------------------------------------------
#  This window contains cursor movement and scroll functions for multiple selection
#==============================================================================

class Window_Selectable_Multiple < Window_Selectable
  
  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Array containing the selected indexes
  attr_reader :indexes
  # Contains the id of the current selected index
  attr_reader :current_index
  # Number of selected indexes to keep
  attr_reader :max_indexes
  
  #//////////////////////////////////////////////////////////////////////////
  # * Properties
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Return number of selected indexes
  #--------------------------------------------------------------------------
  # GET
  def nbr_selected_indexes
    result = 0
    for i in @indexes
      if i >= 0
        result += 1
      end
    end
    return result
  end
  
  #--------------------------------------------------------------------------
  # * Get a specific selected index
  #     i : index (in @indexes) of the selected index
  #--------------------------------------------------------------------------
  # GET
  def index(i=nil)
    temp = nil
    if i == nil
      if @index < 0
        temp = @indexes[0]
      else
        temp = @index
      end
    else
      temp = (i < 0 ? nil : @indexes[i])
    end
    return temp
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     x       : window X coordinate
  #     y       : window Y coordinate
  #     width   : window width
  #     height  : window height
  #     spacing : width of empty space when items are arranged horizontally
  #     line_h  : window line height
  #     visiblecursor : true to show the cursor, else false
  #     line_w  : window line width
  #     align : items alignment
  #     max_indexes : number of selected indexes to keep
  #--------------------------------------------------------------------------
  def initialize(x, y, width, height, spacing = 32, line_h = WLH, 
                 visiblecursor = true, line_w = 0, align = 0, max_indexes = 2)
    super(x, y, width, height, spacing, line_h, visiblecursor, line_w, align)
    @max_indexes = max_indexes
    @indexes = Array.new(@max_indexes, -1)
    @cursor_sprites = Array.new(@max_indexes)
    @current_index = 0
    @item_max = 1
    @column_max = 1
    @index = -1
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Properties
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Update cursor
  #--------------------------------------------------------------------------
  alias update_cursor_ebjb update_cursor unless $@
  def update_cursor      
    update_cursor_ebjb
    if @visible_cursor

      for i in 0 .. @max_indexes-1
        if @indexes[i] >= 0
          if @cursor_sprites[i] != nil
            @cursor_sprites[i].bitmap.clear
          end
          if !@select_all
            rect = item_rect(@indexes[i])     # Get rectangle of selected item
            rect.y -= self.oy           # Match rectangle to scroll position
            cursor = Sprite.new
            cursor.x = self.x+rect.x+16
            cursor.y = self.y+rect.y+16
            cursor.z = 999
            cursor.opacity = 125
            cursor.bitmap = Bitmap.new(rect.width, rect.height)
            cursor.bitmap.stretch_blt(cursor.bitmap.rect, self.windowskin, Rect.new(64,64,32,32)) 
            @cursor_sprites[i] = cursor
          end
        end
      end
      
    end
  end
  
  #--------------------------------------------------------------------------
  # * Alias dispose
  #--------------------------------------------------------------------------
  alias dispose_ebjb dispose unless $@
  def dispose
    dispose_ebjb
    @cursor_sprites.each { |sprite| sprite.dispose if sprite != nil }
  end
  
  #--------------------------------------------------------------------------
  # * Frame Update
  #--------------------------------------------------------------------------
  def update
    super
    
    if Input.trigger?(Input::B)
      if self.active
        Sound.play_decision
        
        if @cursor_sprites[@current_index] != nil
          @cursor_sprites[@current_index].bitmap.clear
        end
        
        @indexes[@current_index] = -1
        if @current_index > 0
          @current_index -= 1
        end
        update_cursor
      end
      
    elsif Input.trigger?(Input::C)
      if self.active
        if @indexes.include?(@index) || block_selection
          Sound.play_buzzer
        else
          Sound.play_decision
          
          if @cursor_sprites[@current_index] != nil
            @cursor_sprites[@current_index].bitmap.clear
          end
          
          @indexes[@current_index] = @index
          if @current_index < @max_indexes-1
            @current_index += 1
          end
          update_cursor
        end
      end
    end
    
    for i in 0 .. @max_indexes-1
      if @indexes[i] >= 0
        row = @indexes[i] / @column_max    # Get row of index
        # If sprite is displayed on different row, hides it, else displays it
        if row < top_row || row > bottom_row
          @cursor_sprites[i].visible = false
        else
          @cursor_sprites[i].visible = true
        end
      end
    end
    
  end
  
  #--------------------------------------------------------------------------
  # * Empty the selected indexes
  #--------------------------------------------------------------------------
  def clean_indexes
    @indexes = Array.new(@max_indexes, -1)
    @cursor_sprites.each { |sprite| sprite.dispose if sprite != nil }
    @cursor_sprites = Array.new(@max_indexes)
    @current_index = 0
  end
  
  #--------------------------------------------------------------------------
  # * Block selection (contents are defined by the subclasses)
  #--------------------------------------------------------------------------
  def block_selection
  end
  
end

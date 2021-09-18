#==============================================================================
# ** Window_Base
#------------------------------------------------------------------------------
#  This is a superclass of all windows in the game.
#==============================================================================

class Window_Base < Window

  #//////////////////////////////////////////////////////////////////////////
  # * Constants
  #//////////////////////////////////////////////////////////////////////////
  OPEN = "OPEN"
  SLIDE = "SLIDE"
  FADE = "FADE"
  MOVE = "MOVE"
  
  #//////////////////////////////////////////////////////////////////////////
  # * Attributes
  #//////////////////////////////////////////////////////////////////////////
  
  # Animation speed (in milliseconds)
  attr_reader :animationSpeed
    
  #//////////////////////////////////////////////////////////////////////////
  # * Properties
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Set the animation speed
  #--------------------------------------------------------------------------
  def animationSpeed=(animationSpeed)
    @animationSpeed = animationSpeed.to_f/1000 * 60
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Constructors
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     x      : window x-coordinate
  #     y      : window y-coordinate
  #     width  : window width
  #     height : window height
  #--------------------------------------------------------------------------
  alias initialize_ebjb initialize unless $@
  def initialize(x, y, width, height)
    initialize_ebjb(x, y, width, height)
    @animationType = nil
    self.animationSpeed = 100
    @duration = 0
    @orig_height = nil
    @orig_opacity = nil
    @move_x = @move_y = nil
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Get * Text Color
  #--------------------------------------------------------------------------
  def normal_color; return Color.normal_color; end
  def system_color; return Color.system_color; end
  def crisis_color; return Color.crisis_color; end
  def lowmp_color; return Color.crisis_color; end
  def knockout_color; return Color.knockout_color; end
  def gauge_back_color; return Color.gauge_back_color; end
  def exhaust_color; return Color.gauge_back_color; end
  def hp_back_color; return Color.gauge_back_color; end
  def hp_gauge_color1; return Color.hp_gauge_color1; end
  def hp_gauge_color2; return Color.hp_gauge_color2; end
  def mp_back_color; return Color.gauge_back_color; end
  def mp_gauge_color1; return Color.mp_gauge_color1; end
  def mp_gauge_color2; return Color.mp_gauge_color2; end
  def power_up_color; return Color.power_up_color; end
  def power_down_color; return Color.power_down_color; end
  
  #--------------------------------------------------------------------------
  # * Frame Update
  #--------------------------------------------------------------------------
  def update
    super
    
    if @duration > 0
      @duration -= 1
      
      case @animationType
      # OPEN effect
      when OPEN
        if @opening
          open_effect(@duration, 255)
          @opening = false if @duration == 0
        elsif @closing
          open_effect(@duration, -255)
          @closing = false if @duration == 0
        end
      # SLIDE effect
      when SLIDE
        if @opening
          slide_effect(@duration, @orig_height)
          @opening = false if @duration == 0
        elsif @closing
          slide_effect(@duration, -@orig_height)
          if @duration == 0
            @closing = false
            self.visible = false
          end
        end  
      # FADE effect
      when FADE
        if @opening
          fade_effect(@duration, @orig_opacity)
          @opening = false if @duration == 0
        elsif @closing
          fade_effect(@duration, -@orig_opacity)
          if @duration == 0
            @closing = false
            self.visible = false
          end
        end   
      # MOVE effect
      when MOVE
        move_effect(@duration, @move_x, @move_y)
      end
      
      if @duration == 0
        @animationType = nil
      end
    end
  end
  
  #--------------------------------------------------------------------------
  # * Open Window with the default effect
  #--------------------------------------------------------------------------
  def open
    if self.openness < 255
      @duration = self.animationSpeed
      @opening = true 
      @closing = false
      @animationType = OPEN
    end
  end
  
  #--------------------------------------------------------------------------
  # * Close window with the default effect
  #--------------------------------------------------------------------------
  def close
    if self.openness > 0
      @duration = self.animationSpeed
      @closing = true 
      @opening = false
      @animationType = OPEN
    end
  end
  
  #--------------------------------------------------------------------------
  # * Open window with a slide effect
  #--------------------------------------------------------------------------
  def slideDown
    if @orig_height == nil || self.height < @orig_height
      @duration = self.animationSpeed
      if @orig_height == nil
        @orig_height = self.height
      end
      self.height = 0
      self.visible = true
      @opening = true
      @closing = false
      @animationType = SLIDE
    end
  end
  
  #--------------------------------------------------------------------------
  # * Close window with a slide effect
  #--------------------------------------------------------------------------
  def slideUp
    if self.height > 0
      @duration = self.animationSpeed
      @orig_height = self.height
      @closing = true
      @opening = false
      @animationType = SLIDE
    end
  end
  
  #--------------------------------------------------------------------------
  # * Open window with a fade effect
  #--------------------------------------------------------------------------
  def fadeIn
    if @orig_opacity == nil || self.opacity < @orig_opacity
      @duration = self.animationSpeed
      if @orig_opacity == nil
        @orig_opacity = self.opacity
      end
      self.opacity = 0
      self.visible = true
      @opening = true
      @closing = false
      @animationType = FADE
    end
  end
  
  #--------------------------------------------------------------------------
  # * Close window with a fade effect
  #--------------------------------------------------------------------------
  def fadeOut
    if self.opacity > 0
      @duration = self.animationSpeed
      @orig_opacity = self.opacity
      @closing = true
      @opening = false
      @animationType = FADE
    end
  end

  #--------------------------------------------------------------------------
  # * Open window with a move effect
  #--------------------------------------------------------------------------
  def moveTo(x, y)
    # If not necessary because you can always use moveTo
    @duration = self.animationSpeed
    @move_x = x - self.x
    @move_y = y - self.y
    @animationType = MOVE
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Private Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Open effect
  #     duration : effect duration
  #     openness : openness
  #--------------------------------------------------------------------------
  def open_effect(duration, openness)
    if @temp_basic_step_openness == nil
      @temp_basic_step_openness = openness / duration.to_f
      
      @we_open_start_openness = self.openness
    end

    step_openness = openness - (duration * @temp_basic_step_openness)
    
    self.openness = @we_open_start_openness + step_openness

    if duration == 0
      @temp_basic_step_openness = nil
      @we_open_start_openness = nil
    end
  end
  private :open_effect

  #--------------------------------------------------------------------------
  # * Slide effect
  #     duration : effect duration
  #     height : height
  #--------------------------------------------------------------------------
  def slide_effect(duration, height)
    if @temp_basic_step_height == nil
      @temp_basic_step_height = height / duration.to_f
      
      @we_open_start_height = self.height
    end

    step_height = height - (duration * @temp_basic_step_height)
    
    self.height = @we_open_start_height + step_height

    if duration == 0
      @temp_basic_step_height = nil
      @we_open_start_height = nil
    end
  end
  private :slide_effect
  
  #--------------------------------------------------------------------------
  # * Fade effect
  #     duration : effect duration
  #     opacity : opacity
  #--------------------------------------------------------------------------
  def fade_effect(duration, opacity)
    if @temp_basic_step_opacity == nil
      @temp_basic_step_opacity = opacity / duration.to_f
      
      @we_open_start_opacity = self.opacity
    end

    step_opacity = opacity - (duration * @temp_basic_step_opacity)
    
    self.opacity = @we_open_start_opacity + step_opacity

    if duration == 0
      @temp_basic_step_opacity = nil
      @we_open_start_opacity = nil
    end
  end
  private :fade_effect
  
  #--------------------------------------------------------------------------
  # * Move effect
  #     duration : effect duration
  #     x : X coordinate to move to
  #     y : Y coordinate to move to
  #--------------------------------------------------------------------------
  def move_effect(duration, x, y)
    if @temp_basic_step_x == nil && @temp_basic_step_y == nil
      @temp_basic_step_x = x / duration.to_f
      @temp_basic_step_y = y / duration.to_f
      
      @we_move_start_x = self.x
      @we_move_start_y = self.y
    end
    
    step_x = x - (duration * @temp_basic_step_x)
    step_y = y - (duration * @temp_basic_step_y)

    self.x = @we_move_start_x + step_x
    self.y = @we_move_start_y + step_y

    if duration == 0
      @temp_basic_step_x = nil
      @temp_basic_step_y = nil
      @we_move_start_x = nil
      @we_move_start_y = nil
    end
  end
  private :move_effect
  
end

#==============================================================================
# ** TestUI_UCBar
#------------------------------------------------------------------------------
#  Unit tests for the UCBar user control
#==============================================================================

class TestUI_UCBar < TestUI_Class
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Setup tests
  #--------------------------------------------------------------------------
  def testFixtureSetup()
    # bitmap test
    @viewport_bitmap = Viewport.new(0, 0, 640, 450)
    @sprite_bitmap = Sprite.new(@viewport_bitmap)
    @bitmap = Bitmap.new(640, 450)
    @sprite_bitmap.bitmap = @bitmap
    
    # sprite test
    @viewport = Viewport.new(0, 0, 640, 450)
    @sprite = Sprite.new(@viewport)
    @sprite.bitmap = Bitmap.new(640, 450)
    
    # window test
    @window = Window_Base.new(0, 0, 640, 450)
    
    @window.visible = true
    @sprite.visible = false
    @sprite_bitmap.visible = false
    @window_duration = 240
    @sprite_duration = nil
    @bitmap_duration = nil
    
    @uc_barsToggle = []
    @up = true
    # setup your objects for the tests (if needed)
  end
  
  #--------------------------------------------------------------------------
  # * Tear down tests
  #--------------------------------------------------------------------------
  def testFixtureTearDown()
    @window.dispose
    @window = nil
    
    @sprite.bitmap.dispose
    @sprite.dispose
    @sprite = nil
    @viewport.dispose
    @viewport = nil
    
    @viewport_bitmap.dispose
    @viewport_bitmap = nil
    @sprite_bitmap.bitmap.dispose
    @sprite_bitmap.dispose
    @sprite_bitmap = nil
    
    @uc_barsToggle = nil
    # destroy your objects when the tests are finished (if needed)
  end
  
  #--------------------------------------------------------------------------
  # * Frame update
  #--------------------------------------------------------------------------
  def update()
    @window.update
    @viewport.update
    @sprite.update
    @viewport_bitmap.update
    @sprite_bitmap.update
    
    if @window_duration != nil
      if @window_duration == 0
        @window.visible = false
        @sprite_duration = 240
        @sprite.visible = true
        @window_duration = nil
      elsif @window_duration > 0
        @window_duration -= 1
      end
    end
    
    if @sprite_duration != nil
      if @sprite_duration == 0
        @sprite.visible = false
        @bitmap_duration = 240
        @sprite_bitmap.visible = true
        @sprite_duration = nil
      elsif @sprite_duration > 0
        @sprite_duration -= 1
      end
    end
    
    if @bitmap_duration != nil
      if @bitmap_duration == 0
        @sprite_bitmap.visible = false
        @window_duration = 240
        @window.visible = true
        @bitmap_duration = nil
      elsif @bitmap_duration > 0
        @bitmap_duration -= 1
      end
    end
    
    if @upDown_duration == 0
      upDownToggle()
    else
      @upDown_duration -= 1
    end
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Tests
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Default UCBar
  #--------------------------------------------------------------------------
  def test_default
    [@window, @sprite, @bitmap].each{|container|
      uc = UCBar.new(container, Rect.new(0, 0, 100, 24), Color.hp_gauge_color1, 
                     Color.hp_gauge_color2, Color.gauge_back_color, nil, nil)
      uc.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Default UCBar with a value
  #--------------------------------------------------------------------------
  def test_defaultValue
    [@window, @sprite, @bitmap].each{|container|
      uc = UCBar.new(container, Rect.new(100, 0, 100, 24), Color.hp_gauge_color1, 
                     Color.hp_gauge_color2, Color.gauge_back_color, 10, nil)
      uc.draw()
    }
    return true
  end  
  
  #--------------------------------------------------------------------------
  # * UCBar with a custom max value
  #--------------------------------------------------------------------------
  def test_max
    [@window, @sprite, @bitmap].each{|container|
      uc = UCBar.new(container, Rect.new(200, 0, 100, 24), Color.hp_gauge_color1, 
                     Color.hp_gauge_color2, Color.gauge_back_color, 10, 100)
      uc.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * UCBar with a border
  #--------------------------------------------------------------------------
  def test_border
    [@window, @sprite, @bitmap].each{|container|
      uc = UCBar.new(container, Rect.new(300, 0, 100, 24), Color.hp_gauge_color1, 
                     Color.hp_gauge_color2, Color.gauge_back_color, 10, 100, 1, Color.gauge_border_color)
      uc.draw()
    }
    return true
  end

  #--------------------------------------------------------------------------
  # * UCBar which is inactive
  #--------------------------------------------------------------------------
  def test_inactive
    [@window, @sprite, @bitmap].each{|container|
      uc = UCBar.new(container, Rect.new(100, 24, 100, 24), Color.hp_gauge_color1, 
                     Color.hp_gauge_color2, Color.gauge_back_color, 10, 100)
      uc.active = false
      uc.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * UCBar which is inactive with a border
  #--------------------------------------------------------------------------
  def test_inactiveBorder
    [@window, @sprite, @bitmap].each{|container|
      uc = UCBar.new(container, Rect.new(200, 24, 100, 24), Color.hp_gauge_color1, 
                     Color.hp_gauge_color2, Color.gauge_back_color, 10, 100, 1, Color.gauge_border_color)
      uc.active = false
      uc.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * UCBar which is invisible
  #--------------------------------------------------------------------------
  def test_invisible
    [@window, @sprite, @bitmap].each{|container|
      uc = UCBar.new(container, Rect.new(300, 24, 100, 24), Color.hp_gauge_color1, 
                     Color.hp_gauge_color2, Color.gauge_back_color, 10, 100)
      uc.visible = false
      uc.draw()
    }
    return true
  end  

  #--------------------------------------------------------------------------
  # * UCBar when changing value
  #--------------------------------------------------------------------------
  def test_upDownToggle
    [@window, @sprite, @bitmap].each{|container|
      uc = UCBar.new(container, Rect.new(0, 48, 100, 24), Color.hp_gauge_color1, 
                     Color.hp_gauge_color2, Color.gauge_back_color, 25, 225)
      @uc_barsToggle.push(uc)
      uc = UCBar.new(container, Rect.new(100, 48, 100, 24), Color.hp_gauge_color1, 
                     Color.hp_gauge_color2, Color.gauge_back_color, 25, 225, 1, Color.gauge_border_color)
      @uc_barsToggle.push(uc)
    }
    upDownToggle()
    return true
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Private Methods
  #//////////////////////////////////////////////////////////////////////////
    
  #--------------------------------------------------------------------------
  # * Toggle between up/down to change value of UCBar
  #--------------------------------------------------------------------------
  def upDownToggle()
    @upDown_duration = 6
    @window.contents.clear_rect(Rect.new(0, 48, 100, 24))
    @sprite.bitmap.clear_rect(Rect.new(0, 48, 100, 24))
    @bitmap.clear_rect(Rect.new(0, 48, 100, 24))
    for uc in @uc_barsToggle
      if (uc.value == uc.max_value)
        @up = false
      elsif (uc.value == 0)
        @up = true
      end
      
      if (@up)
        uc.value += 5
      else
        uc.value -= 5
      end
      
      uc.draw()
    end
  end
  private :upDownToggle
  
end

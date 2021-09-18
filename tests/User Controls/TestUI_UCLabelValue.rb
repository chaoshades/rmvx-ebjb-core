#==============================================================================
# ** TestUI_UCLabelValue
#------------------------------------------------------------------------------
#  Unit tests for the UCLabelValue user control
#==============================================================================

class TestUI_UCLabelValue < TestUI_Class
  
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
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Tests
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Default UCLabelValue
  #--------------------------------------------------------------------------
  def test_default
    [@window, @sprite, @bitmap].each{|container|
      uc = UCLabelValue.new(container, Rect.new(0, 0, 100, 24), Rect.new(100, 0, 100, 24), nil, nil)
      uc.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * UCLabelValue with a label 
  #--------------------------------------------------------------------------
  def test_defaultLabel
    [@window, @sprite, @bitmap].each{|container|
      uc = UCLabelValue.new(container, Rect.new(200, 0, 100, 24), Rect.new(300, 0, 100, 24), "Label", nil)
      uc.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * UCLabelValue with a label with a value
  #--------------------------------------------------------------------------
  def test_defaultValue
    [@window, @sprite, @bitmap].each{|container|
      uc = UCLabelValue.new(container, Rect.new(400, 0, 100, 24), Rect.new(500, 0, 100, 24), "Label", "[value]")
      uc.draw()
    }
    return true
  end

  #--------------------------------------------------------------------------
  # * UCLabelValue which is inactive
  #--------------------------------------------------------------------------
  def test_inactive
    [@window, @sprite, @bitmap].each{|container|
      uc = UCLabelValue.new(container, Rect.new(0, 24, 100, 24), Rect.new(100, 24, 100, 24), "Label", "[value]")
      uc.active = false
      uc.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * UCLabelValue which is invisible
  #--------------------------------------------------------------------------
  def test_invisible
    [@window, @sprite, @bitmap].each{|container|
      uc = UCLabelValue.new(container, Rect.new(200, 24, 100, 24), Rect.new(300, 24, 100, 24), "Label", "[value]")
      uc.visible = false
      uc.draw()
    }
    return true
  end
  
end

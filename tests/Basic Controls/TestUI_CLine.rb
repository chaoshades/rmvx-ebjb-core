#==============================================================================
# ** TestUI_CLine
#------------------------------------------------------------------------------
#  Unit tests for the Line control
#==============================================================================

class TestUI_CLine < TestUI_Class
  
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
  # * Default line
  #--------------------------------------------------------------------------
  def test_default
    [@window, @sprite, @bitmap].each{|container|
      c = CLine.new(container, 0, 25, 100, 25, Color.hp_gauge_color1)
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Line which is inactive
  #--------------------------------------------------------------------------
  def test_inactive
    [@window, @sprite, @bitmap].each{|container|
      c = CLine.new(container, 100, 25, 200, 25, Color.hp_gauge_color1)
      c.active = false
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Line which is invisible
  #--------------------------------------------------------------------------
  def test_invisible
    [@window, @sprite, @bitmap].each{|container|
      c = CLine.new(container, 200, 25, 300, 25, Color.hp_gauge_color1)
      c.visible = false
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Line with a gradient
  #--------------------------------------------------------------------------
  def test_gradient
    [@window, @sprite, @bitmap].each{|container|
      c = CLine.new(container, 300, 25, 400, 25, Color.hp_gauge_color1, 1, Color.hp_gauge_color2)
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Line with a gradient which is inactive
  #--------------------------------------------------------------------------
  def test_inactiveGradient
    [@window, @sprite, @bitmap].each{|container|
      c = CLine.new(container, 400, 25, 500, 25, Color.hp_gauge_color1, 1, Color.hp_gauge_color2)
      c.active = false
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Default vertical line
  #--------------------------------------------------------------------------
  def test_defaultVertical
    [@window, @sprite, @bitmap].each{|container|
      c = CLine.new(container, 25, 50, 25, 100, Color.hp_gauge_color1)
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Vertical Line which is inactive
  #--------------------------------------------------------------------------
  def test_inactiveVertical
    [@window, @sprite, @bitmap].each{|container|
      c = CLine.new(container, 75, 50, 75, 100, Color.hp_gauge_color1)
      c.active = false
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Vertical Line which is invisible
  #--------------------------------------------------------------------------
  def test_invisibleVertical
    [@window, @sprite, @bitmap].each{|container|
      c = CLine.new(container, 125, 50, 125, 100, Color.hp_gauge_color1)
      c.visible = false
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Vertical Line with a gradient
  #--------------------------------------------------------------------------
  def test_gradientVertical
    [@window, @sprite, @bitmap].each{|container|
      c = CLine.new(container, 175, 50, 175, 100, Color.hp_gauge_color1, 2, Color.hp_gauge_color2)
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Vertical Line with a gradient which is inactive
  #--------------------------------------------------------------------------
  def test_inactiveGradientVertical
    [@window, @sprite, @bitmap].each{|container|
      c = CLine.new(container, 225, 50, 225, 100, Color.hp_gauge_color1, 2, Color.hp_gauge_color2)
      c.active = false
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Vertical Line with a vertical gradient
  #--------------------------------------------------------------------------
  def test_verticalGradientVertical
    [@window, @sprite, @bitmap].each{|container|
      c = CLine.new(container, 275, 50, 275, 100, Color.hp_gauge_color1, 1, Color.hp_gauge_color2, true)
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Vertical Line with a vertical gradient which is inactive
  #--------------------------------------------------------------------------
  def test_inactiveVerticalGradientVertical
    [@window, @sprite, @bitmap].each{|container|
      c = CLine.new(container, 325, 50, 325, 100, Color.hp_gauge_color1, 1, Color.hp_gauge_color2, true)
      c.active = false
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Line with a custom width
  #--------------------------------------------------------------------------
  def test_customWidth
    [@window, @sprite, @bitmap].each{|container|
      c = CLine.new(container, 0, 150, 100, 150, Color.hp_gauge_color1, 5)
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Lines in any direction
  #--------------------------------------------------------------------------
  def test_anyDirections
    [@window, @sprite, @bitmap].each{|container|
      c = CLine.new(container, 100, 150, 200, 150, Color.hp_gauge_color1)
      c.draw()
      c = CLine.new(container, 100, 125, 200, 175, Color.hp_gauge_color1)
      c.draw()
      c = CLine.new(container, 150, 125, 150, 175, Color.hp_gauge_color1)
      c.draw()
      c = CLine.new(container, 200, 125, 100, 175, Color.hp_gauge_color1)
      c.draw()
    }
    return true
  end
  
end

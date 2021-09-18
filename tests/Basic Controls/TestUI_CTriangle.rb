#==============================================================================
# ** TestUI_CTriangle
#------------------------------------------------------------------------------
#  Unit tests for the Triangle control
#==============================================================================

class TestUI_CTriangle < TestUI_Class
  
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
  # * Default triangle
  #--------------------------------------------------------------------------
  def test_default
    [@window, @sprite, @bitmap].each{|container|
      c = CTriangle.new(container, 0, 0, 100, 0, 50, 50, Color.hp_gauge_color1)
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Triangle which is inactive
  #--------------------------------------------------------------------------
  def test_inactive
    [@window, @sprite, @bitmap].each{|container|
      c = CTriangle.new(container, 100, 0, 200, 0, 150, 50, Color.hp_gauge_color1)
      c.active = false
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Triangle which is invisible
  #--------------------------------------------------------------------------
  def test_invisible
    [@window, @sprite, @bitmap].each{|container|
      c = CTriangle.new(container, 200, 0, 300, 0, 250, 50, Color.hp_gauge_color1)
      c.visible = false
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Triangle with a gradient
  #--------------------------------------------------------------------------
  def test_gradient
    [@window, @sprite, @bitmap].each{|container|
      c = CTriangle.new(container, 300, 0, 400, 0, 350, 50, Color.hp_gauge_color1, true, Color.hp_gauge_color2)
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Triangle with a gradient which is inactive
  #--------------------------------------------------------------------------
  def test_inactiveGradient
    [@window, @sprite, @bitmap].each{|container|
      c = CTriangle.new(container, 400, 0, 500, 0, 450, 50, Color.hp_gauge_color1, true, Color.hp_gauge_color2)
      c.active = false
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Triangle with a border
  #--------------------------------------------------------------------------
  def test_border
    [@window, @sprite, @bitmap].each{|container|
      c = CTriangle.new(container, 0, 50, 100, 50, 50, 100, Color.gauge_back_color, true, Color.gauge_back_color,
          1, Color.hp_gauge_color1)
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Triangle with a border which is inactive
  #--------------------------------------------------------------------------
  def test_inactiveBorder
    [@window, @sprite, @bitmap].each{|container|
      c = CTriangle.new(container, 100, 50, 200, 50, 150, 100, Color.gauge_back_color, true, Color.gauge_back_color,
          1, Color.hp_gauge_color1)
      c.active = false
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Triangle with a gradient border
  #--------------------------------------------------------------------------
  def test_gradientBorder
    [@window, @sprite, @bitmap].each{|container|
      c = CTriangle.new(container, 200, 50, 300, 50, 250, 100, Color.gauge_back_color, true, Color.gauge_back_color,
          1, Color.hp_gauge_color1, Color.hp_gauge_color2)
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Triangle with a gradient border which is inactive
  #--------------------------------------------------------------------------
  def test_inactiveGradientBorder
    [@window, @sprite, @bitmap].each{|container|
      c = CTriangle.new(container, 300, 50, 400, 50, 350, 100, Color.gauge_back_color, true, Color.gauge_back_color,
          1, Color.hp_gauge_color1, Color.hp_gauge_color2)
      c.active = false
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Triangle not filled with a border
  #--------------------------------------------------------------------------
  def test_notFilled_Border
    [@window, @sprite, @bitmap].each{|container|
      c = CTriangle.new(container, 0, 100, 100, 100, 50, 150, nil, false, nil,
          1, Color.hp_gauge_color1)
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Triangle with a border which is inactive
  #--------------------------------------------------------------------------
  def test_notFilled_inactiveBorder
    [@window, @sprite, @bitmap].each{|container|
      c = CTriangle.new(container, 100, 100, 200, 100, 150, 150, nil, false, nil,
          1, Color.hp_gauge_color1)
      c.active = false
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Triangle with a gradient border
  #--------------------------------------------------------------------------
  def test_notFilled_gradientBorder
    [@window, @sprite, @bitmap].each{|container|
      c = CTriangle.new(container, 200, 100, 300, 100, 250, 150, nil, false, nil,
          1, Color.hp_gauge_color1, Color.hp_gauge_color2)
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Triangle with a gradient border which is inactive
  #--------------------------------------------------------------------------
  def test_notFilled_inactiveGradientBorder
    [@window, @sprite, @bitmap].each{|container|
      c = CTriangle.new(container, 300, 100, 400, 100, 350, 150, nil, false, nil,
          1, Color.hp_gauge_color1, Color.hp_gauge_color2)
      c.active = false
      c.draw()
    }
    return true
  end
  
end

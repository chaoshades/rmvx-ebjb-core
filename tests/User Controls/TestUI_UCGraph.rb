#==============================================================================
# ** TestUI_UCGraph
#------------------------------------------------------------------------------
#  Unit tests for the UCGraph user control (part 1)
#==============================================================================

class TestUI_UCGraph < TestUI_Class
  
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
    
    @elements = []
    for i in 9..16
      @elements.push(GraphElement.new($data_elements[i].icon_index, -100 + 25 * (i-9)))
    end
    
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

    @elements = nil
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
  # * Default UCGraph
  #--------------------------------------------------------------------------
  def test_default
    [@window, @sprite, @bitmap].each{|container|
      uc = UCGraph.new(container, 100, 60, 50, nil, nil, nil, nil, Font.normal_font,
                       Color.hp_gauge_color1, Color.hp_gauge_color2,
                       Color.mp_gauge_color1, Color.mp_gauge_color2)
      uc.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Default UCGraph with elements
  #--------------------------------------------------------------------------
  def test_defaultElements
    [@window, @sprite, @bitmap].each{|container|
      uc = UCGraph.new(container, 300, 60, 50, @elements, nil, nil, nil, Font.normal_font,
                       Color.hp_gauge_color1, Color.hp_gauge_color2,
                       Color.mp_gauge_color1, Color.mp_gauge_color2)
      uc.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * UCGraph with custom min/max
  #--------------------------------------------------------------------------
  def test_minMax
    [@window, @sprite, @bitmap].each{|container|
      uc = UCGraph.new(container, 500, 60, 50, @elements, nil, 100, -100, Font.normal_font,
                       Color.hp_gauge_color1, Color.hp_gauge_color2,
                       Color.mp_gauge_color1, Color.mp_gauge_color2)
      uc.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * UCGraph with custom pattern
  #--------------------------------------------------------------------------
  def test_pattern
    [@window, @sprite, @bitmap].each{|container|
      uc = UCGraph.new(container, 100, 180, 50, @elements, "%d%%", 100, -100, Font.normal_font,
                       Color.hp_gauge_color1, Color.hp_gauge_color2,
                       Color.mp_gauge_color1, Color.mp_gauge_color2)
      uc.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * UCGraph with different font
  #--------------------------------------------------------------------------
  def test_fontDiff
    f = Font.new()
    f.color = Color.power_up_color()
    f.size = 12
    f.bold = true
    [@window, @sprite, @bitmap].each{|container|
      uc = UCGraph.new(container, 300, 180, 50, @elements, nil, 100, -100, f,
                       Color.hp_gauge_color1, Color.hp_gauge_color2,
                       Color.mp_gauge_color1, Color.mp_gauge_color2)
      uc.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * UCGraph with hidden values
  #--------------------------------------------------------------------------
  def test_hideValues
    [@window, @sprite, @bitmap].each{|container|
      uc = UCGraph.new(container, 500, 180, 50, @elements, nil, 100, -100, Font.normal_font,
                       Color.hp_gauge_color1, Color.hp_gauge_color2,
                       Color.mp_gauge_color1, Color.mp_gauge_color2)
      uc.hide_values = true
      uc.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * UCGraph with custom padding for values
  #--------------------------------------------------------------------------
  def test_padding
    [@window, @sprite, @bitmap].each{|container|
      uc = UCGraph.new(container, 100, 300, 50, @elements, nil, 100, -100, Font.normal_font,
                       Color.hp_gauge_color1, Color.hp_gauge_color2,
                       Color.mp_gauge_color1, Color.mp_gauge_color2)
      uc.padding = 5
      uc.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * UCGraph which is inactive
  #--------------------------------------------------------------------------
  def test_inactive
    [@window, @sprite, @bitmap].each{|container|
     uc = UCGraph.new(container, 300, 300, 50, @elements, nil, 100, -100, Font.normal_font,
                       Color.hp_gauge_color1, Color.hp_gauge_color2,
                       Color.mp_gauge_color1, Color.mp_gauge_color2)
      uc.active = false
      uc.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * UCGraph which is inactive with a border
  #--------------------------------------------------------------------------
  def test_inactiveBorder
    [@window, @sprite, @bitmap].each{|container|
     uc = UCGraph.new(container, 500, 300, 50, @elements, nil, 100, -100, Font.normal_font,
                       Color.hp_gauge_color1, Color.hp_gauge_color2,
                       Color.mp_gauge_color1, Color.mp_gauge_color2, nil,
                       1, Color.normal_color)
      uc.active = false
      uc.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * UCGraph which is invisible
  #--------------------------------------------------------------------------
  def test_invisible
    [@window, @sprite, @bitmap].each{|container|
     uc = UCGraph.new(container, 500, 300, 50, @elements, nil, 100, -100, Font.normal_font,
                       Color.hp_gauge_color1, Color.hp_gauge_color2,
                       Color.mp_gauge_color1, Color.mp_gauge_color2)
      uc.visible = false
      uc.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * UCGraph with back color
  #--------------------------------------------------------------------------
  def test_backColor
    [@window, @sprite, @bitmap].each{|container|
      uc = UCGraph.new(container, 100, 420, 50, @elements, nil, 100, -100, Font.normal_font,
                       Color.hp_gauge_color1, Color.hp_gauge_color2,
                       Color.mp_gauge_color1, Color.mp_gauge_color2, Color.gauge_back_color)
      uc.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * UCGraph with border
  #--------------------------------------------------------------------------
  def test_border
    [@window, @sprite, @bitmap].each{|container|
      uc = UCGraph.new(container, 300, 420, 50, @elements, nil, 100, -100, Font.normal_font,
                       Color.hp_gauge_color1, Color.hp_gauge_color2,
                       Color.mp_gauge_color1, Color.mp_gauge_color2, nil,
                       1, Color.normal_color)
      uc.draw()
    }
    return true
  end
  
end

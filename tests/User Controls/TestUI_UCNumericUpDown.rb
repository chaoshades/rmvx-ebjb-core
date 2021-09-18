#==============================================================================
# ** TestUI_UCNumericUpDown
#------------------------------------------------------------------------------
#  Unit tests for the UCNumericUpDown user control
#==============================================================================

class TestUI_UCNumericUpDown < TestUI_Class
  
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
    
    @uc_upDownsToggle = []
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
    
    @uc_upDownsToggle = nil
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
  # * Default UCNumericUpDown
  #--------------------------------------------------------------------------
  def test_default
    [@window, @sprite, @bitmap].each{|container|
      uc = UCNumericUpDown.new(container, Rect.new(0, 0, 100, 24), nil)
      uc.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Default UCNumericUpDown with a value
  #--------------------------------------------------------------------------
  def test_defaultValue
    [@window, @sprite, @bitmap].each{|container|
      uc = UCNumericUpDown.new(container, Rect.new(100, 0, 100, 24), 5)
      uc.draw()
    }
    return true
  end  
  
  #--------------------------------------------------------------------------
  # * UCNumericUpDown with a custom pattern
  #--------------------------------------------------------------------------
  def test_pattern
    [@window, @sprite, @bitmap].each{|container|
      uc = UCNumericUpDown.new(container, Rect.new(200, 0, 100, 24), 0, "%d%%")
      uc.draw()
    }
    return true
  end  
  
  #--------------------------------------------------------------------------
  # * UCNumericUpDown with a custom min value
  #--------------------------------------------------------------------------
  def test_min
    [@window, @sprite, @bitmap].each{|container|
      uc = UCNumericUpDown.new(container, Rect.new(0, 24, 100, 24), 0, nil, -1000)
      uc.draw()
    }
    return true
  end  
  
  #--------------------------------------------------------------------------
  # * UCNumericUpDown with a custom max value
  #--------------------------------------------------------------------------
  def test_max
    [@window, @sprite, @bitmap].each{|container|
      uc = UCNumericUpDown.new(container, Rect.new(100, 24, 100, 24), 0, nil, 1000)
      uc.draw()
    }
    return true
  end  
  
  #--------------------------------------------------------------------------
  # * UCNumericUpDown with a custom step
  #--------------------------------------------------------------------------
  def test_step
    [@window, @sprite, @bitmap].each{|container|
      uc = UCNumericUpDown.new(container, Rect.new(200, 24, 100, 24), 0, nil, 0, 99, 2)
      uc.draw()
    }
    return true
  end  
  
  #--------------------------------------------------------------------------
  # * UCNumericUpDown with different font
  #--------------------------------------------------------------------------
  def test_fontDiff
    f = Font.new()
    f.color = Color.power_up_color()
    f.size = 20
    f.bold = true
    [@window, @sprite, @bitmap].each{|container|
      uc = UCNumericUpDown.new(container, Rect.new(0, 48, 100, 24), 5, nil, 0, 99, 1, 0, f)
      uc.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * UCNumericUpDown which is inactive
  #--------------------------------------------------------------------------
  def test_inactive
    [@window, @sprite, @bitmap].each{|container|
      uc = UCNumericUpDown.new(container, Rect.new(100, 48, 100, 24), 5)
      uc.active = false
      uc.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * UCNumericUpDown which is invisible
  #--------------------------------------------------------------------------
  def test_invisible
    [@window, @sprite, @bitmap].each{|container|
      uc = UCNumericUpDown.new(container, Rect.new(200, 48, 100, 24), 5)
      uc.visible = false
      uc.draw()
    }
    return true
  end  

  #--------------------------------------------------------------------------
  # * UCNumericUpDown aligned to left
  #--------------------------------------------------------------------------
  def test_alignLeft
    [@window, @sprite, @bitmap].each{|container|
      uc = UCNumericUpDown.new(container, Rect.new(0, 72, @window.contents.width, 24), 5, nil, 0, 99, 1, 0)
      uc.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * UCNumericUpDown aligned to center
  #--------------------------------------------------------------------------
  def test_alignCenter
    [@window, @sprite, @bitmap].each{|container|
      uc = UCNumericUpDown.new(container, Rect.new(0, 72, @window.contents.width, 24), 5, nil, 0, 99, 1, 1)
      uc.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * UCNumericUpDown aligned to right
  #--------------------------------------------------------------------------
  def test_alignRight
    [@window, @sprite, @bitmap].each{|container|
      uc = UCNumericUpDown.new(container, Rect.new(0, 72, @window.contents.width, 24), 5, nil, 0, 99, 1, 2)
      uc.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * UCNumericUpDown when changing value
  #--------------------------------------------------------------------------
  def test_upDownToggle
    [@window, @sprite, @bitmap].each{|container|
      uc = UCNumericUpDown.new(container, Rect.new(0, 96, 100, 24), 27, "%d%%", -125, 225, 7)
      @uc_upDownsToggle.push(uc)
    }
    upDownToggle()
    return true
  end
  
  #--------------------------------------------------------------------------
  # * UCNumericUpDown when resetting
  #--------------------------------------------------------------------------
  def test_reset
    [@window, @sprite, @bitmap].each{|container|
      uc = UCNumericUpDown.new(container, Rect.new(100, 96, 100, 24), 27, "%d%%", -125, 225, 7)
      uc.reset()
      uc.draw()
    }
    return true
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Private Methods
  #//////////////////////////////////////////////////////////////////////////
    
  #--------------------------------------------------------------------------
  # * Toggle between up/down to change value of UCNumericUpDown
  #--------------------------------------------------------------------------
  def upDownToggle()
    @upDown_duration = 6
    @window.contents.clear_rect(Rect.new(0, 96, 100, 24))
    @sprite.bitmap.clear_rect(Rect.new(0, 96, 100, 24))
    @bitmap.clear_rect(Rect.new(0, 96, 100, 24))
    for uc in @uc_upDownsToggle
      if (uc.value == uc.max)
        @up = false
      elsif (uc.value == uc.min)
        @up = true
      end
      
      if (@up)
        uc.up()
      else
        uc.down()
      end
      
      uc.draw()
    end
  end
  private :upDownToggle
  
end

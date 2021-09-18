#==============================================================================
# ** TestUI_UCBackgroundImage
#------------------------------------------------------------------------------
#  Unit tests for the UCBackgroundImage user control
#==============================================================================

class TestUI_UCBackgroundImage < TestUI_Class
  
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
  # * Default UCBackgroundImage
  #--------------------------------------------------------------------------
  def test_default
    [@window, @sprite, @bitmap].each{|container|
      uc = UCBackgroundImage.new(container, nil)
      uc.draw()
    }
    return true
  end

  #--------------------------------------------------------------------------
  # * UCBackgroundImage which is inactive
  #--------------------------------------------------------------------------
  def test_inactive
    [@window, @sprite, @bitmap].each{|container|
      uc = UCBackgroundImage.new(container, "logo")
      uc.active = false
      uc.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * UCBackgroundImage which is invisible
  #--------------------------------------------------------------------------
  def test_invisible
    [@window, @sprite, @bitmap].each{|container|
      uc = UCBackgroundImage.new(container, "logo")
      uc.visible = false
      uc.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * UCBackgroundImage aligned to top/left
  #--------------------------------------------------------------------------
  def test_alignTopLeft
    [@window, @sprite, @bitmap].each{|container|
      uc = UCBackgroundImage.new(container, "logo", 0)
      uc.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * UCBackgroundImage aligned to top/center
  #--------------------------------------------------------------------------
  def test_alignTopCenter
    [@window, @sprite, @bitmap].each{|container|
      uc = UCBackgroundImage.new(container, "logo", 1)
      uc.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * UCBackgroundImage aligned to top/right
  #--------------------------------------------------------------------------
  def test_alignTopRight
    [@window, @sprite, @bitmap].each{|container|
      uc = UCBackgroundImage.new(container, "logo", 2)
      uc.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * UCBackgroundImage aligned to middle/left
  #--------------------------------------------------------------------------
  def test_alignMiddleLeft
    [@window, @sprite, @bitmap].each{|container|
      uc = UCBackgroundImage.new(container, "logo", 0, 255, 1)
      uc.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * UCBackgroundImage aligned to middle/center
  #--------------------------------------------------------------------------
  def test_alignMiddleCenter
    [@window, @sprite, @bitmap].each{|container|
      uc = UCBackgroundImage.new(container, "logo", 1, 255, 1)
      uc.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * UCBackgroundImage aligned to middle/right
  #--------------------------------------------------------------------------
  def test_alignMiddleRight
    [@window, @sprite, @bitmap].each{|container|
      uc = UCBackgroundImage.new(container, "logo", 2, 255, 1)
      uc.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * UCBackgroundImage aligned to bottom/left
  #--------------------------------------------------------------------------
  def test_alignBottomLeft
    [@window, @sprite, @bitmap].each{|container|
      uc = UCBackgroundImage.new(container, "logo", 0, 255, 2)
      uc.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * UCBackgroundImage aligned to bottom/center
  #--------------------------------------------------------------------------
  def test_alignBottomCenter
    [@window, @sprite, @bitmap].each{|container|
      uc = UCBackgroundImage.new(container, "logo", 1, 255, 2)
      uc.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * UCBackgroundImage aligned to bottom/right
  #--------------------------------------------------------------------------
  def test_alignBottomRight
    [@window, @sprite, @bitmap].each{|container|
      uc = UCBackgroundImage.new(container, "logo", 2, 255, 2)
      uc.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * UCBackgroundImage with custom opacity
  #--------------------------------------------------------------------------
  def test_opacity
    [@window, @sprite, @bitmap].each{|container|
      uc = UCBackgroundImage.new(container, "logo", 0, 200)
      uc.draw()
    }
    return true
  end
  
end

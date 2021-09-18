#==============================================================================
# ** TestUI_CImage
#------------------------------------------------------------------------------
#  Unit tests for the Image control
#==============================================================================

class TestUI_CImage < TestUI_Class
  
  #//////////////////////////////////////////////////////////////////////////
  # * Constants
  #//////////////////////////////////////////////////////////////////////////
  
  BITMAP = Cache.system("IconSet")
  ICON_RECT = Rect.new(1 % 16 * 24, 1 / 16 * 24, 24, 24)
  
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
  # * Default image
  #--------------------------------------------------------------------------
  def test_default
    [@window, @sprite, @bitmap].each{|container|
      c = CImage.new(container, Rect.new(0, 0, 100, 24), BITMAP, ICON_RECT)
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Image aligned to top/left
  #--------------------------------------------------------------------------
  def test_alignTopLeft
    [@window, @sprite, @bitmap].each{|container|
      c = CImage.new(container, Rect.new(0, 24, @window.contents.width, 100), BITMAP, ICON_RECT, 0)
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Image aligned to top/center
  #--------------------------------------------------------------------------
  def test_alignTopCenter
    [@window, @sprite, @bitmap].each{|container|
      c = CImage.new(container, Rect.new(0, 24, @window.contents.width, 100), BITMAP, ICON_RECT, 1)
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Image aligned to top/right
  #--------------------------------------------------------------------------
  def test_alignTopRight
    [@window, @sprite, @bitmap].each{|container|
      c = CImage.new(container, Rect.new(0, 24, @window.contents.width, 100), BITMAP, ICON_RECT, 2)
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Image aligned to middle/left
  #--------------------------------------------------------------------------
  def test_alignMiddleLeft
    [@window, @sprite, @bitmap].each{|container|
      c = CImage.new(container, Rect.new(0, 24, @window.contents.width, 100), BITMAP, ICON_RECT, 0, 255, 1)
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Image aligned to middle/center
  #--------------------------------------------------------------------------
  def test_alignMiddleCenter
    [@window, @sprite, @bitmap].each{|container|
      c = CImage.new(container, Rect.new(0, 24, @window.contents.width, 100), BITMAP, ICON_RECT, 1, 255, 1)
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Image aligned to middle/right
  #--------------------------------------------------------------------------
  def test_alignMiddleRight
    [@window, @sprite, @bitmap].each{|container|
      c = CImage.new(container, Rect.new(0, 24, @window.contents.width, 100), BITMAP, ICON_RECT, 2, 255, 1)
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Image aligned to bottom/left
  #--------------------------------------------------------------------------
  def test_alignBottomLeft
    [@window, @sprite, @bitmap].each{|container|
      c = CImage.new(container, Rect.new(0, 24, @window.contents.width, 100), BITMAP, ICON_RECT, 0, 255, 2)
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Image aligned to bottom/center
  #--------------------------------------------------------------------------
  def test_alignBottomCenter
    [@window, @sprite, @bitmap].each{|container|
      c = CImage.new(container, Rect.new(0, 24, @window.contents.width, 100), BITMAP, ICON_RECT, 1, 255, 2)
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Image aligned to bottom/right
  #--------------------------------------------------------------------------
  def test_alignBottomRight
    [@window, @sprite, @bitmap].each{|container|
      c = CImage.new(container, Rect.new(0, 24, @window.contents.width, 100), BITMAP, ICON_RECT, 2, 255, 2)
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Image which is inactive
  #--------------------------------------------------------------------------
  def test_inactive
    [@window, @sprite, @bitmap].each{|container|
      c = CImage.new(container, Rect.new(100, 0, 100, 24), BITMAP, ICON_RECT)
      c.active = false
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Image which is invisible
  #--------------------------------------------------------------------------
  def test_invisible
    [@window, @sprite, @bitmap].each{|container|
      c = CImage.new(container, Rect.new(200, 0, 100, 24), BITMAP, ICON_RECT)
      c.visible = false
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Image with custom opacity
  #--------------------------------------------------------------------------
  def test_opacity
    [@window, @sprite, @bitmap].each{|container|
      c = CImage.new(container, Rect.new(300, 0, 100, 24), BITMAP, ICON_RECT, 0, 200)
      c.draw()
    }
    return true
  end
  
end

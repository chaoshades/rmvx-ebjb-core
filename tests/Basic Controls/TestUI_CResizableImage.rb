#==============================================================================
# ** TestUI_CResizableImage
#------------------------------------------------------------------------------
#  Unit tests for the ResizableImage control
#==============================================================================

class TestUI_CResizableImage < TestUI_Class
  
  #//////////////////////////////////////////////////////////////////////////
  # * Constants
  #//////////////////////////////////////////////////////////////////////////
  
  BITMAP = Cache.system("IconSet")
  ICON_RECT = Rect.new(1 % 16 * 24, 1 / 16 * 24, 24, 24)
  BIG_BITMAP = Cache.battler("Evilking", 0)
  BIG_RECT = Rect.new(0, 0, BIG_BITMAP.width, BIG_BITMAP.height)
  
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
      c = CResizableImage.new(container, Rect.new(0, 0, 24, 24), BITMAP, ICON_RECT)
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Image which is inactive
  #--------------------------------------------------------------------------
  def test_inactive
    [@window, @sprite, @bitmap].each{|container|
      c = CResizableImage.new(container, Rect.new(100, 0, 24, 24), BITMAP, ICON_RECT)
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
      c = CResizableImage.new(container, Rect.new(200, 0, 24, 24), BITMAP, ICON_RECT)
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
      c = CResizableImage.new(container, Rect.new(300, 0, 24, 24), BITMAP, ICON_RECT, 0, 200)
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Image with full resize
  #--------------------------------------------------------------------------
  def test_fullResize
    [@window, @sprite, @bitmap].each{|container|
      c = CResizableImage.new(container, Rect.new(0, 24, 100, 50), BITMAP, ICON_RECT)
      c.resize_mode = 0
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Image with width resizing only
  #--------------------------------------------------------------------------
  def test_widthResize
    [@window, @sprite, @bitmap].each{|container|
      c = CResizableImage.new(container, Rect.new(100, 24, 100, 50), BITMAP, ICON_RECT)
      c.resize_mode = 1
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Image with height resizing only
  #--------------------------------------------------------------------------
  def test_heightResize
    [@window, @sprite, @bitmap].each{|container|
      c = CResizableImage.new(container, Rect.new(200, 24, 100, 50), BITMAP, ICON_RECT)
      c.resize_mode = 2
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Image with full resize by respecting image ratio
  #--------------------------------------------------------------------------
  def test_fullResizeRatio
    [@window, @sprite, @bitmap].each{|container|
      c = CResizableImage.new(container, Rect.new(300, 24, 100, 50), BITMAP, ICON_RECT)
      c.resize_mode = 3
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Image with full resize
  #--------------------------------------------------------------------------
  def test_fullResize_Big
    [@window, @sprite, @bitmap].each{|container|
      c = CResizableImage.new(container, Rect.new(0, 74, 100, 50), BIG_BITMAP, BIG_RECT)
      c.resize_mode = 0
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Image with width resizing only
  #--------------------------------------------------------------------------
  def test_widthResize_Big
    [@window, @sprite, @bitmap].each{|container|
      c = CResizableImage.new(container, Rect.new(100, 74, 100, 50), BIG_BITMAP, BIG_RECT)
      c.resize_mode = 1
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Image with height resizing only
  #--------------------------------------------------------------------------
  def test_heightResize_Big
    [@window, @sprite, @bitmap].each{|container|
      c = CResizableImage.new(container, Rect.new(200, 74, 100, 50), BIG_BITMAP, BIG_RECT)
      c.resize_mode = 2
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Image with full resize by respecting image ratio
  #--------------------------------------------------------------------------
  def test_fullResizeRatio_Big
    [@window, @sprite, @bitmap].each{|container|
      c = CResizableImage.new(container, Rect.new(500, 74, 100, 50), BIG_BITMAP, BIG_RECT)
      c.resize_mode = 3
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Image with full resize by respecting image ratio aligned to left
  #--------------------------------------------------------------------------
  def test_fullResizeRatio_alignLeft
    [@window, @sprite, @bitmap].each{|container|
      c = CResizableImage.new(container, Rect.new(0, 124, @window.contents.width, 50), BITMAP, ICON_RECT, 0)
      c.resize_mode = 3
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Image with full resize by respecting image ratio aligned to center
  #--------------------------------------------------------------------------
  def test_fullResizeRatio_alignCenter
    [@window, @sprite, @bitmap].each{|container|
      c = CResizableImage.new(container, Rect.new(0, 124, @window.contents.width, 50), BITMAP, ICON_RECT, 1)
      c.resize_mode = 3
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Image with full resize by respecting image ratio aligned to right
  #--------------------------------------------------------------------------
  def test_fullResizeRatio_alignRight
    [@window, @sprite, @bitmap].each{|container|
      c = CResizableImage.new(container, Rect.new(0, 124, @window.contents.width, 50), BITMAP, ICON_RECT, 2)
      c.resize_mode = 3 
      c.draw()
    }
    return true
  end

  #--------------------------------------------------------------------------
  # * Image with full resize by respecting image ratio aligned to top
  #--------------------------------------------------------------------------
  def test_fullResizeRatio_alignTop
    [@window, @sprite, @bitmap].each{|container|
      c = CResizableImage.new(container, Rect.new(0, 224, 50, 150), BITMAP, ICON_RECT, 0, 255, 0)
      c.resize_mode = 3
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Image with full resize by respecting image ratio aligned to middle
  #--------------------------------------------------------------------------
  def test_fullResizeRatio_alignMiddle
    [@window, @sprite, @bitmap].each{|container|
      c = CResizableImage.new(container, Rect.new(0, 224, 50, 150), BITMAP, ICON_RECT, 0, 255, 1)
      c.resize_mode = 3
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Image with full resize by respecting image ratio aligned to bottom
  #--------------------------------------------------------------------------
  def test_widthResizeRatio_alignBottom
    [@window, @sprite, @bitmap].each{|container|
      c = CResizableImage.new(container, Rect.new(0, 224, 50, 150), BITMAP, ICON_RECT, 0, 255, 2)
      c.resize_mode = 3 
      c.draw()
    }
    return true
  end

  #--------------------------------------------------------------------------
  # * Image with height resize aligned to left
  #--------------------------------------------------------------------------
  def test_heightResize_alignLeft
    [@window, @sprite, @bitmap].each{|container|
      c = CResizableImage.new(container, Rect.new(0, 174, @window.contents.width, 50), BITMAP, ICON_RECT, 0)
      c.resize_mode = 2
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Image with height resizealigned to center
  #--------------------------------------------------------------------------
  def test_heightResize_alignCenter
    [@window, @sprite, @bitmap].each{|container|
      c = CResizableImage.new(container, Rect.new(0, 174, @window.contents.width, 50), BITMAP, ICON_RECT, 1)
      c.resize_mode = 2
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Image with height resize aligned to right
  #--------------------------------------------------------------------------
  def test_heightResize_alignRight
    [@window, @sprite, @bitmap].each{|container|
      c = CResizableImage.new(container, Rect.new(0, 174, @window.contents.width, 50), BITMAP, ICON_RECT, 2)
      c.resize_mode = 2
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Image with width resize aligned to top
  #--------------------------------------------------------------------------
  def test_widthResize_alignTop
    [@window, @sprite, @bitmap].each{|container|
      c = CResizableImage.new(container, Rect.new(100, 224, 50, 150), BITMAP, ICON_RECT, 0, 255, 0)
      c.resize_mode = 1
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Image with width resize aligned to middle
  #--------------------------------------------------------------------------
  def test_widthResize_alignMiddle
    [@window, @sprite, @bitmap].each{|container|
      c = CResizableImage.new(container, Rect.new(100, 224, 50, 150), BITMAP, ICON_RECT, 0, 255, 1)
      c.resize_mode = 1
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Image with width resize aligned to bottom
  #--------------------------------------------------------------------------
  def test_widthResize_alignBottom
    [@window, @sprite, @bitmap].each{|container|
      c = CResizableImage.new(container, Rect.new(100, 224, 50, 150), BITMAP, ICON_RECT, 0, 255, 2)
      c.resize_mode = 1
      c.draw()
    }
    return true
  end
  
end

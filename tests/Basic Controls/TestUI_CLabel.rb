#==============================================================================
# ** TestUI_CLabel
#------------------------------------------------------------------------------
#  Unit tests for the Label control
#==============================================================================

class TestUI_CLabel < TestUI_Class
  
  #//////////////////////////////////////////////////////////////////////////
  # * Constants
  #//////////////////////////////////////////////////////////////////////////
  
  MULTILINE_TEXT = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam odio tellus, eleifend gravida imperdiet ut, auctor sed sapien. Donec pharetra pulvinar ultrices. Proin sit amet sem facilisis ligula laoreet consectetur. Nulla elementum lobortis sem nec auctor. Suspendisse ullamcorper tortor sed sem dapibus fermentum."
  
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
  # * Default label
  #--------------------------------------------------------------------------
  def test_default
    [@window, @sprite, @bitmap].each{|container|
      c = CLabel.new(container, Rect.new(0, 0, 100, 24), "Label")
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Label with text aligned to left
  #--------------------------------------------------------------------------
  def test_alignLeft
    [@window, @sprite, @bitmap].each{|container|
      c = CLabel.new(container, Rect.new(0, 24, @window.contents.width, 24), "Left", 0)
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Label with text aligned to center
  #--------------------------------------------------------------------------
  def test_alignCenter
    [@window, @sprite, @bitmap].each{|container|
      c = CLabel.new(container, Rect.new(0, 24, @window.contents.width, 24), "Center", 1)
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Label with text aligned to right
  #--------------------------------------------------------------------------
  def test_alignRight
    [@window, @sprite, @bitmap].each{|container|
      c = CLabel.new(container, Rect.new(0, 24, @window.contents.width, 24), "Right", 2)
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Label with bold text
  #--------------------------------------------------------------------------
  def test_fontBold
    [@window, @sprite, @bitmap].each{|container|
      c = CLabel.new(container, Rect.new(100, 0, 100, 24), "Label", 0, Font.bold_font)
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Label with italic text
  #--------------------------------------------------------------------------
  def test_fontItalic
    [@window, @sprite, @bitmap].each{|container|
      c = CLabel.new(container, Rect.new(200, 0, 100, 24), "Label", 0, Font.italic_font)
      c.draw()
      }
    return true
  end

  #--------------------------------------------------------------------------
  # * Label with different font
  #--------------------------------------------------------------------------
  def test_fontDiff
    f = Font.new()
    f.color = Color.power_up_color()
    f.size = 20
    f.bold = true
    [@window, @sprite, @bitmap].each{|container|
      c = CLabel.new(container, Rect.new(300, 0, 100, 24), "Label", 0, f)
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Label which is inactive
  #--------------------------------------------------------------------------
  def test_inactive
    [@window, @sprite, @bitmap].each{|container|
      c = CLabel.new(container, Rect.new(400, 0, 100, 24), "Label")
      c.active = false
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Label which is invisible
  #--------------------------------------------------------------------------
  def test_invisible
    [@window, @sprite, @bitmap].each{|container|
      c = CLabel.new(container, Rect.new(500, 0, 100, 24), "Label")
      c.visible = false
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Label with multiline support
  #--------------------------------------------------------------------------
  def test_multiline
    [@window, @sprite, @bitmap].each{|container|
      c = CLabel.new(container, Rect.new(0, 48, 320, 24), MULTILINE_TEXT)
      c.multiline = true
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Label with overflow cutting support
  #--------------------------------------------------------------------------
  def test_cutOverflow
    [@window, @sprite, @bitmap].each{|container|
      c = CLabel.new(container, Rect.new(320, 48, 100, 24), "Long Long Long Long Label")
      c.cut_overflow = true
      c.draw()
    }
    return true
  end
  
end

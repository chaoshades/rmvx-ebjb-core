#==============================================================================
# ** TestUI_WindowScrollable
#------------------------------------------------------------------------------
#  Unit tests for the window scrollable
#==============================================================================

class TestUI_WindowScrollable < TestUI_Class

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
    @windows = []
    # setup your objects for the tests (if needed)
  end
  
  #--------------------------------------------------------------------------
  # * Tear down tests
  #--------------------------------------------------------------------------
  def testFixtureTearDown()
    for w in @windows
      w.dispose
    end
    @windows = nil
    # destroy your objects when the tests are finished (if needed)
  end
  
  #--------------------------------------------------------------------------
  # * Frame update
  #--------------------------------------------------------------------------
  def update()
    for w in @windows
      w.update
    end
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Tests
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Window_Scrollable by default
  #--------------------------------------------------------------------------
  def test_default
    w = Window_Scrollable.new(0,0,640,96)
    @windows.push(w)
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Window_Scrollable with vertical scrolling
  #--------------------------------------------------------------------------
  def test_verticalScroll
    w = Window_Scrollable.new(0,96,640,96)
    w.contents = Bitmap.update_bitmap_size(w.contents, w.contents.width, 192)
    c = CLabel.new(w.contents, Rect.new(0, 0, w.contents.width, 24), MULTILINE_TEXT)
    c.multiline = true
    c.draw()
    @windows.push(w)
    return true
  end

  #--------------------------------------------------------------------------
  # * Window_Scrollable with custom vertical scrolling speed
  #--------------------------------------------------------------------------
  def test_verticalScrollSpeed
    w = Window_Scrollable.new(0,192,640,96, 2)
    w.contents = Bitmap.update_bitmap_size(w.contents, w.contents.width, 192)
    c = CLabel.new(w.contents, Rect.new(0, 0, w.contents.width, 24), MULTILINE_TEXT)
    c.multiline = true
    c.draw()
    @windows.push(w)
    return true
  end

  #--------------------------------------------------------------------------
  # * Window_Scrollable with horizontal scrolling
  #--------------------------------------------------------------------------
  def test_horizontalScroll
    w = Window_Scrollable.new(0,288,320,150, 8, true)
    w.contents = Bitmap.update_bitmap_size(w.contents, 640, w.contents.height)
    c = CLabel.new(w.contents, Rect.new(0, 0, w.contents.width, 24), MULTILINE_TEXT)
    c.multiline = true
    c.draw()
    @windows.push(w)
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Window_Scrollable with custom horizontal scrolling speed
  #--------------------------------------------------------------------------
  def test_horizontalScrollSpeed
    w = Window_Scrollable.new(320,288,320,150, 2, true)
    w.contents = Bitmap.update_bitmap_size(w.contents, 640, w.contents.height)
    c = CLabel.new(w.contents, Rect.new(0, 0, w.contents.width, 24), MULTILINE_TEXT)
    c.multiline = true
    c.draw()
    @windows.push(w)
    return true
  end
  
end

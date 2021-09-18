#==============================================================================
# ** TestUI_WindowCustomSelectable
#------------------------------------------------------------------------------
#  Unit tests for the window custom selectable
#==============================================================================

class TestUI_WindowCustomSelectable < TestUI_Class
  
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
  # * WindowCustomSelectable by default
  #--------------------------------------------------------------------------
  def test_default
    w = Window_Custom_Selectable.new(0,0,320,96,nil)
    @windows.push(w)
    return true
  end
  
  #--------------------------------------------------------------------------
  # * WindowCustomSelectable with custom positions
  #--------------------------------------------------------------------------
  def test_positions
    w = Window_Custom_Selectable.new(320,0,320,96,[CursorPosition.new(Rect.new(0,0,20,20)),
                                                  CursorPosition.new(Rect.new(220,30,20,20)),
                                                  CursorPosition.new(Rect.new(0,26,10,40)),
                                                  CursorPosition.new(Rect.new(170,0,100,10))])
    @windows.push(w)
    return true
  end
  
  #--------------------------------------------------------------------------
  # * WindowCustomSelectable with custom positions with disabled ones
  #--------------------------------------------------------------------------
  def test_positionsEnabled
    w = Window_Custom_Selectable.new(0,96,320,96,[CursorPosition.new(Rect.new(0,0,20,20)),
                                                  CursorPosition.new(Rect.new(220,30,20,20), false),
                                                  CursorPosition.new(Rect.new(0,26,10,40)),
                                                  CursorPosition.new(Rect.new(170,0,100,10), false)])
    @windows.push(w)
    return true
  end
  
  #--------------------------------------------------------------------------
  # * WindowCustomSelectable with custom positions but with Up/Down movement
  #--------------------------------------------------------------------------
  def test_positionsUpDown
    w = Window_Custom_Selectable.new(320,96,320,96,[CursorPosition.new(Rect.new(0,0,20,20)),
                                                  CursorPosition.new(Rect.new(220,30,20,20)),
                                                  CursorPosition.new(Rect.new(0,26,10,40)),
                                                  CursorPosition.new(Rect.new(170,0,100,10))],true)
    @windows.push(w)
    return true
  end
  
  #--------------------------------------------------------------------------
  # * WindowCustomSelectable with custom positions on dummy windows
  #--------------------------------------------------------------------------
  def test_positionsDummyWindows
    w1 = Window_Base.new(0,192,120,60)
    @windows.push(w1)
    w2 = Window_Base.new(200,192,120,60)
    @windows.push(w2)
    w3 = Window_Base.new(400,192,120,60)
    @windows.push(w3)
    w4 = Window_Base.new(400,252,120,60)
    @windows.push(w4)
    w5 = Window_Base.new(0,312,640,60)
    @windows.push(w5)
    
    positions = []
    positions.push(CursorPosition.new(Rect.new(w1.x,w1.y,w1.width-32,w1.height-32)))
    positions.push(CursorPosition.new(Rect.new(w2.x,w2.y,w2.width-32,w2.height-32)))
    positions.push(CursorPosition.new(Rect.new(w3.x,w3.y,w3.width-32,w3.height-32)))
    positions.push(CursorPosition.new(Rect.new(w4.x,w4.y,w4.width-32,w4.height-32)))
    positions.push(CursorPosition.new(Rect.new(w5.x,w5.y,w5.width-32,w5.height-32)))
    
    w = Window_Custom_Selectable.new(0,0,640,480,positions)
    w.opacity = 0
    @windows.push(w)
    return true
  end
  
end

#==============================================================================
# ** TestUI_WindowEffects
#------------------------------------------------------------------------------
#  Unit tests for the window effects
#==============================================================================

class TestUI_WindowEffects < TestUI_Class
  
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
    @w_slideToggle.dispose
    @w_slideToggle = nil
    @w_fadeToggle.dispose
    @w_fadeToggle = nil
    @w_fadeToggleOpacity.dispose
    @w_fadeToggleOpacity = nil
    @w_moveToggle.dispose
    @w_moveToggle = nil
    @w_openToggle.dispose
    @w_openToggle = nil
    # destroy your objects when the tests are finished (if needed)
  end
  
  #--------------------------------------------------------------------------
  # * Frame update
  #--------------------------------------------------------------------------
  def update()
    for w in @windows
      w.update
    end
    @w_slideToggle.update
    @w_fadeToggle.update
    @w_fadeToggleOpacity.update
    @w_moveToggle.update
    @w_openToggle.update
    
    if @slideToggle_duration == 0
      slideToggle()
    else
      @slideToggle_duration -= 1
    end
    
    if @fadeToggle_duration == 0
      fadeToggle()
    else
      @fadeToggle_duration -= 1
    end

    if @fadeToggleOpacity_duration == 0
      fadeToggleOpacity()
    else
      @fadeToggleOpacity_duration -= 1
    end
    
    if @moveToggle_duration == 0
      moveToggle()
    else
      @moveToggle_duration -= 1
    end
    
    if @openToggle_duration == 0
      openToggle()
    else
      @openToggle_duration -= 1
    end
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Tests
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * SlideDown by default
  #--------------------------------------------------------------------------
  def test_slideDown
    w = Window_Base.new(0, 0, 100, 50)
    @windows.push(w)
    w.visible = false
    w.slideDown()
    return true
  end
  
  #--------------------------------------------------------------------------
  # * SlideUp by default
  #--------------------------------------------------------------------------
  def test_slideUp
    w = Window_Base.new(100, 0, 100, 50)
    @windows.push(w)
    w.slideUp()
    return true
  end
  
  #--------------------------------------------------------------------------
  # * SlideDown with custom animation speed
  #--------------------------------------------------------------------------
  def test_slideDown_Speed
    w = Window_Base.new(200, 0, 100, 50)
    @windows.push(w)
    w.animationSpeed = 2000
    w.visible = false
    w.slideDown()
    return true
  end
  
  #--------------------------------------------------------------------------
  # * SlideUp with custom animation speed
  #--------------------------------------------------------------------------
  def test_slideUp_Speed
    w = Window_Base.new(300, 0, 100, 50)
    @windows.push(w)
    w.animationSpeed = 2000
    w.slideUp()
    return true
  end
  
  #--------------------------------------------------------------------------
  # * FadeIn by default
  #--------------------------------------------------------------------------
  def test_fadeIn
    w = Window_Base.new(0, 50, 100, 50)
    @windows.push(w)
    w.visible = false
    w.fadeIn()
    return true
  end
  
  #--------------------------------------------------------------------------
  # * FadeOut by default
  #--------------------------------------------------------------------------
  def test_fadeOut
    w = Window_Base.new(100, 50, 100, 50)
    @windows.push(w)
    w.fadeOut()
    return true
  end
  
  #--------------------------------------------------------------------------
  # * FadeIn with custom animation speed
  #--------------------------------------------------------------------------
  def test_fadeIn_Speed
    w = Window_Base.new(200, 50, 100, 50)
    @windows.push(w)
    w.animationSpeed = 2000
    w.visible = false
    w.fadeIn()
    return true
  end
  
  #--------------------------------------------------------------------------
  # * FadeOut with custom animation speed
  #--------------------------------------------------------------------------
  def test_fadeOut_Speed
    w = Window_Base.new(300, 50, 100, 50)
    @windows.push(w)
    w.animationSpeed = 2000
    w.fadeOut()
    return true
  end
  
  #--------------------------------------------------------------------------
  # * FadeIn with custom opacity
  #--------------------------------------------------------------------------
  def test_fadeIn_Opacity
    w = Window_Base.new(400, 50, 100, 50)
    @windows.push(w)
    w.opacity = 128
    w.visible = false
    w.fadeIn()
    return true
  end
  
  #--------------------------------------------------------------------------
  # * FadeOut with custom opacity
  #--------------------------------------------------------------------------
  def test_fadeOut_Opacity
    w = Window_Base.new(500, 50, 100, 50)
    @windows.push(w)
    w.opacity = 128
    w.fadeOut()
    return true
  end
  
  #--------------------------------------------------------------------------
  # * MoveTo by default
  #--------------------------------------------------------------------------
  def test_moveTo
    w = Window_Base.new(400, 100, 100, 50)
    @windows.push(w)
    w.moveTo(400, 150)
    return true
  end
  
  #--------------------------------------------------------------------------
  # * MoveTo with custom animation speed
  #--------------------------------------------------------------------------
  def test_moveTo_Speed
    w = Window_Base.new(500, 100, 100, 50)
    @windows.push(w)
    w.animationSpeed = 2000
    w.moveTo(500, 150)
    return true
  end
  
  #--------------------------------------------------------------------------
  # * MoveTo from outside left to inside with custom animation speed
  #--------------------------------------------------------------------------
  def test_moveTo_Inside_Left
    w = Window_Base.new(-100, 100, 100, 50)
    @windows.push(w)
    w.animationSpeed = 2000
    w.moveTo(0, 100)
    return true
  end
  
  #--------------------------------------------------------------------------
  # * MoveTo from outside top to inside with custom animation speed
  #--------------------------------------------------------------------------
  def test_moveTo_Inside_Top
    w = Window_Base.new(100, -50, 100, 50)
    @windows.push(w)
    w.animationSpeed = 2000
    w.moveTo(100, 100)
    return true
  end
  
  #--------------------------------------------------------------------------
  # * MoveTo from outside bottom to inside with custom animation speed
  #--------------------------------------------------------------------------
  def test_moveTo_Inside_Bottom
    w = Window_Base.new(200, 530, 100, 50)
    @windows.push(w)
    w.animationSpeed = 2000
    w.moveTo(200, 100)
    return true
  end
  
  #--------------------------------------------------------------------------
  # * MoveTo from outside right to inside with custom animation speed
  #--------------------------------------------------------------------------
  def test_moveTo_Inside_Right
    w = Window_Base.new(740, 100, 100, 50)
    @windows.push(w)
    w.animationSpeed = 2000
    w.moveTo(300, 100)
    return true
  end
  
  #--------------------------------------------------------------------------
  # * MoveTo from inside to outside left with custom animation speed
  #--------------------------------------------------------------------------
  def test_moveTo_Outside_Left
    w = Window_Base.new(0, 150, 100, 50)
    @windows.push(w)
    w.animationSpeed = 2000
    w.moveTo(-100, 150)
    return true
  end
  
  #--------------------------------------------------------------------------
  # * MoveTo from inside to outside top with custom animation speed
  #--------------------------------------------------------------------------
  def test_moveTo_Outside_Top
    w = Window_Base.new(100, 150, 100, 50)
    @windows.push(w)
    w.animationSpeed = 2000
    w.moveTo(100, -50)
    return true
  end
  
  #--------------------------------------------------------------------------
  # * MoveTo from inside to outside bottom with custom animation speed
  #--------------------------------------------------------------------------
  def test_moveTo_Outside_Bottom
    w = Window_Base.new(200, 150, 100, 50)
    @windows.push(w)
    w.animationSpeed = 2000
    w.moveTo(200, 530)
    return true
  end
  
  #--------------------------------------------------------------------------
  # * MoveTo from inside to outside right with custom animation speed
  #--------------------------------------------------------------------------
  def test_moveTo_Outside_Right
    w = Window_Base.new(300, 150, 100, 50)
    @windows.push(w)
    w.animationSpeed = 2000
    w.moveTo(740, 150)
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Open by default
  #--------------------------------------------------------------------------
  def test_open
    w = Window_Base.new(0, 200, 100, 50)
    @windows.push(w)
    w.openness = 0
    w.open()
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Close by default
  #--------------------------------------------------------------------------
  def test_close
    w = Window_Base.new(100, 200, 100, 50)
    @windows.push(w)
    w.close()
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Open with custom animation speed
  #--------------------------------------------------------------------------
  def test_open_Speed
    w = Window_Base.new(200, 200, 100, 50)
    @windows.push(w)
    w.animationSpeed = 2000
    w.openness = 0
    w.open()
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Close with custom animation speed
  #--------------------------------------------------------------------------
  def test_close_Speed
    w = Window_Base.new(300, 200, 100, 50)
    @windows.push(w)
    w.animationSpeed = 2000
    w.close()
    return true
  end
  
  #--------------------------------------------------------------------------
  # * SlideDown & SlideUp called consecutively
  #--------------------------------------------------------------------------
  def test_slideDownUp
    @w_slideToggle = Window_Base.new(0, 250, 100, 50)
    @w_slideToggle.animationSpeed = 2000
    @w_slideToggle.visible = false
    slideToggle()
    return true
  end
  
  #--------------------------------------------------------------------------
  # * FadeIn & FadeOut called consecutively
  #--------------------------------------------------------------------------
  def test_fadeInOut
    @w_fadeToggle = Window_Base.new(100, 250, 100, 50)
    @w_fadeToggle.animationSpeed = 2000
    @w_fadeToggle.visible = false
    fadeToggle()
    return true
  end
  
  #--------------------------------------------------------------------------
  # * FadeIn & FadeOut called consecutively
  #--------------------------------------------------------------------------
  def test_fadeInOut_Opacity
    @w_fadeToggleOpacity = Window_Base.new(200, 250, 100, 50)
    @w_fadeToggleOpacity.animationSpeed = 2000
    @w_fadeToggleOpacity.opacity = 128
    @w_fadeToggleOpacity.visible = false
    fadeToggleOpacity()
    return true
  end
  
  #--------------------------------------------------------------------------
  # * MoveTo called consecutively
  #--------------------------------------------------------------------------
  def test_moveTomoveTo
    @w_moveToggle = Window_Base.new(300, 250, 100, 50)
    @w_moveToggle.animationSpeed = 2000
    moveToggle()
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Open & Close called consecutively
  #--------------------------------------------------------------------------
  def test_openClose
    @w_openToggle = Window_Base.new(400, 250, 100, 50)
    @w_openToggle.animationSpeed = 2000
    openToggle()
    return true
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Private Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Toggle between SlideDown & SlideUp
  #--------------------------------------------------------------------------
  def slideToggle()
    @slideToggle_duration = @w_slideToggle.animationSpeed
    if (!@w_slideToggle.visible)
      @w_slideToggle.slideDown()
    else
      @w_slideToggle.slideUp()
    end
  end
  
  #--------------------------------------------------------------------------
  # * Toggle between FadeIn & FadeOut
  #--------------------------------------------------------------------------
  def fadeToggle()
    @fadeToggle_duration = @w_fadeToggle.animationSpeed
    if (!@w_fadeToggle.visible)
      @w_fadeToggle.fadeIn()
    else
      @w_fadeToggle.fadeOut()
    end
  end
  
  #--------------------------------------------------------------------------
  # * Toggle between FadeIn & FadeOut
  #--------------------------------------------------------------------------
  def fadeToggleOpacity()
    @fadeToggleOpacity_duration = @w_fadeToggleOpacity.animationSpeed
    if (!@w_fadeToggleOpacity.visible)
      @w_fadeToggleOpacity.fadeIn()
    else
      @w_fadeToggleOpacity.fadeOut()
    end
  end
  
  #--------------------------------------------------------------------------
  # * Toggle between two moveTo with different positions
  #--------------------------------------------------------------------------
  def moveToggle()
    @moveToggle_duration = @w_moveToggle.animationSpeed
    if (@w_moveToggle.x != 300 && @w_moveToggle.y != 250)
      @w_moveToggle.moveTo(300, 250)
    else
      @w_moveToggle.moveTo(350, 300)
    end
  end
  
  #--------------------------------------------------------------------------
  # * Toggle between Open & Close
  #--------------------------------------------------------------------------
  def openToggle()
    @openToggle_duration = @w_openToggle.animationSpeed
    if (@w_openToggle.openness != 255)
      @w_openToggle.open()
    else
      @w_openToggle.close()
    end
  end
  
end

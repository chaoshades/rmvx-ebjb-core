#==============================================================================
# ** TestUI_WindowSkillDetails
#------------------------------------------------------------------------------
#  Unit tests for the window skill details
#==============================================================================

class TestUI_WindowSkillDetails < TestUI_Class
  
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
  # * Window_SkillDetails by default
  #--------------------------------------------------------------------------
  def test_default
    w = Window_SkillDetails.new(0,0,640,96,nil)
    @windows.push(w)
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Window_SkillDetails with simple recovery skill
  #--------------------------------------------------------------------------
  def test_simpleRecoverySkill
    w = Window_SkillDetails.new(0,96,640,96,$data_skills[33])
    @windows.push(w)
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Window_SkillDetails with simple damage skill
  #--------------------------------------------------------------------------
  def test_simpleDamageSkill
    w = Window_SkillDetails.new(0,192,640,96,$data_skills[59])
    @windows.push(w)
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Window_SkillDetails with full recovery skill
  #--------------------------------------------------------------------------
  def test_fullRecoverySkill
    w = Window_SkillDetails.new(0,288,640,96,$data_skills[83])
    @windows.push(w)
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Window_SkillDetails with full damage skill
  #--------------------------------------------------------------------------
  def test_fullDamageSkill
    w = Window_SkillDetails.new(0,384,640,96,$data_skills[84])
    @windows.push(w)
    return true
  end
  
end

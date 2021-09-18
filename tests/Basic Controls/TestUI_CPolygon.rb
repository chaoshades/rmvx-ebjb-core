#==============================================================================
# ** TestUI_CPolygon
#------------------------------------------------------------------------------
#  Unit tests for the Polygon control
#==============================================================================

class TestUI_CPolygon < TestUI_Class
  
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
  # * Default polygon (I took a square for the example)
  #--------------------------------------------------------------------------
  def test_default
    [@window, @sprite, @bitmap].each{|container|
      c = CPolygon.new(container, [[0,0],[100,0],[100,50],[0,50]], Color.hp_gauge_color1)
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Polygon which is inactive
  #--------------------------------------------------------------------------
  def test_inactive
    [@window, @sprite, @bitmap].each{|container|
      c = CPolygon.new(container, [[100,0],[200,0],[200,50],[100,50]], Color.hp_gauge_color1)
      c.active = false
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Polygon which is invisible
  #--------------------------------------------------------------------------
  def test_invisible
    [@window, @sprite, @bitmap].each{|container|
      c = CPolygon.new(container, [[200,0],[300,0],[300,50],[200,50]], Color.hp_gauge_color1)
      c.visible = false
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Polygon with a gradient
  #--------------------------------------------------------------------------
  def test_gradient
    [@window, @sprite, @bitmap].each{|container|
      c = CPolygon.new(container, [[300,0],[400,0],[400,50],[300,50]], Color.hp_gauge_color1, true, Color.hp_gauge_color2)
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Polygon with a gradient which is inactive
  #--------------------------------------------------------------------------
  def test_inactiveGradient
    [@window, @sprite, @bitmap].each{|container|
      c = CPolygon.new(container, [[400,0],[500,0],[500,50],[400,50]], Color.hp_gauge_color1, true, Color.hp_gauge_color2)
      c.active = false
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Polygon with a border
  #--------------------------------------------------------------------------
  def test_border
    [@window, @sprite, @bitmap].each{|container|
      c = CPolygon.new(container, [[0,50],[100,50],[100,100],[0,100]], Color.gauge_back_color, true, Color.gauge_back_color,
          1, Color.hp_gauge_color1)
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Polygon with a border which is inactive
  #--------------------------------------------------------------------------
  def test_inactiveBorder
    [@window, @sprite, @bitmap].each{|container|
      c = CPolygon.new(container, [[100,50],[200,50],[200,100],[100,100]], Color.gauge_back_color, true, Color.gauge_back_color,
          1, Color.hp_gauge_color1)
      c.active = false
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Polygon with a gradient border
  #--------------------------------------------------------------------------
  def test_gradientBorder
    [@window, @sprite, @bitmap].each{|container|
      c = CPolygon.new(container, [[200,50],[300,50],[300,100],[200,100]], Color.gauge_back_color, true, Color.gauge_back_color,
          1, Color.hp_gauge_color1, Color.hp_gauge_color2)
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Polygon with a gradient border which is inactive
  #--------------------------------------------------------------------------
  def test_inactiveGradientBorder
    [@window, @sprite, @bitmap].each{|container|
      c = CPolygon.new(container, [[300,50],[400,50],[400,100],[300,100]], Color.gauge_back_color, true, Color.gauge_back_color,
          1, Color.hp_gauge_color1, Color.hp_gauge_color2)
      c.active = false
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Polygon not filled with a border
  #--------------------------------------------------------------------------
  def test_notFilled_Border
    [@window, @sprite, @bitmap].each{|container|
      c = CPolygon.new(container, [[0,100],[100,100],[100,150],[0,150]], nil, false, nil,
          1, Color.hp_gauge_color1)
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Polygon with a border which is inactive
  #--------------------------------------------------------------------------
  def test_notFilled_inactiveBorder
    [@window, @sprite, @bitmap].each{|container|
      c = CPolygon.new(container, [[100,100],[200,100],[200,150],[100,150]], nil, false, nil,
          1, Color.hp_gauge_color1)
      c.active = false
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Polygon with a gradient border
  #--------------------------------------------------------------------------
  def test_notFilled_gradientBorder
    [@window, @sprite, @bitmap].each{|container|
      c = CPolygon.new(container, [[200,100],[300,100],[300,150],[200,150]], nil, false, nil,
          1, Color.hp_gauge_color1, Color.hp_gauge_color2)
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Polygon with a gradient border which is inactive
  #--------------------------------------------------------------------------
  def test_notFilled_inactiveGradientBorder
    [@window, @sprite, @bitmap].each{|container|
      c = CPolygon.new(container, [[300,100],[400,100],[400,150],[300,150]], nil, false, nil,
          1, Color.hp_gauge_color1, Color.hp_gauge_color2)
      c.active = false
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Default polygon with 3 vertices
  #--------------------------------------------------------------------------
  def test_default_3Vertices
    [@window, @sprite, @bitmap].each{|container|
      c = CPolygon.new(container, [[0,200],[100,200],[50,250]], Color.hp_gauge_color1)
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Polygon with 3 vertices with border only
  #--------------------------------------------------------------------------
  def test_border_3Vertices
    [@window, @sprite, @bitmap].each{|container|
      c = CPolygon.new(container, [[100,200],[200,200],[150,250]], nil, false, nil,
          1, Color.hp_gauge_color1)
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Polygon with 3 vertices with gradient
  #--------------------------------------------------------------------------
  def test_gradient_3Vertices
    [@window, @sprite, @bitmap].each{|container|
      c = CPolygon.new(container, [[0,350],[100,350],[50,400]], Color.hp_gauge_color1, true, Color.hp_gauge_color2)
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Default polygon with 4 vertices
  #--------------------------------------------------------------------------
  def test_default_4Vertices
    [@window, @sprite, @bitmap].each{|container|
      c = CPolygon.new(container, [[200,200],[250,200],[250,250],[200,250]], Color.hp_gauge_color1)
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Polygon with 4 vertices with border only
  #--------------------------------------------------------------------------
  def test_border_4Vertices
    [@window, @sprite, @bitmap].each{|container|
      c = CPolygon.new(container, [[250,200],[300,200],[300,250],[250,250]], nil, false, nil,
          1, Color.hp_gauge_color1)
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Polygon with 4 vertices with gradient
  #--------------------------------------------------------------------------
  def test_gradient_4Vertices
    [@window, @sprite, @bitmap].each{|container|
      c = CPolygon.new(container, [[100,350],[150,350],[150,400],[100,400]], Color.hp_gauge_color1, true, Color.hp_gauge_color2)
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Default polygon with 5 vertices
  #--------------------------------------------------------------------------
  def test_default_5Vertices
    [@window, @sprite, @bitmap].each{|container|
      c = CPolygon.new(container, [[300,220],[325,200],[350,220],[340,250],[310,250]], Color.hp_gauge_color1)
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Polygon with 5 vertices with border only
  #--------------------------------------------------------------------------
  def test_border_5Vertices
    [@window, @sprite, @bitmap].each{|container|
      c = CPolygon.new(container, [[350,220],[375,200],[400,220],[390,250],[360,250]], nil, false, nil,
          1, Color.hp_gauge_color1)
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Polygon with 5 vertices with gradient
  #--------------------------------------------------------------------------
  def test_gradient_5Vertices
    [@window, @sprite, @bitmap].each{|container|
      c = CPolygon.new(container, [[150,370],[175,350],[200,370],[190,400],[160,400]], Color.hp_gauge_color1, true, Color.hp_gauge_color2)
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Default polygon with 6 vertices
  #--------------------------------------------------------------------------
  def test_default_6Vertices
    [@window, @sprite, @bitmap].each{|container|
      c = CPolygon.new(container, [[0,300],[25,260],[75,260],[100,300],[75,340],[25,340]], Color.hp_gauge_color1)
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Polygon with 6 vertices with border only
  #--------------------------------------------------------------------------
  def test_border_6Vertices
    [@window, @sprite, @bitmap].each{|container|
      c = CPolygon.new(container, [[100,300],[125,260],[175,260],[200,300],[175,340],[125,340]], nil, false, nil,
          1, Color.hp_gauge_color1)
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Polygon with 6 vertices with gradient
  #--------------------------------------------------------------------------
  def test_gradient_6Vertices
    [@window, @sprite, @bitmap].each{|container|
      c = CPolygon.new(container, [[200,400],[225,360],[275,360],[300,400],[275,440],[225,440]], Color.hp_gauge_color1, true, Color.hp_gauge_color2)
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Default polygon with 7 vertices
  #--------------------------------------------------------------------------
  def test_default_7Vertices
    [@window, @sprite, @bitmap].each{|container|
      c = CPolygon.new(container, [[200,310],[210,280],[250,260],[290,280],[300,310],[270,340],[230,340]], Color.hp_gauge_color1)
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Polygon with 7 vertices with border only
  #--------------------------------------------------------------------------
  def test_border_7Vertices
    [@window, @sprite, @bitmap].each{|container|
      c = CPolygon.new(container, [[300,310],[310,280],[350,260],[390,280],[400,310],[370,340],[330,340]], nil, false, nil,
          1, Color.hp_gauge_color1)
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Polygon with 7 vertices with gradient
  #--------------------------------------------------------------------------
  def test_gradient_7Vertices
    [@window, @sprite, @bitmap].each{|container|
      c = CPolygon.new(container, [[300,410],[310,380],[350,360],[390,380],[400,410],[370,440],[330,440]], Color.hp_gauge_color1, true, Color.hp_gauge_color2)
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Default polygon with 8 vertices
  #--------------------------------------------------------------------------
  def test_default_8Vertices
    [@window, @sprite, @bitmap].each{|container|
      c = CPolygon.new(container, [[400,285],[425,260],[450,260],[475,285],[475,310],[450,335],[425,335],[400,310]], Color.hp_gauge_color1)
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Polygon with 8 vertices with border only
  #--------------------------------------------------------------------------
  def test_border_8Vertices
    [@window, @sprite, @bitmap].each{|container|
      c = CPolygon.new(container, [[475,285],[500,260],[525,260],[550,285],[550,310],[525,335],[500,335],[475,310]], nil, false, nil,
          1, Color.hp_gauge_color1)
      c.draw()
    }
    return true
  end
  
  #--------------------------------------------------------------------------
  # * Polygon with 8 vertices with gradient
  #--------------------------------------------------------------------------
  def test_gradient_8Vertices
    [@window, @sprite, @bitmap].each{|container|
      c = CPolygon.new(container, [[400,385],[425,360],[450,360],[475,385],[475,410],[450,435],[425,435],[400,410]], Color.hp_gauge_color1, true, Color.hp_gauge_color2)
      c.draw()
    }
    return true
  end
  
end

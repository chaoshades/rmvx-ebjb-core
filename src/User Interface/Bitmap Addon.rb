#==============================================================================
# ** Bitmap Addon
#------------------------------------------------------------------------------
#  Addon function for drawing lines, circles & polygons
#
#  Based on MACL script
#  Credits to MACL Team (Trickster, SephirothSpawn)
#==============================================================================

class Bitmap
  include EBJB
  
  #//////////////////////////////////////////////////////////////////////////
  # * Public Methods
  #//////////////////////////////////////////////////////////////////////////
  
  #--------------------------------------------------------------------------
  # * Draw the text specified in multiline
  #     rect : rectangle in which the text will be draw
  #     text : text to draw
  #     align : text alignment
  #     multiline_mode = multiline mode (see class description)
  #--------------------------------------------------------------------------
  def draw_multiline_text(rect, text, align=0, multiline_mode=0)
    return if text == nil
    
    lines = split_multiline(rect, text, multiline_mode)
    
    y = rect.y
    line = lines.shift()
    case multiline_mode
    when 0
      # Draw first line normally
      self.draw_text(rect.x, y, rect.width, rect.height, line, align)
      y += rect.height
      text_height = 0
    when 1
      # Draw first line with a specific x and restart to 0 after
      self.draw_text(rect.x, y, rect.width-rect.x, rect.height, line, align)
      y += rect.height
      rect.x = 0
      text_height = 0
    when 2
      # Draw first line with a specific height and restart to text height after
      orig_height = rect.height
      text_height = get_text_height(line)
      if text_height < CORE_CONFIG::LINE_HEIGHT
        text_height = CORE_CONFIG::LINE_HEIGHT
      end
      rect.height = text_height
      self.draw_text(rect.x, y, rect.width, rect.height, line, align)
      y += orig_height
    when 3
      # Mixes mode 1 and 2
      orig_height = rect.height
      text_height = get_text_height(line)
      if text_height < CORE_CONFIG::LINE_HEIGHT
        text_height = CORE_CONFIG::LINE_HEIGHT
      end
      rect.height = text_height
      self.draw_text(rect.x, y, rect.width-rect.x, rect.height, line, align)
      y += orig_height
      rect.x = 0
    else
      # Does nothing
    end
    
#~     if (text_height+(rect.height * lines.size-1)) > self.height - 32
#~       temp_font = self.font.clone
#~       self.dispose
#~       self = Bitmap.new(self.width - 32, text_height+(rect.height * lines.size-1))
#~       self.font = temp_font
#~       self.oy = 0
#~     end
    
    for line in lines
      self.draw_text(rect.x, y, rect.width, rect.height, line, align)
      y += rect.height
    end

  end
  
  #--------------------------------------------------------------------------
  # * Draw the text specified and cutting the overflow
  #     rect : rectangle in which the text will be draw
  #     text : text to draw
  #     align : text alignment
  #--------------------------------------------------------------------------
  def draw_cut_overflow_text(rect, text, align=0)
    return if text == nil
    # built-in draw_text method can reduce the text width up to 60%, so
    # adjust the size to allow the text to be reduced normally before
    # adding the CUT_OVERFLOW_CHARACTER
    length = (get_text_width(text) * 0.5).floor
    
    if (length >= rect.width)
      cutText = format_cut_overflow(rect, text)
    else
      cutText = text
    end
    
    self.draw_text(rect, cutText, align)
  end
  
  #--------------------------------------------------------------------------
  # * Split text in multiline
  #     rect : rectangle in which the text will be drawn
  #     text : text to split
  #     multiline_mode = multiline mode (see class description)
  #--------------------------------------------------------------------------
  def split_multiline(rect, text, multiline_mode=0)
    return [] if text == nil

    case multiline_mode
    when 0
      # Draw first line normally
      x_adjustment = 0
    when 1
      # Draw first line with a specific x and restart to 0 after
      x_adjustment = rect.x
    when 2
      # Draw first line with a specific height and restart to text height after
      x_adjustment = 0
    when 3
      # Mixes mode 1 and 2
      x_adjustment = rect.x
    else
      # Does nothing
    end
    
    textblocks = text.split(CORE_CONFIG::END_LINE_CHARACTER)
    
    lines = []
    for block in textblocks
      length = get_text_width(block)
      
      if (length >= (rect.width-x_adjustment))
        multilineText = format_multiline(rect, block, x_adjustment)
        lines.concat(multilineText.split(CORE_CONFIG::END_LINE_CHARACTER))
      else
        lines.push(block)
      end
    end
    
    return lines
  end
  
  #--------------------------------------------------------------------------
  # * Get the size (width) of the string on the window (with the font)
  #     str : string
  #--------------------------------------------------------------------------
  def get_text_width(str)
    if str != nil
      return self.text_size(str).width
    else
      return 0
    end
  end
  
  #--------------------------------------------------------------------------
  # * Get the size (height) of the string on the window (with the font)
  #     str : string
  #--------------------------------------------------------------------------
  def get_text_height(str)
    if str != nil
      return self.text_size(str).height
    else
      return 0
    end
  end
  
  #-------------------------------------------------------------------------
  # * Draw line (uses the Digital Differential Analyzer Algorithm)
  #     x1 : first line X coordinate
  #     y1 : first line Y coordinate
  #     x2 : second line X coordinate
  #     y2 : second line Y coordinate
  #     c1 : fill color 1 of the line
  #     width : line width
  #     c2 : fill color 2 of the line (used for gradient) 
  #     vertical : true to have a vertical gradient, else false
  #-------------------------------------------------------------------------
  def draw_line(x1, y1, x2, y2, c1, width=1, c2=c1, vertical=false)
    # Return if width is less than or 0
    return if width <= 0
    # Reverse all parameters sent if 2 x is less than the first x
    #x1, x2, y1, y2 = x2, x1, y2, y1 if x2 < x1    
    
    # Get S (1/2 width)
    s = width / 2.0
    gradient = c1 != c2
    
    # If X & Y Coordinates are equal
    if x1 == x2 && y1 == y2
      self.set_pixel(x1, y1, c1)
    # If X Coordinates are equal
    elsif x1 == x2 && y1 != y2
      # Draw Vertical line
      if gradient
        self.gradient_fill_rect(x1 - s, [y1, y2].min, width, (y2 - y1).abs, c1, c2, vertical)
      else
        self.fill_rect(x1 - s, [y1, y2].min, width, (y2 - y1).abs, c1)
      end
    # If Y Coordinates are equal
    elsif y1 == y2 && x1 != x2
      # Draw Horizontal line
      if gradient
        self.gradient_fill_rect([x1, x2].min, y1 - s, (x2 - x1).abs, width, c1, c2, vertical)
      else
        self.fill_rect([x1, x2].min, y1 - s, (x2 - x1).abs, width, c1)
      end
    else
      distance = (x1 - x2).abs + (y1 - y2).abs

      color = c1
      for i in 1..distance
        # Get Percent Distance and I Distance
        per_dist, i_dist = (distance-i)/distance.to_f, i/distance.to_f

        x = (x1 + 1.0 * (x2 - x1) * i_dist).to_i
        y = (y1 + 1.0 * (y2 - y1) * i_dist).to_i

        if gradient
          r = c1.red * per_dist + c2.red * i_dist
          g = c1.green * per_dist + c2.green * i_dist
          b = c1.blue * per_dist + c2.blue * i_dist
          a = c1.alpha * per_dist + c2.alpha * i_dist
          color = Color.new(r, g, b, a)
        end
        
        if width == 1
          self.set_pixel(x-s, y-s, color)
        else
          self.fill_rect(x-s, y-s, width, width, color)
        end
      end
    end
  end
  
  #-------------------------------------------------------------------------
  # * Draw filled circle
  #     x : center of the circle X coordinate
  #     y : center of the circle Y coordinate
  #     radius : radius of the circle
  #     color1 : fill color 1 of the circle
  #     color2 : fill color 2 of the circle (used for gradient) 
  #-------------------------------------------------------------------------
  def draw_filled_circle(x, y, radius, color1, color2=color1)        

    # Starts From Left
    for i in (x - radius)..(x + radius)
      # Finds Distance From Center
      j = (i - x).abs
      # Finds X Position
      x_ = i < x ? x - j : i == x ? x : x + j
      # Finds Top Vertical Portion
      k = Integer((radius ** 2 - j ** 2) ** 0.5)
      # Draws Lines from center
      draw_line(x, y, x_, y-k, color1, 1, color2)
      draw_line(x, y, x_, y+k, color1, 1, color2)
    end
      
    # Switch variables to draw a circle from top
    x = x + y
    y = x - y
    x = x - y
      
    # Starts From Top
    for i in (x - radius)..(x + radius)
      # Finds Distance From Center
      j = (i - x).abs
      # Finds X Position
      x_ = i < x ? x - j : i == x ? x : x + j
      # Finds Top Vertical Portion
      k = Integer((radius ** 2 - j ** 2) ** 0.5)
      # Draws Lines from center
      draw_line(y, x, y-k, x_, color1, 1, color2)
      draw_line(y, x, y+k, x_, color1, 1, color2)
    end
    
  end
  
  #-------------------------------------------------------------------------
  # * Draw circle
  #     x : center of the circle X coordinate
  #     y : center of the circle Y coordinate
  #     radius : radius of the circle
  #     color1 : color 1 of the circle
  #     stroke : size of the stroke of the circle
  #     color2 : color 2 of the circle (used for gradient) 
  #-------------------------------------------------------------------------
  def draw_circle(x, y, radius, color1, stroke=1, color2=color1)        
    # Return if no width
    return if stroke <= 0
    
    rad = radius + stroke
    # Starts From Left
    for i in (x - rad)..(x + rad)
      # Finds Distance From Center
      j = (i - x).abs
      j2 = j - stroke
      # Finds X Position
      x_ = i < x ? x - j : i == x ? x : x + j
      x2_= i < x ? x - j2 : i == x ? x : x + j2
      # Finds Top Vertical Portion
      k = Integer((rad ** 2 - j ** 2) ** 0.5)
      k2 = Integer((radius ** 2 - j2 ** 2) ** 0.5)
      # Draws lines for border
      draw_line(x_, y-k, x2_, y-k2, color1, 1, color2)
      draw_line(x_, y+k, x2_, y+k2, color1, 1, color2)
    end
     
    # Switch variables to draw a circle from top
    x = x + y
    y = x - y
    x = x - y
      
    # Starts From Top
    for i in (x - rad)..(x + rad)
      # Finds Distance From Center
      j = (x - i).abs
      j2 = j - stroke
      # Finds X Position
      x_ = i < x ? x - j : i == x ? x : x + j
      x2_= i < x ? x - j2 : i == x ? x : x + j2
      # Finds Top Vertical Portion
      k = Integer((rad ** 2 - j ** 2) ** 0.5)
      k2 = Integer((radius ** 2 - j2 ** 2) ** 0.5)
      # Draws lines for border
      draw_line(y-k, x_, y-k2, x2_, color1, 1, color2)
      draw_line(y+k, x_, y+k2, x2_, color1, 1, color2)
    end
    
  end
  
  #-------------------------------------------------------------------------
  # * Draw filled polygon
  #     vertices : vertices to draw the polygon
  #     color1 : fill color 1 of the polygon
  #     color2 : fill color 2 of the polygon (used for gradient) 
  #-------------------------------------------------------------------------
  def draw_filled_polygon(vertices, color1, color2=color1)
    # Return if no width or not enough points
    return if vertices.size <= 2
    # Get Count
    count = vertices.size
    # Get Points
    #x1, y1, x2, y2 = vertices[-1] + vertices[0]
    # Draw Line
    #draw_line(x1, y1, x2, y2, stroke, color)
    # Shade if filled
    #cx,cy = vertices[-2]
    #shade_section(cx, cy, x1, y1, x2, y2, stroke, step, color) if filled
    # Run Through with next
    #vertices.each_with_next do |start, point|
    
    cx,cy = vertices[0]
    for i in 1..count-2
      # Get Points
      #x1, y1, x2, y2 = start + point
      x1, y1, x2, y2 = vertices[i] + vertices[i+1]
      # Draw Line
      #draw_line(x1, y1, x2, y2, stroke, color)
      # Shade if filled
      shade_section(cx, cy, x1, y1, x2, y2, color1, 1, color2)
    end
  end
  
  #-------------------------------------------------------------------------
  # * Draw polygon
  #     vertices : vertices to draw the polygon
  #     color1 : fill color 1 of the polygon
  #     stroke : size of the stroke of the polygon
  #     color2 : fill color 2 of the polygon (used for gradient) 
  #-------------------------------------------------------------------------
  def draw_polygon(vertices, color1, stroke=1, color2=color1)
    # Return if no width or not enough points
    return if stroke <= 0 || vertices.size <= 2
    # Get Count
    count = vertices.size

    for i in 0..count-1
      # Get Points
      #x1, y1, x2, y2 = start + point
      x1, y1, x2, y2 = vertices[i-1] + vertices[i]
      # Draw Line
      draw_line(x1, y1, x2, y2, color1, stroke, color2)
    end
  end
  
  #-------------------------------------------------------------------------
  # * Draw filled ellipse
  #     x : center of the circle X coordinate
  #     y : center of the circle Y coordinate
  #     a : distance from center to right side
  #     b : distance from center to top side
  #     color1 : fill color 1 of the circle
  #     color2 : fill color 2 of the circle (used for gradient) 
  #-------------------------------------------------------------------------
  def draw_filled_ellipse(x, y, a, b, color1, color2=color1)
    # Converts Each Argument to Float
    x, y, a, b = x.to_f, y.to_f, a.to_f, b.to_f
    # Gets Square of a and b values
    a2, b2 = a * a, b * b

    # Pass from center to right side
    for i in 0..b
      # Gets X Distance
      x_ = Integer(Math.sqrt(a2 * (1 - i ** 2 / b2)))
      # Draws Lines on Top & Bottom
      draw_line(x, y, x-x_, y-i, color1, 1, color2)
      draw_line(x, y, x-x_, y+i, color1, 1, color2)
      draw_line(x, y, x+x_, y-i, color1, 1, color2)
      draw_line(x, y, x+x_, y+i, color1, 1, color2)
    end
    # Pass from center to right side
    for i in 0..a
      # Gets Y Distance
      y_ = Integer(Math.sqrt(b2 * (1 - (i ** 2) / a2)))
      # Draws Lines on Each Side
      draw_line(x, y, x-i, y-y_, color1, 1, color2, true)
      draw_line(x, y, x+i, y-y_, color1, 1, color2, true)
      draw_line(x, y, x-i, y+y_, color1, 1, color2, true)
      draw_line(x, y, x+i, y+y_, color1, 1, color2, true)
    end

  end
    
  #-------------------------------------------------------------------------
  # * Draw ellipse
  #     x : center of the circle X coordinate
  #     y : center of the circle Y coordinate
  #     a : the distance from center to right side
  #     b : the distance from center to top side
  #     color1 : fill color 1 of the circle
  #     stroke : size of the stroke of the ellipse
  #     color2 : fill color 2 of the circle (used for gradient) 
  #-------------------------------------------------------------------------
  def draw_ellipse(x, y, a, b, color1, stroke=1, color2=color1)
    # Return if no width
    return if stroke <= 0
    
    # Converts Each Argument to Float
    x, y, a, b = x.to_f, y.to_f, a.to_f, b.to_f
    # Gets Square of a and b values
    a2, b2 = a * a, b * b
    # Gets Square of a and b values
    a2_2, b2_2 = (a+stroke) * (a+stroke), (b+stroke) * (b+stroke)
    
    # Pass from center to right side
    for i in 0..b
      # Gets X Distance
      x_ = Integer(Math.sqrt(a2 * (1 - i ** 2 / b2)))
      x2_ = Integer(Math.sqrt(a2_2 * (1 - i ** 2 / b2_2)))
      
      # Draws Lines on Top & Bottom
      draw_line(x-x2_, y-i, x-x_, y-i, color1, 1, color2)
      draw_line(x-x2_, y+i, x-x_, y+i, color1, 1, color2)
      draw_line(x+x2_, y-i, x+x_, y-i, color2, 1, color1)
      draw_line(x+x2_, y+i, x+x_, y+i, color2, 1, color1)
    end
    # Pass from center to right side
    for i in 0..a
      # Gets Y Distance
      y_ = Integer(Math.sqrt(b2 * (1 - (i ** 2) / a2)))
      y2_ = Integer(Math.sqrt(b2_2 * (1 - (i ** 2) / a2_2)))
      
      # Draws Lines on Each Side
      draw_line(x-i, y-y2_, x-i, y-y_, color1, 1, color2, true)
      draw_line(x+i, y-y2_, x+i, y-y_, color1, 1, color2, true)
      draw_line(x-i, y+y_, x-i, y+y2_, color2, 1, color1, true)
      draw_line(x+i, y+y_, x+i, y+y2_, color2, 1, color1, true)
    end

  end
  
  #-------------------------------------------------------------------------
  # * Shade section
  #     ox : origin section X coordinate
  #     oy : origin section Y coordinate
  #     x1 : first section X coordinate
  #     y1 : first section Y coordinate
  #     x2 : second section X coordinate
  #     y2 : second section Y coordinate
  #     c1 : fill color 1 of the section
  #     thick : line thickness
  #     c2 : fill color 2 of the section (used for gradient) 
  #-------------------------------------------------------------------------
  def shade_section(ox, oy, x1, y1, x2, y2, c1, thick=1, c2=c1)
    # Reverse all parameters sent if 2 x is less than the first x
    #x1, x2, y1, y2 = x2, x1, y2, y1 if x2 < x1    
    # Get Slope
    #slope = (y2 - y1).to_f / (x2 - x1)
    # If Slope is infinite
    #if slope.infinite?
    #  y1.step(y2, step) {|y| draw_line(cx, cy, x1, y, thick, color)}
    # If Slope is zero
    #elsif slope.zero?
    #  x1.step(x2, step) {|x| draw_line(cx, cy, x, y1, thick, color)}
    #elsif not slope.nan?
      # Get Y intercept
    #  yint = y1 - slope * x1
    #  x1.step(x2, step) {|x| draw_line(cx, cy, x, slope * x + yint, thick, color)}
    #end
    
    temp_x1 = x1
    temp_y1 = y1
    distance = (x1 - x2).abs + (y1 - y2).abs
    i = 1
    while temp_x1 != x2 || temp_y1 != y2
      draw_line(ox, oy, temp_x1, temp_y1, c1, thick, c2)
      temp_x1 = (x1 + 1.0 * (x2 - x1) * i / distance).to_i
      temp_y1 = (y1 + 1.0 * (y2 - y1) * i / distance).to_i
      i += 1
    end
  end
  
  #-------------------------------------------------------------------------
  # * Saves Bitmap to a PNG file memory stream
  #     bitmap : Bitmap object to save
  #     path : directory in Game folder
  #     mode : mode of writing
  #-------------------------------------------------------------------------
  def self.make_png(bitmap, path = '', mode = 0)
    Dir.make_dir(path) if path != ''
    Zlib::Png_File.open('temp.gz')   { |gz| gz.make_png(bitmap, mode) }
    Zlib::GzipReader.open('temp.gz') { |gz| $read = gz.read }
    # Add this to create a file
    #f = File.open(path + name + '.png', 'wb')
    #f.write($read)
    #f.close
    File.delete('temp.gz')
    return $read
  end
  
  #-------------------------------------------------------------------------
  # * Reads PNG to Bitmap
  #     temp_gz : stream of the PNG File
  #     path : directory in Game folder
  #-------------------------------------------------------------------------
  def self.read_png(temp_gz, path = '')
    Dir.make_dir(path) if path != ''
    f = File.open(path + 'temp.png', 'wb')
    f.write(temp_gz)
    f.close
    bitmap = Bitmap.new(path + 'temp.png')
    File.delete('temp.png')
    return bitmap
  end
  
  #--------------------------------------------------------------------------
  # * Update bitmap size
  #     width : new width
  #     height : new height
  #--------------------------------------------------------------------------
  def self.update_bitmap_size(bitmap, width, height)
    temp_font = bitmap.font.clone
    bitmap.dispose
    bitmap = Bitmap.new(width, height)
    bitmap.font = temp_font
    return bitmap
    #self.oy = 0
  end
  
  #//////////////////////////////////////////////////////////////////////////
  # * Private Methods
  #//////////////////////////////////////////////////////////////////////////
    
  #--------------------------------------------------------------------------
  # * Format text in multiline
  #     rect : rectangle in which the text will be drawn
  #     text : text to draw
  #     x_adjustment = X coordinate adjustment depending on multiline mode (see class description)
  #--------------------------------------------------------------------------
  def format_multiline(rect, text, x_adjustment=0)
    if (text == "")
      return text
    end
    
    text = text.lstrip
    subtext = ""
    size = get_text_width(text) + get_text_width(CORE_CONFIG::LINE_SEPARATOR) * 2
    while (size > (rect.width-x_adjustment) && text.length > 0)
      char = text[text.length-1, text.length]
      size -= get_text_width(char)
      subtext += char
      text = text.chop
    end
    subtext = subtext.reverse

    if ((text[text.length-1,text.length] != " ") && (subtext[0,1] != " ") &&
        (subtext[0,1] != ""))
      text += CORE_CONFIG::LINE_SEPARATOR
    end
    
    return text + CORE_CONFIG::END_LINE_CHARACTER + format_multiline(rect, subtext)
  end
  private :format_multiline
  
  #--------------------------------------------------------------------------
  # * Format text to cut the overflow
  #     rect : rectangle in which the text will be drawn
  #     text : text to draw
  #--------------------------------------------------------------------------
  def format_cut_overflow(rect, text)
    if (text == "")
      return text
    end
    
    text = text.strip
    size = get_text_width(text) + get_text_width(CORE_CONFIG::CUT_OVERFLOW_CHARACTER) * 2
    # built-in draw_text method can reduce the text width up to 60%, so
    # adjust the size to allow the text to be reduced normally before
    # adding the CUT_OVERFLOW_CHARACTER
    size = (size * 0.5).floor
    while (size > rect.width)
      char = text[text.length-1, text.length]
      size -= (get_text_width(char) * 0.5).floor
      text = text.chop
    end
    
    return text + CORE_CONFIG::CUT_OVERFLOW_CHARACTER
  end
  private :format_cut_overflow

end

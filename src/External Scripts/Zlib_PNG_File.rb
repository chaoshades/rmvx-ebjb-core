#==============================================================================
# ** Modules.Zlib
# Author: MACL Authors
# Version: 2.3
#------------------------------------------------------------------------------
# Adds PNG_File class to save Bitmap's to PNG Files.
#==============================================================================

#============================================================================== 
# ** Zlib     
#==============================================================================

module Zlib
  #============================================================================ 
  # ** Png_File     
  #============================================================================

  class Png_File < GzipWriter
    #--------------------------------------------------------------------------
    # * Make PNG
    #--------------------------------------------------------------------------
    def make_png(bitmap, mode = 0)
      # Save Bitmap & Mode
      @bitmap, @mode = bitmap, mode
      # Create & Save PNG
      self.write(make_header)
      self.write(make_ihdr)
      self.write(make_idat)
      self.write(make_iend)
    end
    #--------------------------------------------------------------------------
    # * Make Header
    #--------------------------------------------------------------------------
    def make_header
      return [0x89, 0x50, 0x4e, 0x47, 0x0d, 0x0a, 0x1a, 0x0a].pack('C*')
    end
    #--------------------------------------------------------------------------
    # * Make IHDR
    #--------------------------------------------------------------------------
    def make_ihdr
      ih_size               = [13].pack("N")
      ih_sign               = 'IHDR'
      ih_width              = [@bitmap.width].pack('N')
      ih_height             = [@bitmap.height].pack('N')
      ih_bit_depth          = [8].pack('C')
      ih_color_type         = [6].pack('C')
      ih_compression_method = [0].pack('C')
      ih_filter_method      = [0].pack('C')
      ih_interlace_method   = [0].pack('C')
      string = ih_sign + ih_width + ih_height + ih_bit_depth + ih_color_type +
               ih_compression_method + ih_filter_method + ih_interlace_method
      ih_crc = [Zlib.crc32(string)].pack('N')
      return ih_size + string + ih_crc
    end
    #--------------------------------------------------------------------------
    # * Make IDAT
    #--------------------------------------------------------------------------
    def make_idat
      header  = "\x49\x44\x41\x54"
      data    = @mode == 0 ? make_bitmap_data0 : make_bitmap_data1
      data    = Zlib::Deflate.deflate(data, 8)
      crc     = [Zlib.crc32(header + data)].pack('N')
      size    = [data.length].pack('N')
      return size + header + data + crc
    end
    #--------------------------------------------------------------------------
    # * Make Bitmap Data 0
    #--------------------------------------------------------------------------
    def make_bitmap_data0
      gz = Zlib::GzipWriter.open('hoge.gz')
      t_Fx = 0
      w = @bitmap.width
      h = @bitmap.height
      data = []
      for y in 0...h
        data.push(0)
        for x in 0...w
          t_Fx += 1
          if t_Fx % 10000 == 0
            Graphics.update
          end
          if t_Fx % 100000 == 0
            s = data.pack("C*")
            gz.write(s)
            data.clear
          end
          color = @bitmap.get_pixel(x, y)
          red = color.red
          green = color.green
          blue = color.blue
          alpha = color.alpha
          data.push(red)
          data.push(green)
          data.push(blue)
          data.push(alpha)
        end
      end
      s = data.pack("C*")
      gz.write(s)
      gz.close   
      data.clear
      gz = Zlib::GzipReader.open('hoge.gz')
      data = gz.read
      gz.close
      File.delete('hoge.gz')
      return data
    end
    #--------------------------------------------------------------------------
    # * Make Bitmap Data Mode 1
    #--------------------------------------------------------------------------
    def make_bitmap_data1
      w = @bitmap.width
      h = @bitmap.height
      data = []
      for y in 0...h
        data.push(0)
        for x in 0...w
          color = @bitmap.get_pixel(x, y)
          red = color.red
          green = color.green
          blue = color.blue
          alpha = color.alpha
          data.push(red)
          data.push(green)
          data.push(blue)
          data.push(alpha)
        end
      end
      return data.pack("C*")
    end
    #--------------------------------------------------------------------------
    # * Make IEND
    #--------------------------------------------------------------------------
    def make_iend
      ie_size = [0].pack('N')
      ie_sign = 'IEND'
      ie_crc  = [Zlib.crc32(ie_sign)].pack('N')
      return ie_size + ie_sign + ie_crc
    end
  end
end

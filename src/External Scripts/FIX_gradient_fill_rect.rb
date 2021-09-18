#==============================================================================
# ** Wortana's 'gradient_fill_rect' Bug Fix
# Author: Wortana
# Version: 1.0
#------------------------------------------------------------------------------
# Bug Fix for the horizontal gradient which don't work by default.
#==============================================================================

class Bitmap
  #--------------------------------------------------------------------------
  # * Wortana's 'gradient_fill_rect' Bug Fix
  #--------------------------------------------------------------------------
  alias gradient_original gradient_fill_rect unless method_defined?('gradient_original')
  def gradient_fill_rect(*args)
    args.pop if !args.last if args.size == 4 || 7 and !args.last
    gradient_original(*args)
  end
end
